include("RootsFinder.jl")
using .RootsFinder

f = x -> exp(x) - 3*x

println(f(0)," ",f(1)," ",f(2))
# f(0) = 1
# f(1) = -0.28...
# f(2) = 1.38...
# dla x < 0 f(x) jest dodatnia
# dla x > 2 f(x) jest dodatnia

# przedział [0,1]
println(mbisekcji(f, 0.0, 1.0, 1e-4, 1e-4))
# przedział [1,2]
println(mbisekcji(f, 1.0, 2.0, 1e-4, 1e-4))