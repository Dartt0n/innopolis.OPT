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
