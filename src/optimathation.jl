module optimathation

using LinearAlgebra

function simplex(c, A, b)
    table = initalTable(c, A, b)

    while (improvementPossible(table))
        pivot = findPivot(table)
        applyPivot(table, pivot)
    end

    return simplexSolution(table)
end

initialTable(C::Vector{Float64}, A::Matrix{FLoat64}, b::Vector{Float64}) =
    [
        C'.*-1 zeros(size(A, 2))' 0
        A I(size(A, 1)) b
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

end # module optimathation
