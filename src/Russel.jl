module Russel # Russell’s approximation method
    function maxDeltaPos(Deltas::Matrix{Float64})
        row, col = (1, 1)
        mx = abs(Deltas[row][col])
        i, j = 1, 1
        for row in 1:size(Deltas, 1)
            for col in 1:size(Deltas, 2)
                if mx < abs(Deltas[row][col])
                    mx = abs(Deltas[row][col])
                    i, j = row, col
                end
            end
        end
        return i, j
    end

    function clearDeltasRow(Deltas::Matrix{Float64}, row_idx::Int)
        col = 1
        while (col < size(Deltas, 2))
            Deltas[row_idx][col] = 0
        end
        return Deltas
    end

    function clearDeltasCol(Deltas::Matrix{Float64}, col_idx::Int)
        row = 1
        while (row < size(Deltas, 1))
            Deltas[row][col_idx] = 0
        end
        return Deltas
    end

    function maxRowElem(Cost::Matrix{Float64}, row_idx::Int)
        col = 1
        mx = Cost[row_idx][col]
        while (col < size(Cost, 2))
            if mx < Cost[row_idx][j]
                mx = Cost[row_idx][j]
            end
            col += 1
        end
        return mx
    end

    function fillU(Cost::Matrix{Float64}, u_len::Int)
        row = 1
        U = Array{Float64}(0, u_len)
        while (row < u_len)
            U[row] = maxRowElem(Cost, row)
            row += 1
        end
        return U
    end

    function maxColumnElem(Cost::Matrix{Float64}, col_idx::Int)
        row = 1
        mx = Cost[row][col_idx]
        while (row < size(Cost, 1))
            if mx < Cost[row][col_idx]
                mx = Cost[row][col_idx]
            end
            row += 1
        end
        return mx
    end

    function fillV(Cost::Matrix{Float64}, v_len::Int)
        col = 1
        V = Array{Float64}(0, v_len)
        while (col < v_len)
            V[col] = maxColumnElem(Cost, col)
            col += 1
        end
        return V
    end

    function createDeltas(Cost::Matrix{Float64}, u_len::Int, v_len::Int)
        Deltas = Array{Float64}(0, u_len, v_len)
        U = fillU(Cost, u_len)
        V = fillV(Cost, v_len)
        for row in 1:u_len
            for col in 1:v_len
                Deltas[row][col] = Cost[row][col] - U[row] - V[col]
            end
        end
        return Deltas
    end

    function improvementPossible(Supply::Vector{Float64}, u_len::Int)
        for row in 1:u_len
            if Supply[row] != 0
                return true
            end
        end
        return false
    end

    function RusselApproximation(
        Cost::Matrix{Float64},
        Demand::Vector{Float64},
        Supply::Vector{Float64}
    )
        u_len = size(Cost, 1)
        v_len = size(Cost, 2)
        Deltas = createDeltas(Cost, u_len, v_len)
        answer = 0

        while (improvementPossible(Supply, u_len))
            i_mx, j_mx = maxDeltaPos(Deltas)
            mn = min(Demand[j_mx], Supply[i_mx])
            answer += Cost[i_mx][j_mx] * mn
            
            Demand[j_mx] -= mn
            Supply[i_mx] -= mn

            if Demand[j_mx] == 0
                Deltas = clearDeltasCol(Deltas, j_mx)
            end
            if Supply[i_mx] == 0
                Deltas = clearDeltasRow(Deltas, i_mx)
            end

        end
    end
end