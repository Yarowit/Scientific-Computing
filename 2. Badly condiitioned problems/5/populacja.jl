# Jarosław Socha
# Program sprawdzający błędy w symulowaniu populacji iteracyjnie

function population32()
    p::Float32 = 0.01
    r::Float32 = 3.0
    
    for n in 1:40
        p = Float32(p+ Float32( Float32(r*p) * Float32(1.0 - p)))
    end

    return p
end

function population32_modified()
    p::Float32 = 0.01
    r::Float32 = 3.0
    
    for n in 1:10
        p = Float32(p+ Float32( Float32(r*p) * Float32(1.0 - p)))
    end
    p = trunc(p,digits=3)
    println("-> ",p)
    for n in 11:40
        p = Float32(p+ Float32( Float32(r*p) * Float32(1.0 - p)))
    end

    return p
end

function population64()
    p = 0.01
    r = 3.0
    
    for n in 1:40
        p = p+ r*p * (1.0 - p)
    end

    return p
end

println("F32:  ",population32())
println("F32+: ",population32_modified())
println("F64:  ",population64())