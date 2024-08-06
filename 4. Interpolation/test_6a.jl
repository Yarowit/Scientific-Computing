# Jarosław Socha
# program testujący zadanie 6a

include("Interpolate.jl")
using .Interpolate
using Plots

f = x -> abs(x)

plot(
    rysujNnfxNaPrzedziale(f, -1., 1., 5 ,-1.2,1.2),
    rysujNnfxNaPrzedziale(f, -1., 1., 10,-1.,1.),
    rysujNnfxNaPrzedziale(f, -1., 1., 15,-1.,1.),
    layout=(1,3),
    size=(1050,350),
    dpi=300
)

savefig("6a.png")