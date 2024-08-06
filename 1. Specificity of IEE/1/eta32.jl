# Jarosław Socha
# program liczący eta dla Float32

eta = Float32(1.0)
while Float32(eta / 2) > 0.0
    global eta = eta / 2
end

println("Wynik:       ", eta)
println(bitstring(eta))
println()
println("Sprawdzenie: ", nextfloat(Float32(0.0)))
println(bitstring(nextfloat(Float32(0.0))))
println()
println("floatmin: ", floatmin(Float32))
println(bitstring(floatmin(Float32)))