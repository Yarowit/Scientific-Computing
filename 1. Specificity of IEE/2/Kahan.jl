# Jarosław Socha
# program sprawdzający tezę Kahana

println("Poprawny 16: ", eps(Float16))
println("Kahan 16:    ", Float16(Float16(3*Float16(Float16(4/3)-1))-1))

println("Poprawny 32: ", eps(Float32))
println("Kahan 32:    ", Float32(Float32(3*Float32(Float32(4/3)-1))-1))

println("Poprawny 64: ", eps(Float64))
println("Kahan 64:    ", Float64(Float64(3*Float64(Float64(4/3)-1))-1))
