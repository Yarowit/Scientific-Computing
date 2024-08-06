# Jarosław Socha
# program liczący floatmax dla Float64

maxval = Float64(1.0)

# mnożymy przez 2 aż do overflowa
while !isinf(Float64(maxval * 2))
    global maxval = maxval * 2
end

adder = copy(maxval) / 2

# zmniejszamy składnik dopóki nie osiągniemy nieskończoności
while !isinf(Float64(maxval + adder))
    global maxval = maxval + adder
    global adder = adder / 2
end


println("Wynik:       ", maxval)
println(bitstring(maxval))
println()
println("Sprawdzenie: ", floatmax(Float64))
println(bitstring(floatmax(Float64)))