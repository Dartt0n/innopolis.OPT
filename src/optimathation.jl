module optimathation

function improvementPossible(table::Matrix{Float64})
    return !isempty(findall(x -> x < 0, table[1, begin:end-1]))
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
