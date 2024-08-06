# Jarosław Socha
# Moduł do obliczeń związanych z interpolacją

module Interpolate
    using Plots


    export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx, rysujNnfxNaPrzedziale


    # Funkcja obliczająca Ilorazy różnicowe
    # Parametry: 
    # x - wektor długości n+1 zawierający węzły x0,...,xn 
    # f - wektor długości n+1 zawierający wartości funkcji w węzłach x 
    # Wynik:
    # fx - wektor długości n+1 zawierający obliczone ilorazy różnicowe
    # [ f[x0], f[x0,x1], ..., f[x0,...,xn]]
    function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
        n = length(x) - 1

        # iteracje składania ilorazu
        # k to liczba ilorazów składanych w danej iteracij
        for k in 1:n
            # ilorazy w tablicy od k do n 
            for i in n:-1:k
                # nowy iloraz różnicowy
                f[i+1] = (f[i+1] - f[i]) / (x[i+1] - x[i+1-k])
            end
        end
        
        return f
    end
    
    
    # Funkcja obliczająca wartość wielomianu interpolacyjnego stopnia n w postaci Newtona
    # Parametry: 
    # x - wektor długości n+1 zawierający węzły x0,...,xn 
    # fx - wektor długości n+1 zawierający obliczone ilorazy różnicowe
    # t - punkt
    # Wynik:
    # nt - wartość funkcji w punkcie t
    function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
        n = length(x) - 1
        
        nt = fx[n+1]

        # iterujemy od końca
        for i in n:-1:1
            nt = fx[i] + (t-x[i]) * nt
        end

        return nt
    end


    # Funkcja obliczająca współczynniki wielomianu w postaci naturalnej
    # Parametry: 
    # x - wektor długości n+1 zawierający węzły x0,...,xn 
    # fx - wektor długości n+1 zawierający obliczone ilorazy różnicowe
    # Wynik:
    # a - wektor długości n+1 zawierający współczynniki postaci naturalnej
    # [a0, a1, ..., an]
    function naturalna(x::Vector{Float64}, fx::Vector{Float64})
        n = length(x) - 1
        
        a = [0. for i in 1:n+1]
        a[n+1] = fx[n+1] # współczynnik przy x^n

        # chcemy otrzymać
        #  a := fx[k] + (x-x_k) * a

        # pomnożenie razy x: przesunięcie w wektorze o jeden w lewo
        # następnie dodajemy -x[x]
        for k in n:-1:1
            for i in k:n
                a[i] -= x[k]*a[i+1]
            end
            a[k] += fx[k]
        end
    
        return a
    end


    # Funkcja interpolująca i rysująca wielomian interpolacyjny
    # Parametry: 
    # f - anonimowa funkcja
    # a, b - przedział interpolacji
    # n - stopień wielomianu interpolacyjnego
    # Wynik:
    # a - rysunek wielomianu na przedziale [a,b]
    function rysujNnfx(f,a::Float64,b::Float64,n::Int)
        h = (b-a)/n
        X = [a + k*h for k in 0:n]
        Y = [f(X[i]) for i in 1:n+1]
        FX = ilorazyRoznicowe(X,Y)

        x = range(a, b, 100)
        y = z -> warNewton(X,FX,z)
        
        plot(x, y.(x))
    end
    
    # poprzednia funkcja, ale podajemy przedział rysowanej funkcji,
    # a także dostajemy wykres funkcji oryginalnej
    function rysujNnfxNaPrzedziale(f,a::Float64,b::Float64,n::Int, p::Float64, q::Float64)
        h = (b-a)/n
        X = [a + k*h for k in 0:n]
        Y = [f(X[i]) for i in 1:n+1]
        FX = ilorazyRoznicowe(X,Y)

        x = range(p, q, 100)
        y = z -> warNewton(X,FX,z)
        
        return plot(x, [y.(x) f.(x)], label=["Interpolacja" "Oryginał"])
    end
end