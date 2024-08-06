# Jarosław Socha
# Program spradzający poprawność liczenia granicy funkcji

function f(x)
    return MathConstants.e ^ x * log1p(MathConstants.e ^ (-x))
end

i = 0

while !isnan(f(2.0^i))
    println(2^i)
    println("-> ",f(2.0^i))
    global i = i + 1
end

# kroki sprawdzania granicy
n = [2^9+2^7,
    2^9+2^7+2^6,
    2^9+2^7+2^6+2^2,
    2^9+2^7+2^6+2^5,
    2^9+2^7+2^6+2^5+2^4,
    ]
    
for i in n
    println(i)
    println("-> ",f(i))
end