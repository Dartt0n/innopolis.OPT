module Simplex

using LinearAlgebra

function simplex(c, A, b)
    table = initialTable(c, A, b)

    while (improvementPossible(table))
        pivot = findPivot(table)

        if pivot === nothing
            return simplexSolution(table)
        end

        applyPivot(table, pivot)
    end

    return simplexSolution(table)
end

initialTable(C::Vector{Float64}, A::Matrix{Float64}, b::Vector{Float64}) =
    [
        C'.*-1 zeros(1, size(A, 1)) 0 # 1x4 1x3 1x1
        A I(size(A, 1)) b             # 3x4 3x3 3x1
    ]


improvementPossible(A::Matrix{Float64}) =
    any(x -> x < 0, A[1, begin:end-1])

simplexSolution(table::Matrix{Float64}) =
    table[1, size(table, 2)]


function applyPivot(table::Matrix{Float64}, pivot::Tuple{Int64,Int64})
    i, j = pivot

    table[i, :] /= table[i, j]

    for row in 1:size(table, 1)
        if row == i
            continue
        end

        table[row, :] -= table[row, j] * table[i, :]
    end

    return table
end

function findPivot(table)
    v, col = findmin(x -> x < 0 ? x : Inf, table[1, :])
    if v == Inf
        return nothing
    end

    v, row = findmin(x -> x > 0 ? x : Inf, table[:, end] ./ table[:, col])
    if v == Inf
        return nothing
    end

    return (row, col)
end

end # module optimathation
