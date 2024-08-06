# Jarosław Socha
# program liczący najmniejsze x, że x * (1/x) != 1

x = Float64(1)

delta = Float64(2^(-52))

x = x+delta

while Float64(x*Float64(1.0/x)) == 1 && x < 2
    global x = x + delta
end

println("X to ",x)
println("1/X to ",Float64(1.0/x))

println("1/x * x to ",Float64(x*Float64(1.0/x)))