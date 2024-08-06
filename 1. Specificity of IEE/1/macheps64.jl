# Jarosław Socha
# program liczący macheps dla Float64

macheps = Float64(1.0)

while Float64(1.0 + macheps/2) > 1 && Float64(1.0 + macheps/2) == 1.0 + macheps/2
    global macheps = macheps / 2
end

println("Wynik:       ", macheps)
println(bitstring(macheps))
println()
println("Sprawdzenie: ", eps(Float64))
println(bitstring(eps(Float64)))

# float.h: 2.22044604925031308084726333618164062e-16F64