include("./Corner.jl")
using .Corner
using Printf

function Base.parse(::Type{Vector{Float64}}, ss::Vector{String})::Vector{Float64}
    return [parse(Float64, x) for x ∈ ss]
end

function Base.parse(::Type{Matrix{Float64}}, ss::Vector{String})::Matrix{Float64}
    return permutedims(hcat([parse(Vector{Float64}, Vector{String}(split(x, " "))) for x ∈ ss]...))
end

println("Enter N - number of sources:")
N = parse(Int, readline())
@show N

println("Enter M - number of destinations:")
M = parse(Int, readline())
@show M

println("Enter C - matrix of costs (N ✖ M):")
strings = [readline() for _ ∈ 1:N]
C = parse(Matrix{Float64}, strings)
@show C

if size(A) ≠ (N, M)
    println("Matrix A must have dimensions of N ✖ M")
    exit(1)
end

println("Enter S - vector of supply (N ✖ 1):")
strings = [readline() for _ ∈ 1:N]
S = parse(Vector{Float64}, strings)
@show S

println("Enter D - vector of demand (M ✖ 1):")
strings = [readline() for _ ∈ 1:M]
D = parse(Vector{Float64}, strings)
@show D