function dxvdt = sysDiffGlgen(x,v,params)
  N = size(x,1);

  % Compute A
  eta = @(y) params.K./((params.sigma^2 + y).^params.beta);
  [j,i] = meshgrid(1:N);
  temp = eta(vecnorm(x(j,1:2)-x(i,1:2),2,2));
  A = reshape(temp,[N N]);

  % Compute D 
  d = sum(A, 2);
  D = diag(d);

  % Compute L
  L = D - A;

  % Compute derivatives
  dxdt = v;
  dvdt = -L*v;

  % Combine derivatives
  dxvdt = [dxdt dvdt];
end
