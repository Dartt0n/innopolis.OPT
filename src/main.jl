include("./InteriorPoint.jl")
using .InteriorPoint


function Base.parse(::Type{Vector{Float64}}, ss::Vector{String})::Vector{Float64}
    return [parse(Float64, x) for x ∈ ss]
end

function Base.parse(::Type{Matrix{Float64}}, ss::Vector{String})::Matrix{Float64}
    return permutedims(hcat([parse(Vector{Float64}, Vector{String}(split(x, " "))) for x ∈ ss]...))
end

println("Enter N - number of variables:")
N = parse(Int, readline())
@show N

println("Enter C - vector of coeficients (N✖1):")
strings = [readline() for _ ∈ 1:N]
C = parse(Vector{Float64}, strings)
@show C

println("Enter M - number of constrains:")
M = parse(Int, readline())
@show M

println("Enter A - matrix of coeficients (M✖N):")
strings = [readline() for _ ∈ 1:M]
A = parse(Matrix{Float64}, strings)
@show A

if size(A) ≠ (M, N)
    println("Matrix A must have dimensions of M✖N")
    exit(1)
end

println("Enter X₀ - initial solution (N✖1):")
strings = [readline() for _ ∈ 1:N]
X₀ = parse(Vector{Float64}, strings)
@show X₀

println("Enter α - step size:")
α = parse(Float64, readline())
@show α

println("Enter ε - required precision:")
ε = parse(Float64, readline())
@show ε

println("Solution is:")
@show interiorPoint(α, A, C, X₀, ε)
