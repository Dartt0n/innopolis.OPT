module optimathation

using LinearAlgebra

function simplex(c, A, b, prec)
    table = initialTable(c, A, b)
    sol_vector_row = [0*i for i=1:size(c, 1)]
    while (improvementPossible(table))
        pivot = findPivot(table, sol_vector_row)
        if pivot === nothing
            return simplexSolution(table, sol_vector_row, prec)
        end

        applyPivot(table, pivot)
    end

    return simplexSolution(table, sol_vector_row, prec)
end

initialTable(C::Vector{Float64}, A::Matrix{Float64}, b::Vector{Float64}) =
    [
        C'.*-1 zeros(1, size(A, 1)) 0 # 1x4 1x3 1x1
        A I(size(A, 1)) b             # 3x4 3x3 3x1
    ]


improvementPossible(A::Matrix{Float64}) =
    any(x -> x < 0, A[1, begin:end-1])

function simplexSolution(table::Matrix{Float64}, sol_vector_row::Vector{Int64}, prec)
    approx = round(table[1, size(table, 2)], RoundNearest, digits = prec)
    solution = [0 for n=1:size(sol_vector_row,1)]
    for i=1:size(sol_vector_row,1)
        if sol_vector_row[i] == 0
            solution[i] = 0
        else
            solution[i] = round(table[sol_vector_row[i], size(table, 2)], RoundNearest, digits = prec)
        end
    end

    return (solution, approx)
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

function findPivot(table, sol_vector_row)
    v, col = findmin(x -> x < 0 ? x : Inf, table[1, :])
    if v == Inf
        return nothing
    end

    v, row = findmin(x -> x > 0 ? x : Inf, table[:, end] ./ table[:, col])
    if v == Inf
        return nothing
    end

    if col <= size(sol_vector_row, 1)
        sol_vector_row[col] = row
    end
    return (row, col)
end

end # module optimathation
