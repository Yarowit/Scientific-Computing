# Jarosław Socha
# program spradzający jak małe zmiany w danych iloczynu skalarnego zmieniają wynik

x1 = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
x2 = [2.718281828, -3.141592654, 1.414213562, 0.577215664 , 0.301029995 ]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

function a(x,y,n)
    S = Float64(0)
    for i in 1:n
        S =Float64(S + x[i] * y[i])
    end
    return S
end

function b(x,y,n)
    S = Float64(0)
    for i in 1:n
        S = Float64(S + x[n-i+1] * y[n-i+1])
    end
    return S
end

function c(x,y,n)
    pos = []
    neg = []
    for i in 1:n
        z = x[i] * y[i]
        if z > 0
            push!(pos,z)
        else
            push!(neg,z)
        end
    end

    posSum = Float64(0)
    sort!(pos,rev=true)
    for el in pos
        posSum += Float64(posSum + el)
    end

    negSum = Float64(0)
    sort!(neg)
    for el in neg
        negSum += Float64(negSum + el)
    end

    return Float64(posSum + negSum)
end

function d(x,y,n)
    pos = []
    neg = []
    for i in 1:n
        z = x[i] * y[i]
        if z > 0
            push!(pos,z)
        else
            push!(neg,z)
        end
    end
    
    posSum = Float64(0)
    sort!(pos)
    for el in pos
        posSum += Float64(posSum + el)
    end

    negSum = Float64(0)
    sort!(neg,rev=true)
    for el in neg
        negSum += Float64(negSum + el)
    end

    return Float64(posSum + negSum)
end

function experiment(x,y)
    print("1) ")
    println(a(x,y,5))
    print("2) ")
    println(b(x,y,5))
    print("3) ")
    println(c(x,y,5))
    print("4) ")
    println(d(x,y,5))
end


function diff(x1,x2,y)
    print("1) ")
    println(abs((a(x1,y,5) - a(x2,y,5))/a(x1,y,5)))
    print("2) ")
    println(abs((b(x1,y,5) - b(x2,y,5))/b(x1,y,5)))
    print("3) ")
    println(abs((c(x1,y,5) - c(x2,y,5))/c(x1,y,5)))
    print("4) ")
    println(abs((d(x1,y,5) - d(x2,y,5))/d(x1,y,5)))
end

println("Oryginalny x:")
experiment(x1,y)

println("Zmodyfikowany x:")
experiment(x2,y)

println("Błąd względny:")
diff(x1,x2,y)