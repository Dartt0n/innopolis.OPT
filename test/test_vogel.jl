using Test

include("../src/Vogel.jl")
using .Vogel

@testset "Testing Vogel" begin
    # Lab 7, Problem 3
    C::Matrix{Float64} = [
        7.0 8.0 1.0 2.0
        4.0 5.0 9.0 8.0
        9.0 2.0 3.0 6.0
    ]
    D::Vector{Float64} = vec([120.0 50.0 190.0 110.0])
    S::Vector{Float64} = vec([160.0 140.0 170.0])

    # answer
    answer = Matrix{Union{Float64,Nothing}}([
        nothing nothing 50.0 110.0
        120.0 20.0 nothing nothing
        nothing 30.0 140.0 nothing
    ])

    # check sums
    @test sum(D) == sum(S)

    # checks dimensions
    @test size(C) == (length(S), length(D))

    get = vogel(C, D, S)

    @show answer
    @show get

    # gauge the function itself
    @test get == answer
end