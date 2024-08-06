# Jarosław Socha
# program testujący zadanie 6b

include("Interpolate.jl")
using .Interpolate
using Plots

f = x -> 1/(1+x^2)

plot(
    rysujNnfxNaPrzedziale(f, -5., 5., 5 ,-7.2,7.2),
    rysujNnfxNaPrzedziale(f, -5., 5., 10,-5.,5.),
    rysujNnfxNaPrzedziale(f, -5., 5., 15,-5.,5.),
    layout=(1,3),
    size=(1050,350),
    dpi=300
)

savefig("6b.png")