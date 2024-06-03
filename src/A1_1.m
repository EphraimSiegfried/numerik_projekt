clear;
N = 50;
x0 = -5 + (5+5) * rand(N,2);
v0 = -1 + (1+1) * rand(N,2);
params.K = 1;
params.sigma = 1;
params.beta = 1;
tspan = [0, 10, 5 * 10^(-2)]; 

[x, v] = heunSchwarm(tspan, x0, v0, params);

time = tspan(1):tspan(3):tspan(2);
figure;
for i =  1:16
  xi = squeeze(x(i,:,1));
  yi = squeeze(x(i,:,2));
  dxi = squeeze(v(i,:,1));
  dyi = squeeze(v(i,:,2));
  subplot(4,4,i)
  hold on 
  scatter(squeeze(x(i,:,1)), x(i,:,2))
  quiver(xi,yi,dxi,dyi)
  title("t = " + time(i))
  hold off
end

