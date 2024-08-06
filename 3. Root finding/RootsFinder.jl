module RootsFinder

    export mbisekcji, mstycznych, msiecznych


    # funkcja obliczająca pierwiastek metodą bisekcji
    # parametry: funkcja, dolna granica przedziału, górna granica przedziału, delta, epsilon
    # epsilon - dokładność akceptacji wyniku
    # delta - długość najmniejszego przedziału [a,b]
    # wynik: miejsce zerowe, wartość funkcji w miejscu zerowym, liczba iteracji, kod błędu
    # 0 - brak błędu, 1 - funkcja nie zmienia znaku w przedziale [a,b]
    function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
        err = 0
        it = 0
        
        u = f(a)
        v = f(b)
        e = (b - a) / 2

        if sign(u) == sign(v)
            return 0, 0, 0, 1
        end

        c = a + e
        w = f(c)
        
        while abs(e) > delta &&  abs(w) > epsilon
            if sign(w) != sign(u)
                b = c
                v = w
            else
                a = c
                u = w
            end
            e = e/2
            c = a + e
            w = f(c)

            it += 1
        end
        
        return c, w, it, err
    end


    # funkcja obliczająca pierwiastek metodą Newtona (stycznych)
    # parametry: funkcja, pochodna funkcji, punkt początkowy, delta, epsilon, maxit
    # epsilon - dokładność akceptacji wyniku
    # delta - największa długość między dwoma kolejnymi przybliżeniami
    # maxit - maksymalna dopuszczalna liczba iteracji
    # wynik: miejsce zerowe, wartość funkcji w miejscu zerowym, liczba iteracji, kod błędu
    # 0 - brak błędu, 1 - nie osiągnięto wymaganej dokładności w maxit iteracji, 2 - pochodna bliska zeru
    function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
        err = 0
        v = f(x0)
        if abs(v) < epsilon
            return x0, v, 0, 0
        end

        for k in 1:maxit
            p = pf(x0)
            if abs(p) < 3*eps(Float64)
                err = 2
            end

            x1 = x0 - v/p
            v = f(x1)
            if abs(x1-x0) < delta || abs(v) < epsilon
                return x1, v, k, err
            end
            x0 = x1
        end

        return x0, v, maxit, 1
    end
    

    # funkcja obliczająca pierwiastek metodą siecznych
    # parametry: funkcja, punkt początkowy, drugi punkt początkowy, delta, epsilon, maxit
    # epsilon - dokładność akceptacji wyniku
    # delta - największa długość między dwoma kolejnymi przybliżeniami
    # maxit - maksymalna dopuszczalna liczba iteracji
    # wynik: miejsce zerowe, wartość funkcji w miejscu zerowym, liczba iteracji, kod błędu
    # 0 - brak błędu, 1 - nie osiągnięto wymaganej dokładności w maxit iteracji
    function msiecznych(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64, maxit::Int)
        fa = f(a)
        fb = f(b)
        for k in 1:maxit
            if abs(fa) > abs(fb)
                temp = a
                a = b
                b = temp
                temp = fa
                fa = fb
                fb = temp
            end
            s = (b-a)/(fb-fa)
            b = a
            fb = fa
            a = a - fa * s
            fa = f(a)
            if abs(b-a) < delta || abs(fa) < epsilon
                return a, fa, k, 0
            end
        end

        return a, fa, maxit, 1
    end

end