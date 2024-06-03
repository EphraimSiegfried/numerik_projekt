function [bestX, bestFx, xHist, bHist] = PSO(funcH, gebiet, params)
  % initialize variables
  w = params.omega;
  c_k = params.c_k;
  c_s = params.c_s;
  N = params.N;
  xHist = zeros(params.I_max,N,2);
  bHist = zeros(params.I_max,N,2);
  bA = gebiet(1);
  bB = gebiet(2);
  bC = gebiet(3);
  bD = gebiet(4);

  % generate random particles within borders
  rand_vecs = @(a,b,c,d) [a + (b - a).*rand(N,1), c + (d - c).*rand(N,1)];
  init_pos = rand_vecs(bA,bB,bC,bD);
  xHist(1,:,:) = init_pos;
  v = -5 + (5+5) * rand_vecs(bA,bB,bC,bD);

  % set inital best position and value
  bHist(1,:,:) = init_pos;
  bestFb = funcH(init_pos(:,1),init_pos(:,2));
  [bestFx, bestIndex] = min(bestFb);
  bestX = init_pos(bestIndex,:);

  for i = 1:params.I_max
    % compute next iteration
    b = squeeze(bHist(i,:,:));
    x = squeeze(xHist(i,:,:));
    r = rand();
    s = rand();
    g = bestX;
    v = w*v + c_k * r .* (b-x) + c_s * s .* (g - x);
    next = x + v;

    % handle vectors out of border
    next(next(:,1) < bA,1) = bA;
    next(next(:,1) > bB,1) = bB;
    next(next(:,2) < bC,2) = bC;
    next(next(:,2) > bD,2) = bD;
    
    % update position history
    xHist(i+1,:,:) = next;

    % find best minima of each particle
    fx = funcH(x(:,1),x(:,2));
    indices = fx < bestFb;
    bHist(i+1,:,:) = bHist(i,:,:);
    bHist(i+1,indices,:) = x(indices,:);
    bestFb(indices) = fx(indices);

    % find best global minimum
    [bestFx, bestIndex] = min(bestFb);
    bestX = squeeze(bHist(i+1,bestIndex,:))';

  end

end
