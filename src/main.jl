include("./Corner.jl")
using .Corner
using Printf

function Base.parse(::Type{Vector{Float64}}, ss::Vector{String})::Vector{Float64}
    return [parse(Float64, x) for x ∈ ss]
end

function Base.parse(::Type{Matrix{Float64}}, ss::Vector{String})::Matrix{Float64}
    return permutedims(hcat([parse(Vector{Float64}, Vector{String}(split(x, " "))) for x ∈ ss]...))
end

println("Enter N - number of destinations:")
N = parse(Int, readline())
@show N

println("Enter C - matrix of coeficients (N ✖ N):")
strings = [readline() for _ ∈ 1:N]
C = parse(Matrix{Float64}, strings)
@show C

if size(A) ≠ (N, N)
    println("Matrix A must have dimensions of N ✖ N")
    exit(1)
end

println("Enter S - vector of supply (N ✖ 1):")
strings = [readline() for _ ∈ 1:N]
S = parse(Vector{Float64}, strings)
@show S

println("Enter D - vector of demand (N ✖ 1):")
strings = [readline() for _ ∈ 1:N]
D = parse(Vector{Float64}, strings)
@show D