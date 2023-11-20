module Vogel
export vogel

function vogel(
    C::Matrix{Float64},
    D::Vector{Float64},
    S::Vector{Float64}
)
    m, n = size(C)

    # verify that the dimensions of input matrices match
    @assert length(S) == m && length(D) == n

    # initialize the answer matrix
    x = zeros(m, n)

    # step 1: Calculate penalties for each row and column
    row_penalties = [sort(C[i, :])[2] - sort(C[i, :])[1] for i in 1:size(C, 1)]
    col_penalties = [sort(C[:, i])[2] - sort(C[:, i])[1] for i in 1:size(C, 2)]

    while true
        # step 2: find the cell with the maximum penalty (whether row or column)
        max_penalty_row, max_penalty_col = argmax(row_penalties), argmax(col_penalties)

        # step 3: identify the minimum cost cell in the selected row or column
        if row_penalties[max_penalty_row] >= col_penalties[max_penalty_col]
            # OPERATE ON ROW
            min_ind = 0
            min_val = Inf64
            for i in eachindex(C[max_penalty_row, :])
                # update value of minimum unused current column 
                if x[max_penalty_row, i] == 0.0 && C[max_penalty_row, i] < min_val
                    min_val = C[max_penalty_row, i]
                    min_ind = i
                end
            end

            # count weight to take and consequently to substract 
            weight = min(D[min_ind], S[max_penalty_row])
            x[max_penalty_row, min_ind] = weight
            D[min_ind] -= weight
            S[max_penalty_row] -= weight
        else
            # OPERATE ON COLUMN
            min_ind = 0
            min_val = Inf64
            for i in eachindex(C[:, max_penalty_col])
                if x[i, max_penalty_col] == 0.0 && C[i, max_penalty_col] < min_val
                    min_val = C[i, max_penalty_col]
                    min_ind = i
                end
            end

            weight = min(D[max_penalty_col], S[min_ind])
            x[min_ind, max_penalty_col] = weight
            D[max_penalty_col] -= weight
            S[min_ind] -= weight
        end

        # update penalties
        for i in 1:m
            # if this row is already fully used
            if S[i] == 0.0
                row_penalties[i] = 0.0
                continue
            end

            # collect all non used values in the row
            row = Vector{Float64}([])

            for j in 1:n
                # iterating over all values in the column we should avoid such
                # that have already taken the weight (x[i, j]) or with the row that is already used
                if x[i, j] == 0.0 && D[j] != 0.0
                    push!(row, C[i, j])
                end
            end

            sorted_row = sort(row)
            if length(sorted_row) > 1
                row_penalties[i] = sorted_row[2] - sorted_row[1]
            else
                row_penalties[i] = sorted_row[1]
            end
        end

        # update col_penalties
        for j in 1:n
            if D[j] == 0.0
                col_penalties[j] = 0.0
                continue
            end
            
            col = Vector{Float64}([])
            for i in 1:m
                if x[i, j] == 0.0 && S[i] != 0.0
                    push!(col, C[i, j])
                end
            end

            sorted_col = sort(col) # sort
            if length(sorted_col) > 1
                col_penalties[j] = sorted_col[2] - sorted_col[1]
            else
                col_penalties[j] = sorted_col[1]
            end
        end

        # end of the method is when all demand (and supply correspodingly) was used
        if all(D .<= 0.0) || all(S .<= 0.0)
            break
        end
    end

    # calculate the sum of the solution
    s = 0
    for i in 1:m
        for j in 1:n
            if x[i, j] != 0.0
                s += x[i, j] * C[i, j]
            end   
        end
    end

    return s
end

end  # module
