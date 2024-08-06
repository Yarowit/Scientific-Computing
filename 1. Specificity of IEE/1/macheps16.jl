# Jarosław Socha
# program liczący macheps dla Float16

macheps = Float16(1.0)

while Float16(1.0 + macheps/2) > 1 && Float16(1.0 + macheps/2) == 1.0 + macheps/2
    global macheps = macheps / 2
end

println("Wynik:       ", macheps)
println(bitstring(macheps))
println()
println("Sprawdzenie: ", eps(Float16))
println(bitstring(eps(Float16)))

# float.h: Nie znalazłem