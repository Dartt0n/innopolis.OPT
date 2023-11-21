using Test

include("../src/Russel.jl")
using .Russel

@testset "Testing Russel" begin
    C::Matrix{Float64} = [
        3.0 1.0 7.0 4.0
        2.0 6.0 5.0 9.0
        8.0 3.0 3.0 2.0
    ]
    D::Vector{Float64} = vec([250.0 350.0 400.0 200.0])
    S::Vector{Float64} = vec([300.0 400.0 500.0])

    answer = Matrix{Union{Float64,Nothing}}([ # todo: check this test
        nothing 300.0 nothing nothing
        250.0 50.0 100.0 nothing
        nothing nothing 300.0 200.0
    ])

    # check sums
    @test sum(D) == sum(S)

    # checks dimensions
    @test size(C) == (length(S), length(D))

    get = RusselApproximation(C, D, S)

    @show answer
    @show get

    @test get == answer
end