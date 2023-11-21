module Corner # North-West cornel method
export NorthWestCorner

function NorthWestCorner(
    Cost::Matrix{Float64},
    Demand::Vector{Float64},
    Supply::Vector{Float64}
)::Matrix{Union{Float64,Nothing}}
    row, col = (1, 1)

    # initialize empty matrix with `nothing` as default value
    answer = Matrix{Union{Float64,Nothing}}(nothing, size(Cost))

    # until we reach last cell
    while (row <= size(Cost, 1) && col <= size(Cost, 2))
        # take minimum of current supply and current demand 
        min_value = min(Supply[row], Demand[col])

        # give this amount of resource
        answer[row, col] = min_value

        # decrease both supply and demand
        Supply[row] -= min_value
        Demand[col] -= min_value

        # if supply is equal to zero go down, otherwise go right
        if Supply[row] != 0
            col += 1
        else
            row += 1
        end

    end

    return answer
end

end