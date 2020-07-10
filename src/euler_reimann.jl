"""
    explicit_euler_riemann(mu, beta, p0, h, t0, t1, a0, a1)

Integrates a population without migration using Explicit Euler-Riemann.
mu is a mortality function of age and time. Beta is a birth rate of
age and time. p0 is an initial population, as a function of age.
h is the step size in both age and time. (t0, t1) are time limits.
(a0, a1) are age limits. This returns a single array in age and time
with the value of the population.

You must have h*mu < 1.
"""
function explicit_euler_riemann(mu, beta, p0, h, t0, t1, a0, a1)
    a = a0:h:a1
    t = t0:h:t1
    m = length(a)
    n = length(t)

    u = zeros(h, m, n)
    u[:, 1] = p0(a, t0)

    for i in 1:(n - 1)
        u[:, i + 1] = (1 .- h .* mu(a, t[i])) .* u[:, i]
        u[1, i + 1] = h * sum(beta(a, t[i]) .* u[1:m, i])
    end
    u
end


"""
    implicit_euler_riemann(mu, beta, p0, h, t0, t1, a0, a1)

Integrates a population without migration using Implicit Euler-Riemann.
mu is a mortality function of age and time. Beta is a birth rate of
age and time. p0 is an initial population, as a function of age.
h is the step size in both age and time. (t0, t1) are time limits.
(a0, a1) are age limits. This returns a single array in age and time
with the value of the population.

You must have h*mu < 1.
"""
function implicit_euler_riemann(mu, beta, p0, h, t0, t1, a0, a1)
    a = a0:h:a1
    t = t0:h:t1
    m = length(a)
    n = length(t)

    u = zeros(h, m, n)
    u[:, 1] = p0(a, t0)

    for i in 1:(n - 1)
        u[:, i + 1] = u[:, i] ./ (1 .+ h .* mu(a, t[i]))
        u[1, i + 1] = h * sum(beta(a, t[i]) .* u[1:m, i])
    end
    u
end


"""
Solve the problem for q(a, t) = p(a, t) / survival.
Then multiply the survival back in order to get p(a, t).
"""
function euler_riemann_survival(s, beta, p0, h, t0, t1, a0, a1)
    a = a0:h:a1
    t = t0:h:t1
    m = length(a)
    n = length(t)

    u = zeros(h, m, n)
    u[:, 1] = p0(a, t0)

    for i in 1:(n - 1)
        birth = sum(beta(a, t[i]) .* s[a, t[i]] .* u[1:m, i])
        for j in 1:min(m, n - i)
            u[j, i + j] = birth
        end
        u[:, i] .*= s[a, t[i]]
    end
    u[:, n] .*= s[a, t[n]]
    u
end
