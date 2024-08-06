include("RootsFinder.jl")
using .RootsFinder

f1 = x -> exp(1-x) - 1
f2 = x -> x * exp(-x)

pf1 = x -> -exp(1-x)
pf2 = x -> exp(-x) - x*exp(-x)


# f1
println(mbisekcji(f1, 0.0, 2.0, 1e-5, 1e-5))
println(mstycznych(f1, pf1, 0.0, 1e-5, 1e-5, 30))
println(msiecznych(f1, 0.0, 0.5, 1e-5, 1e-5, 30))
# zaburzenie
println(mbisekcji(f1, 0.5, 2.0, 1e-5, 1e-5))

# f2
println(mbisekcji(f2, -1.0, 1.0, 1e-5, 1e-5))
println(mstycznych(f2, pf2, -1.0, 1e-5, 1e-5, 30))
println(msiecznych(f2, -1.0, -0.5, 1e-5, 1e-5, 30))
# zaburzenie
println(mbisekcji(f2, -0.5, 1.0, 1e-5, 1e-5))