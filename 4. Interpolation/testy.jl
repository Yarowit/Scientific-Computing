include("Interpolate.jl")
using .Interpolate

f = x -> exp(x)

x = [1.,2.,3.,4.]
y = [f(1.),f(2.),f(3.),f(4.)]

fx = ilorazyRoznicowe(x,y)
println(naturalna(x,fx))