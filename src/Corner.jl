module Corner # North-West cornel method

function NorthWestCorner(
    Cost::Matrix{Float64},
    Demand::Vector{Float64},
    Supply::Vector{Float64}
)::Matrix{Float64}
    row, col = (1, 1)

    answer = fill(-1.0, size(Cost))

    while (row < size(Cost, 1) && col < size(Cost, 2))
        min_value = min(Supply[row], Demand[col])
        answer[row, col] = min_value

        Supply[row] -= min_value
        Demand[col] -= min_value

        if Supply[row] != 0
            col += 1
        else
            row += 1
        end

    end

    return answer
end

end