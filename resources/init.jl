using Plots, Revise, IJulia, Distributions, GLM, DataFrames, DifferentialEquations

plot(rand(Normal(),5),rand(Normal(),5))
ols = lm(@formula(X ~ Y), DataFrame(X=[1,2],Y=[4,5]))
f(u,p,t) = 1.01*u
u0 = 1/2
tspan = (0.0,1.0)
prob = ODEProblem(f,u0,tspan)
sol = solve(prob, Tsit5(), reltol=1e-8, abstol=1e-8)
