using Test

include("../src/Russel.jl")
using .Russel

@testset "Testing Russel" begin
    # Lab 7, Problem 3
    C::Matrix{Float64} = [7.0 8.0 1.0 2.0; 4.0 5.0 9.0 8.0; 9.0 2.0 3.0 6.0]
    D::Vector{Float64} = vec([120.0 50.0 190.0 110.0])
    S::Vector{Float64} = vec([160.0 140.0 170.0])

    answer = 1530

    @test RusselApproximation(C, D, S) == answer

end