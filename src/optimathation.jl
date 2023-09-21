module optimathation

function improvementPossible(table::Matrix{Float64})
    for i in 1:(size(table, 2) - 1)
        if (table[1, i] < 0)
            return true
        end
    end
    return false
end

function simplex(c, A, b)
    table = initalTable(c, A, b)

    while (improvementPossible(table))
        pivot = findPivot(table)
        applyPivot(table, pivot)
    end

    return simplexSolution(table)
end

end # module optimathation
