# Jarosław Socha
# program liczący floatmax dla Float16

maxval = Float16(1.0)

# mnożymy przez 2 aż do overflowa
while !isinf(Float16(maxval * 2))
    global maxval = maxval * 2
end

adder = copy(maxval) / 2

# zmniejszamy składnik dopóki nie osiągniemy nieskończoności
while !isinf(Float16(maxval + adder))
    global maxval = maxval + adder
    global adder = adder / 2
end


println("Wynik:       ", maxval)
println(bitstring(maxval))
println()
println("Sprawdzenie: ", floatmax(Float16))
println(bitstring(floatmax(Float16)))