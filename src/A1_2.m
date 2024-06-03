clear;
N = 20;
x0 = -5 + (5+5) * rand(N,2);
v0 = -1 + (1+1) * rand(N,2);
params.K = 2;
params.sigma = 3;
params.beta = 4;
tspan = [0, 1, 5 * 10^(-6)]; 

[x_ref, v_ref] = heunSchwarm(tspan, x0, v0, params);
size(x_ref)

x_ref(1)
xEE = zeros(5);
vEE = zeros(5);
xH = zeros(5);
vH = zeros(5);
err_ExpEul = zeros(5);
err_Heun = zeros(5);
dt = [0.1 0.05 0.01 0.005 0.001];
for i = 1:length(dt)
  % tspan(3) = dt(i);
  % [xEE(i), vEE(i)] = explEulSchwarm(tspan,x0, v0, params);
  % [xH(i), vH(i)] = heunSchwarm(tspan,x0, v0, params);

  % err_ExpEul = norm(x_ref(1))
  % err_Heun = 
end
