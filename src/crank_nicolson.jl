function explicit_crank_nicolson(mu, beta, p0, h, t0, t1, a0, a1)
    a = a0:h:a1
    t = t0:h:t1
    m = length(a)
    n = length(t)

    u = zeros(h, m, n)
    u[:, 1] = p0(a, t0)

    for i in 1:(n - 1)
        h2 = 0.5 * (t[i] + t[i + 1])
        u[:, i + 1] = (1 .- 0.5 * h * mu(a, h2)) ./ (1 .+ 0.5 * h * mu(a, h2)) * u[:, i]
        u[1, i + 1] = h * sum(beta(a, t[i + 1]) .* u[1:m, i + 1]) + 0.5 * h * u[1, i]
    end
    u
end
