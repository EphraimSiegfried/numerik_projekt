function [x,v] = heunSchwarm(tspan,x0,v0,params)
  t_init = tspan(1);
  t_end = tspan(2);
  dt = tspan(3);
  num_steps = floor((t_end - t_init) / dt) + 1;
  N = size(x0, 1);
  
  x = zeros(num_steps, N, 2);
  v = zeros(num_steps, N, 2);
  x(1, :, :) = x0;
  v(1, :, :) = v0;

  [x_tilde, v_tilde] = explEulSchwarm(tspan,x0,v0,params);
  for i = 1:num_steps-1
    xi = squeeze(x(i, :, :));
    vi = squeeze(v(i, :, :));
    dxvdt = sysDiffGlgen(xi, vi, params);
    dxdt = dxvdt(:, 1:2); 
    dvdt = dxvdt(:, 3:4); 
    x(i+1, :, :) = xi + 0.5 * dt * (dxdt + squeeze(x_tilde(i+1,:,:)));
    v(i+1, :, :) = vi + 0.5 * dt * (dvdt + squeeze(v_tilde(i+1,:,:)));
  end

end
