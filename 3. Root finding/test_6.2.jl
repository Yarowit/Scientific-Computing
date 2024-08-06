include("RootsFinder.jl")
using .RootsFinder

f2 = x -> x * exp(-x)
pf2 = x -> exp(-x) - x*exp(-x)

X = [1.2,2.0,3.0,1.0]

for x in X
    println(x," ",mstycznych(f2, pf2, x, 1e-5, 1e-5, 1000))
end