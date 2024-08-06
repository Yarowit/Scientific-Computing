# Jarosław Socha
# program liczący iloczyn skalarny różnymi metodami

x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

function a(x,y,n)
    S = Float32(0)
    for i in 1:n
        S =Float32(S + x[i] * y[i])
    end
    return S
end

function b(x,y,n)
    S = Float32(0)
    for i in 1:n
        S = Float32(S + x[n-i+1] * y[n-i+1])
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

    posSum = Float32(0)
    sort!(pos,rev=true)
    for el in pos
        posSum += Float32(posSum + el)
    end

    negSum = Float32(0)
    sort!(neg)
    for el in neg
        negSum += Float32(negSum + el)
    end

    return Float32(posSum + negSum)
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
    
    posSum = Float32(0)
    sort!(pos)
    for el in pos
        posSum += Float32(posSum + el)
    end

    negSum = Float32(0)
    sort!(neg,rev=true)
    for el in neg
        negSum += Float32(negSum + el)
    end

    return Float32(posSum + negSum)
end

print("1) ")
println(a(x,y,5))
print("2) ")
println(b(x,y,5))
print("3) ")
println(c(x,y,5))
print("4) ")
println(d(x,y,5))