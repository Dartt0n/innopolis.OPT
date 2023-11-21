using Printf

include("./Corner.jl")
using .Corner

include("./Vogel.jl")
using .Vogel

include("Russel.jl")
using .Russel

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

if size(C) ≠ (N, M)
    println("Matrix C must have dimensions of N ✖ M")
    println("Method is not applicable!")
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

if sum(S) ≠ sum(D)
    println("The problem is not balanced!")
    exit(1)    
end

# 1. north-west method
s = NorthWestCorner(copy(C), copy(D), copy(S))
println("North-west method's answer:")
display(s)
println()

# 2. vogel's method
s = vogel(copy(C), copy(D), copy(S))
println("Vogel method's answer:")
display(s)
println()

# 3. russel's method
s = RusselApproximation(copy(C), copy(D), copy(S))
println("Russel method's answer:")
display(s)
println()
