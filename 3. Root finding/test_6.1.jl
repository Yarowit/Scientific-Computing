include("RootsFinder.jl")
using .RootsFinder

f1 = x -> exp(1-x) - 1
pf1 = x -> -exp(1-x)

X = [2.0,4.0,6.0,7.57,7.58,10.0]

for x in X
    println(x," ",mstycznych(f1, pf1, x, 1e-5, 1e-5, 1000))
end