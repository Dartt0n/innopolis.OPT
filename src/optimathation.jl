module optimathation

function simplex(c, A, b)
    table = initalTable(c, A, b)

    while (improvementPossible(table))
        pivot = findPivot(table)
        applyPivot(table, pivot)
    end

    return simplexSolution(table)
end

function initialTable(C, A, b)
    hcat(vcat([-C[i] for i=1:size(C,1)]', A), vcat(zeros(1, size(A, 1)), [convert(Float64, i==j) for i=1:size(A, 1), j=1:size(A, 1)]), vcat([0], b))
end

function simplexSolution(table::Matrix{Float64})
    _, m = size(table)

    return table[1, m]
end

end # module optimathation
