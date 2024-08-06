# Jarosław Socha
# program testujący dwa sposoby rozwiązywania układu równań za pomocą macierzy

using LinearAlgebra

function hilb(n::Int)
    # Function generates the Hilbert matrix  A of size n,
    #  A (i, j) = 1 / (i + j - 1)
    # Inputs:
    #	n: size of matrix A, n>=1
    #
    #
    # Usage: hilb(10)
    #
    # Pawel Zielinski
    if n < 1
        error("size n should be >= 1")
    end
    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

function matcond(n::Int, c::Float64)
    # Function generates a random square matrix A of size n with
    # a given condition number c.
    # Inputs:
    #	n: size of matrix A, n>1
    #	c: condition of matrix A, c>= 1.0
    #
    # Usage: matcond(10, 100.0)
    #
    # Pawel Zielinski
    if n < 2
        error("size n should be > 1")
    end
    if c< 1.0
        error("condition number  c of a matrix  should be >= 1.0")
    end
    (U,S,V)=svd(rand(n,n))
    return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end

function Gauss(A::Base.Matrix, n::Int)
    # prawdziwe rozwiązanie
    X = (ones(n))

    # macierz prawych stron
    b = (A*X)

    # metoda eliminacji Gaussa
    x = A \ b

    return x
end

function Inverse(A::Base.Matrix,n::Int)
    # prawdziwe rozwiązanie
    X = (ones(n))

    # macierz prawych stron
    b = (A*X)
    
    # metoda macierzy odwrotnej
    x = inv(A) * b

    return x
end

function experiment()
    println("Hilbert")
    for n in 2:20
        println("n: ",n)
        A = hilb(n)
        x = ones(n)
        g = Gauss(A,n)
        println("   g: ",norm(g-x)/norm(x))
        i = Inverse(A,n)
        println("   i: ",norm(i-x)/norm(x))
    end
    println("cond")
    for n in (5,10,20)
        for c in (1.0, 10.0, 10.0^3, 10.0^7, 10.0^12, 10.0^16)
            x = ones(n)
            print("n: ",n)
            print(" c: ")
            println(c)
            A = matcond(n,c)
            g = Gauss(A,n)
            println("   g: ",norm(g-x)/norm(x))
            i = Inverse(A,n)
            println("   i: ",norm(i-x)/norm(x))
        end
    end
end


experiment()
