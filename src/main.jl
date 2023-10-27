include("./InteriorPoint.jl")
using .InteriorPoint

C = [1.0; 2.0; 0.0]
A = [1.0 1.0 1.0;]
# b is not needed

initX = [2.0; 2.0; 4.0]

display(interiorPoint(0.5, A, C, initX, 0.01))
