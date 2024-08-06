# Jarosław Socha
# program liczący macheps dla Float32

macheps = Float32(1.0)

while Float32(1.0 + macheps/2) > 1 && Float32(1.0 + macheps/2) == 1.0 + macheps/2
    global macheps = macheps / 2
end

println("Wynik:       ", macheps)
println(bitstring(macheps))
println()
println("Sprawdzenie: ", eps(Float32))
println(bitstring(eps(Float32)))

# float.h: 1.19209289550781250000000000000000000e-7F32