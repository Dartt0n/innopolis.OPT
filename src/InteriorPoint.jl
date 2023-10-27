module InteriorPoint

using LinearAlgebra

export interiorPoint

function interiorPoint(
    alpha::Float64,
    A::Matrix{Float64},
    C::Vector{Float64},
    X::Vector{Float64},
    prec::Float64
)
    n = size(X, 1) # get 1st dimension of x

    while true
        D = diagm(X) # convert vector x to diagonal matrix, where elements of x are diagonal elements

        waveA = A * D
        waveC = D * C

        P = I(n) - waveA' * inv(waveA * waveA') * waveA
        Cp = P * waveC

        mu, _ = findmin(x -> x < 0 ? x : Inf, Cp) # find the most negative element

        if mu === Inf
            return X # most negative not found => no more negative elements
        end

        # by the formula mu = |min(Cp)|, but since mu is always negative, we can simply add -1
        # before mu in the formula below
        waveX = ones(n) - alpha / mu * Cp

        oldX = X # save previous value
        X = vec(D * waveX) # transform 4x1 matrix to vector with len=4


        if norm(X - oldX) < prec
            break # while difference is bigger then precision
        end
    end

    return X
end


end