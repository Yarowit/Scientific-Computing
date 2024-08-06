include("RootsFinder.jl")
using .RootsFinder

f = x -> sin(x) - (0.5*x)^2
pf = x -> cos(x) - 0.5 * x

println(mbisekcji(f, 1.5, 2.0, 0.5e-5, 0.5e-5))
println(mstycznych(f, pf, 1.5, 0.5e-5, 0.5e-5, 30))
println(msiecznych(f, 1.0, 2.0, 0.5e-5, 0.5e-5, 30))