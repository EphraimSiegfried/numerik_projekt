clear;
params.I_max = 50;
params.N = 50;
params.omega = 0.7;

k = 1:5; 
K = @(x1,x2) sum(k' .* cos((k+1)' .* x1 + k'), 1) .* sum(k' .* cos((k+1)' .* x2 + k'), 1);
S = @(x1,x2) arrayfun(@(a,b) K(a,b), x1, x2);

combinations = [2 2; 0 2; 2 0];
rngs = 1:30;
num_comb = size(combinations,1);

for j = 1:num_comb
  params.c_k = combinations(j,1);
  params.c_s = combinations(j,2);
  fprintf("c_k = %d, c_s = %d",params.c_k,params.c_s)
  for i = rngs
      rng(i);
      [bestX, bestFx, xHist, bHist] = PSO(S,[-5.1 5.1 -5.1 5.1],params);
      fprintf("rng(%d), Minimum: S(%f, %f) = %f", i,bestX, bestFx)
      
      % subplot(length(rngs),num_comb,(j-1) * length(rngs) + i)
      % hold on
      % [x1, x2] = meshgrid(-5.1:5.1);
      % result = S(x1,x2);
      % contour(x1,x2,result);
      % scatter(squeeze(xHist(i,:,1)), xHist(i,:,2),[],"red");
      % title("i = " + i);
      % hold off
  end
end

