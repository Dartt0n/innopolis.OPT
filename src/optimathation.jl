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

function applyPivot(table::Matrix{Float64}, pivot)
    rows, columns = size(table)
    
    i, j = pivot
    
    for column in 1:columns
        table[i, column] /= table[i, j]
    end
    
    for row in 1:rows
        table[row, j] = 0
    end
end

end # module optimathation
