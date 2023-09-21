module optimathation

function simplex(c, A, b)
    table = initalTable(c, A, b)

    while (improvementPossible(table))
        pivot = findPivot(table)
        applyPivot(table, pivot)
    end

    return simplexSolution(table)
end

function simplexSolution(table::Matrix{Float64})
    _, m = size(table)

    return table[1, m]
end

end # module optimathation
