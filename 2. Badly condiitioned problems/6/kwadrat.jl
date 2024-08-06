# Jarosław Socha
# Program sprawdzający błędy w iteracyjnej formule x^2 + c

function square(x_0, c)
    x = x_0
    for n in 1:40
        x = x*x + c
    end

    return x
end

X_0 = [1,
    2,
    1.99999999999999,
    1,
    -1,
    0.75,
    0.25
]

C = [-2,
    -2,
    -2,
    -1,
    -1,
    -1,
    -1
]

for i in 1:7
    print("x_0 = ", X_0[i])
    print(", c = ", C[i])
    println(" --> ",square(X_0[i], C[i]))
end