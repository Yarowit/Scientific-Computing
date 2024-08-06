# Jarosław Socha
# program testujący zadanie 5a

include("Interpolate.jl")
using .Interpolate
using Plots

f = x -> exp(x)

plot(
    rysujNnfxNaPrzedziale(f, 0., 1., 5 ,0.,1.),
    rysujNnfxNaPrzedziale(f, 0., 1., 10,0.,1.),
    rysujNnfxNaPrzedziale(f, 0., 1., 15,0.,1.),
    layout=(1,3),
    size=(1050,350),
    dpi=300
)

savefig("5a.png")