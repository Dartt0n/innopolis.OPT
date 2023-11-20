using Test

include("../src/InteriorPoint.jl")
using .InteriorPoint

@testset "Testing InteriorPoint" begin
    # Lab 6, Problem 2
    X::Vector{Float64} = vec([1.0 1.0 1.0 315.0 174.0 169.0])
    C::Vector{Float64} = vec([9.0 10.0 16.0 0.0 0.0 0.0])
    A::Matrix{Float64} = [18.0 15.0 12.0 1.0 0.0 0.0; 6.0 4.0 8.0 0.0 1.0 0.0; 5.0 3.0 3.0 0.0 0.0 1.0]
    α::Float64 = 0.5
    ε::Float64 = 0.0001

    # answer
    Y::Vector{Float64} = vec([0.0 8.0 20.0 0.0001 0.0 96.0])
    
    @test round.(interiorPoint(X, C, A, α, ε), digits=Int(abs(log10(0.0001)))) == Y
end