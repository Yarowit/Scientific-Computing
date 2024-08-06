# Jarosław Socha
# moduł implementujący eliminację Gaussa i rozkład LU
# dla konkretnej postaci macierzy chemicznej


module blocksys

    export LoadMatrix, Gauss, GenerateLU, SolveLU, GenerateB, LoadB, PrintSolutionToFile,PrintComparisonToFile, TestGauss, TestLU

    # Struktura przechowująca elementy chemicznej macierzy

    struct CheMatrix
        n::Int
        l::Int
        A::Vector{Matrix} 
        B::Vector{Vector}
        C::Vector{Matrix}
        P::Vector{Int}
    end

    CheMatrix(n,l) = CheMatrix(
        n, l,
        [zeros((l,l)) for i=1:div(n,l)],
        [zeros((l)) for i=1:(div(n,l)-1)],
        [zeros((l,l)) for i=1:(div(n,l)-1)],
        [i for i=1:n]
    )

    function Base.getindex(CM::CheMatrix, x::Int, y::Int)
        X = div( x-1 , CM.l ) + 1 
        Y = div( y-1 , CM.l ) + 1 
        i = (x-1) % CM.l + 1 
        j = (y-1) % CM.l + 1 
        
        # macierz A 
        if X == Y
            return CM.A[X][i,j]
        end
    
        # macierz C 
        if X + 1 == Y
            return CM.C[X][i,j]
        end
        
        # macierz B
        if Y + 1 == X && j == CM.l
            return CM.B[Y][i]
        end
    
        return 0.0
        # throw(BoundsError(CM, (x, y)))
    end
    
    function Base.setindex!(CM::CheMatrix, v::Float64, x::Int, y::Int)
        X = div( x-1 , CM.l ) + 1
        Y = div( y-1 , CM.l ) + 1
        i = (x-1) % CM.l + 1
        j = (y-1) % CM.l + 1
    
        # macierz A
        if X == Y
            CM.A[X][i,j] = v
            return
        end
    
        # macierz C 
        if X + 1 == Y
           CM.C[X][i,j] = v
           return
        end
    
        # macierz B
        if Y + 1 == X && j == CM.l
            CM.B[Y][i] = v
            return
        end
    
        throw(BoundsError(CM, (x, y)))
    end
    
    #------------ Algorytmy -----------------------

    function GaussNoChoice(M::CheMatrix, b::Vector)
        n = M.n
        l = M.l
    
    
        # sekcje 
        S = div(n, l)
        start = 1
        
        # sekcje
        for s in 0:(S-1)
            # rząd główny w sekcji
            for mainRow in start:(l-1)
                # pierwszy element
                L0 = s * l + mainRow
                mainElement = M[L0, L0] 
                # rzędy
                for row in (L0+1):((s+1)*l)
                    # mnożnik
                    mult = M[row, L0] / mainElement 
                    # kolumny
                    for column in (L0+1):min((L0+l),n)
                        M[row, column] -= M[L0, column] * mult
                    end
                    # prawe strony
                    b[row] -= b[L0] * mult
                end
            end
            start = 0
        end
    
        # druga część
    
        for column in n:-1:2
            # dzielimy aby dostać jedynkę
            b[column] /= M[column,column] 
            # zmiana w rzędach powyżej
            for row in (column-1):-1:max((column-l),1)
                b[row] -= b[column] * M[row, column]
            end
        end
        
        b[1] /= M[1,1]

        return b
    end
    
    function GaussPartialChoice(M::CheMatrix, b::Vector)
        # MODYFIKACJE
        # dodano tu częściowy wybór, do rzędów dostajemy się przez 
        # wektor permutacji P
        n = M.n
        l = M.l
    
        P = M.P
    
        # sekcje 
        S = div(n, l)
    
        start = 1
        
        for s in 0:(S-1)

            for L0 in (s*l+start):(s*l+l-1)
    
                # częściowy wybór
    
                # szukamy maksymalnego co do wartości elementu głównego
                maxRowIndex = L0
                maxVal = M[P[maxRowIndex],L0]

                # nie sprawdzamy dla złączeń sekcji
                if L0%l != 0
                    for rowIndex in (L0+1):((s+1)*l)
                        val = M[P[rowIndex], L0]
                        if abs(val) > abs(maxVal)
                            maxRowIndex = rowIndex
                            maxVal = val
                        end
                    end
                    
                    # zmienić permutację
                    temp = P[maxRowIndex]
                    P[maxRowIndex] = P[L0]
                    P[L0] = temp
                end

                mainElement = maxVal
                mainRow = P[L0]
                mainColumn = L0
                
                
                # rząd
                for R in (L0+1):((s+1)*l)
                    row = P[R]
                    # mnożnik
                    mult = M[row, mainColumn] / mainElement 
                    
                    for column in (mainColumn+1):min(n,((div(mainRow-1,l)+2)*l))
                        M[row, column] -= M[mainRow, column] * mult
                    end
                    b[row] -= b[mainRow] * mult
                end
            end
            start = 0
        end
        
        for column in n:-1:2
            mainRow = P[column]
            # dzielimy aby dostać jedynkę
            b[mainRow] /= M[mainRow,column] 
            
            for r in (column-1):-1:max(1,(column-l - (column-1) % l ))
                row = P[r]
                b[row] -= b[mainRow] * M[row, column]
                M[row,column] = 0.0
            end
        end
        
        b[P[1]] /= M[P[1],1]

        
        return [b[i] for i in P]
    end


    function GenerateLU_NoChoice(M::CheMatrix)
        n = M.n
        l = M.l
    
        # sekcje 
        S = div(n, l)
        start = 1
    
        for s in 0:(S-1)
            # główny rząd
            for mainRow in start:(l-1)
                # pierwszy element
                L0 = s * l + mainRow
                mainElement = M[L0, L0] 
                # rząd
                for row in (L0+1):((s+1)*l)
                    # mnożnik
                    mult = M[row, L0] / mainElement 
                    # element macierzy L
                    M[row, L0] = mult
                    for column in (L0+1):min((L0+l),n)
                        M[row, column] -= M[L0, column] * mult
                    end
                end
            end
            start = 0
        end
    end

    function GenerateLU_PartialChoice(M::CheMatrix)
        n = M.n
        l = M.l
        P = M.P
        
    
        # sekcje 
        S = div(n, l)
    
        start = 1
        
        # sekcje
        for s in 0:(S-1)
            # główny rząd
            for L0 in (s*l+start):(s*l+l-1)
    
                # częściowy wybór
    
                # szukamy maksymalnego elementu głównego
                maxRowIndex = L0
                maxVal = M[P[maxRowIndex],L0]

                # nie sprawdzamy dla złączeń
                if L0%l != 0
                    for rowIndex in (L0+1):((s+1)*l)
                        val = M[P[rowIndex], L0]
                        if abs(val) > abs(maxVal)
                            maxRowIndex = rowIndex
                            maxVal = val
                        end
                    end
                    
                    # zmienić permutację
                    temp = P[maxRowIndex]
                    P[maxRowIndex] = P[L0]
                    P[L0] = temp
                end

                mainElement = maxVal
                mainRow = P[L0]
                mainColumn = L0
                
                
                # rząd
                for R in (L0+1):((s+1)*l)
                    row = P[R]
                    # mnożnik
                    mult = M[row, mainColumn] / mainElement 
                    # element macierzy L
                    M[row,mainColumn] = mult
                    for column in (mainColumn+1):min(n,((div(mainRow-1,l)+2)*l))
                        M[row, column] -= M[mainRow, column] * mult
                    end
                end
            end
            start = 0
        end

        return P
    end


    function SolveLU(M::CheMatrix,b::Vector)
        b = deepcopy(b)
        n = M.n
        l = M.l
        P = M.P
    
        # sekcje 
        S = div(n, l)
        start = 1
        # Pierwsza część
        for s in 0:(S-1)
            for L0 in (s*l+start):(s*l+l-1)
                # rząd
                for R in (L0+1):((s+1)*l)
                    row = P[R]
                    b[row] -= b[P[L0]] * M[row,L0]
                end
            end
            start = 0
        end

        # druga część
        for column in n:-1:2
            mainRow = P[column]
            # dzielimy aby dostać jedynkę
            b[mainRow] /= M[mainRow,column] 
            for r in (column-1):-1:max(1,(column-l - (column-1) % l ))
                row = P[r]
                b[row] -= b[mainRow] * M[row, column]
            end
        end
        
        b[P[1]] /= M[P[1],1]

        # zwracamy wektor b po przepuszczeniu przez wektor permutacji
        return [b[i] for i in P]
    end

    #------------ Otoczka -----------------------

    function LoadMatrix(name::String)
        open(name) do f
    
            data = split(readline(f))
            
            n = parse(Int, data[1])
            l = parse(Int, data[2])
            
            # Deklaracja struktury CheMatrix
            matrix = CheMatrix(n,l)
            
    
            while !eof(f)          
                line = split(readline(f))
    
                x = parse(Int, line[1])
                y = parse(Int, line[2])
                v = parse(Float64, line[3])
    
                matrix[x,y] = v
            end
            close(f)
            return matrix
        end
    end

    function Gauss(A::CheMatrix, b::Vector, partialChoice::Bool)
        M = deepcopy(A)
        v = deepcopy(b)
        if partialChoice
            v = GaussPartialChoice(M, v)
        else
            v = GaussNoChoice(M, v)
        end
        return v
    end

    function GenerateLU(A::CheMatrix, partialChoice::Bool)
        M = deepcopy(A)
        if partialChoice
            GenerateLU_PartialChoice(M)
        else
            GenerateLU_NoChoice(M)
        end
        return M
    end

    function GenerateB(M::CheMatrix)
        n = M.n
        l = M.l
        b = zeros(n)
        start = 1
        for s in 0:(div(n, l)-1)
            # główny rząd
            L0 = s*l
            for mainRow in (L0+1):(L0+l)
                for column in (L0+start):min(L0+2*l+2,n)
                    b[mainRow] += M[mainRow,column]
                end
            end
            start = 0
        end
        return b
    end

    function LoadB(name::String)
        open(name) do f
    
            data = readline(f)
            
            n = parse(Int, data)
            
            b = zeros(n)
            
            i = 1
            while !eof(f)          
                line = readline(f)
    
                v = parse(Float64, line)
    
                b[i] = v
    
                i += 1
            end
            close(f)
            return b
        end
    end

    function relativeError(b::Vector)
        s = 0
        for el in b
            s += (el - 1)^2
        end
        return sqrt(s/size(b,1))
    end

    function PrintSolutionToFile(name::String, b::Vector)
        open(name, "w") do file
            for line in b
                write(file, string(line),"\n")
            end
        end
    end

    function PrintComparisonToFile(name::String, b::Vector)
        s = 0
        for el in b
            s += (el - 1)^2
        end
        s =  sqrt(s/size(b,1))

        open(name, "w") do file
            write(file,string(s),"\n")
            for line in b
                write(file, string(line),"\n")
            end
        end
    end

    function TestGauss(FolderName::String)
        A = LoadMatrix(FolderName * "/A.txt")
        b = LoadB(FolderName * "/b.txt")

        try
            mkdir(FolderName*"/Gauss")
        catch
        end

        println("Eliminacja Gaussa")
        println("Folder: ",FolderName)
        println()
        println("Bez wyboru:")
        @time s = Gauss(A,b,false)
        PrintSolutionToFile(FolderName*"/Gauss/NoChoice",s)
        println("Częściowy wybór:")
        @time s = Gauss(A,b,true)
        PrintSolutionToFile(FolderName*"/Gauss/PartialChoice",s)

        b = GenerateB(A)

        println("Bez wyboru:")
        @time s = Gauss(A,b,false)
        PrintComparisonToFile(FolderName*"/Gauss/Comparison-NoChoice",s)
        println("Częściowy wybór:")
        @time s = Gauss(A,b,true)
        PrintComparisonToFile(FolderName*"/Gauss/Comparison-PartialChoice",s)
        println()
    end

    function TestLU(FolderName::String)
        A = LoadMatrix(FolderName * "/A.txt")
        b = LoadB(FolderName * "/b.txt")

        try
            mkdir(FolderName*"/LU")
        catch
        end

        println("Metoda LU")
        println("Folder: ",FolderName)
        println()
        println("Bez wyboru:")
        @time LU = GenerateLU(A,false)
        @time s = SolveLU(LU,b)
        PrintSolutionToFile(FolderName*"/LU/NoChoice",s)
        println("Częściowy wybór:")
        @time LU = GenerateLU(A,true)
        @time s = SolveLU(LU,b)
        PrintSolutionToFile(FolderName*"/LU/PartialChoice",s)

        b = GenerateB(A)

        println("Bez wyboru:")
        @time LU = GenerateLU(A,false)
        @time s = SolveLU(LU,b)
        PrintComparisonToFile(FolderName*"/LU/Comparison-NoChoice",s)
        println("Częściowy wybór:")
        @time LU = GenerateLU(A,true)
        @time s = SolveLU(LU,b)
        PrintComparisonToFile(FolderName*"/LU/Comparison-PartialChoice",s)
        println()
    end

end