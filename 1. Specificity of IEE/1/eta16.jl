# Jarosław Socha
# program liczący eta dla Float16

eta = Float16(1.0)
while Float16(eta / 2) > 0.0
    global eta = eta / 2
end

println("Wynik:       ", eta)
println(bitstring(eta))
println()
println("Sprawdzenie: ", nextfloat(Float16(0.0)))
println(bitstring(nextfloat(Float16(0.0))))
println()
println("floatmin: ", floatmin(Float16))
println(bitstring(floatmin(Float16)))