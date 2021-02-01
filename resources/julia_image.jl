using Plots
using Optim
using Distributions
using StatsPlots
using DataFrames
using IndexedTables
using IJulia
using Flux
using Statistics


# IJulia
IJulia.load("/home/o/.julia/packages/IJulia/DrVMH/src/kernel.jl")

# Plots
plot(rand(Normal(),10),rand(Normal(),10))
plot(sin,0,2*pi)

# DataFrames and StatsPlots
df = DataFrame(a = 1:10, b = 10 .* rand(10), c = 10 .* rand(10))
@df df plot(:a, [:b :c], colour = [:red :blue])
@df df scatter(:a, :b, markersize = 4 .* log.(:c .+ 0.1))
t = table(1:10, rand(10), names = [:a, :b]) # IndexedTable
@df t scatter(2 .* :b)

# Optim
f(x) = (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
x0 = [0.0, 0.0]
optimize(f, x0)
