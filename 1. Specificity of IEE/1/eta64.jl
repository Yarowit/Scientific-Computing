# Jarosław Socha
# program liczący eta dla Float64

eta = Float64(1.0)
while Float64(eta / 2) > 0.0
    global eta = eta / 2
end

println("Wynik:       ", eta)
println(bitstring(eta))
println()
println("Sprawdzenie: ", nextfloat(Float64(0.0)))
println(bitstring(nextfloat(Float64(0.0))))
println()
println("floatmin: ", floatmin(Float64))
println(bitstring(floatmin(Float64)))