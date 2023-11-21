using Test

include("../src/Corner.jl")
using .Corner

@testset "Testing Corner" begin
    # Lab 7, Problem 2
    C::Matrix{Float64} = [
        2.0 3.0 4.0 2.0 4.0
        8.0 4.0 1.0 4.0 1.0
        9.0 7.0 3.0 7.0 2.0
    ]
    D::Vector{Float64} = vec([60.0 70.0 120.0 130.0 100.0])
    S::Vector{Float64} = vec([140.0 180.0 160.0])

    answer = Matrix{Union{Float64,Nothing}}([
        60.0 70.0 10.0 nothing nothing
        nothing nothing 110.0 70.0 nothing
        nothing nothing nothing 60.0 100.0
    ])

    # check sums
    @test sum(D) == sum(S)

    # checks dimensions
    @test size(C) == (length(S), length(D))

    get = NorthWestCorner(C, D, S)

    @show answer
    @show get

    @test get == answer
end