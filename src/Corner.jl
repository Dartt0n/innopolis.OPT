module Corner # North-West cornel method

    function NorthWestCorner(
        Cost::Matrix{Float64},
        Demand::Vector{Float64},
        Supply::Vector{Float64}
    )
        row, col = (1, 1)
        answer = 0

        while (row < size(Cost, 1) && col < size(Cost, 2))
            answer += Cost[row, col]

            if Cost[row, col] < Supply[row]
                Supply[row] -= Demand[col]
                col += 1
            else
                Demand[col] -= Supply[row]
                row += 1
            end
        end


    end

end