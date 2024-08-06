# Jarosław Socha
# program liczący odstępy między liczbami


delta = Float64(2^(-52))
step = Float64(2^(-4))
x = Float64(1.0)

doesItWork = true

while x < 2
    if x + delta != nextfloat(x)
        global doesItWork = false
        break
    end
    global x = x + step
end

println(doesItWork)


# Wykres

# krok próbkowania
step = Float64(2^(-4))
x = Float64(0.25)

xax = Float64[]
yax = Float64[]


while x < 4
    push!(xax,x)
    push!(yax,nextfloat(x)-x)
    
    global x = x + step
end

using Plots:plot
plot(xax,yax,legend=false)