# Jarosław Socha
# program liczący wyrażenie sqrt(x^2 + 1) - 1

f = Float64[]
g = Float64[]
r = 1:16
for i in r
    x = Float64(8.0^(-i))
    push!(f, Float64(sqrt(x^2 + 1) - 1))
    push!(g, Float64(x^2 / (sqrt(x^2 + 1) + 1)))
end

println(f)
println(g)