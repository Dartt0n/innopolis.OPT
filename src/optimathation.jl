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

function findPivot(table)
    min = 0
    indx = -1
    for i in range(1, size(table, 2))
        if table[1, i] < min
            min = table[1, i]
            indx = i
        end
    end

    if indx == -1
        return nothing
    end

    min1 = table[1, size(table, 2)]
    row = -1
    for j in range(2, size(table))
        if  table[j, indx] != 0 && 0 <= table[j, size(table, 2)] / table[j, indx] < min1
            row = j
            min1 = table[j, size(table, 2)] / table[j, indx]
        end
    end
    
    if row == -1
        return nothing
    end

    return (row, indx)
end

end # module optimathation
