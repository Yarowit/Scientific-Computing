# Jarosław Socha
# program testujący zadanie 5b

include("Interpolate.jl")
using .Interpolate
using Plots

f = x -> x^2 * sin(x)

plot(
    rysujNnfxNaPrzedziale(f, -1., 1., 5 ,-3.,3.),
    rysujNnfxNaPrzedziale(f, -1., 1., 10,-3.,3.),
    rysujNnfxNaPrzedziale(f, -1., 1., 15,-3.,3.),
    layout=(1,3),
    size=(1050,350),
    dpi=300
)

savefig("5b.png")