module optimathation

improvementPossible(A::Matrix{Float64}) =
    any(x -> x < 0, A[1, begin:end-1])

function simplex(c, A, b)
    table = initalTable(c, A, b)

    while (improvementPossible(table))
        pivot = findPivot(table)
        applyPivot(table, pivot)
    end

    return simplexSolution(table)
end

end # module optimathation
