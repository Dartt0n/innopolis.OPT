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

simplexSolution(table::Matrix{Float64}) =
    table[1, size(table, 2)]


end # module optimathation
