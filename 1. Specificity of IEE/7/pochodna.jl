# Jarosław Socha
# program liczący błąd przybliżenia pochodnej

function f(x)
    Float64(sin(x) + cos(3*x))
end
function df(x)
    Float64(cos(x) - 3 * sin(3*x))
end
function df_approx(x0,h)
    Float64(( f(x0 + h) - f(x0) ) / h)
end

# xax = 20:40
xax = 25:40
yax = []

for n in xax
    push!(yax, abs(df(1) - df_approx(1, 2.0^(-n))))
end

using Plots:plot
plot(xax, yax, legend=false)