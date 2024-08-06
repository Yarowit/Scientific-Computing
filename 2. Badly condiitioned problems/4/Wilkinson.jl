# Jarosław Socha
# Program sprawdzający złośliwość wielomianu Wilkinsona

using Polynomials

# iterayjna postać wielomianu
function it(x)
    sum = 1
    for i in 1:20
        sum *= x-i
    end
    return sum
end

function wilkinson(args)
    P = Polynomial(reverse(args))
    
    # suma różnic wymnożonego
    Pdiff = 0
    # suma różnic niewymnożonego
    pdiff = 0
    # suma różnic pierwiastków
    Rdiff = 0
    
    Proots = roots(P)
    for root in 1:20
        Pdiff += abs(P(Proots[root]))
        pdiff += abs(it(Proots[root]))
        Rdiff += abs(Proots[root] - root)
    end
    println("P: ",Pdiff)
    println("p: ",pdiff)
    println("R: ",Rdiff)
end

args=[1, -210.0, 20615.0,-1256850.0,
    53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
    11310276995381.0, -135585182899530.0,
    1307535010540395.0,     -10142299865511450.0,
    63030812099294896.0,     -311333643161390640.0,
    1206647803780373360.0,     -3599979517947607200.0,
    8037811822645051776.0,      -12870931245150988800.0,
    13803759753640704000.0,      -8752948036761600000.0,
    2432902008176640000.0]

# modyfikacja wielomianu
# args[1] -= 2^(-23)

wilkinson(args)