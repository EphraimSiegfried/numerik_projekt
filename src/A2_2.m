% define parameters
params.I_max = 1000;
params.N = 100;
params.omega = 0.7;
params.c_k = 2;
params.c_s = 2;

% define functions
w = @(x) 1 + (x-1)./4;
L = @(x1,x2) sin(pi*w(x1)).^2 + ((w(x1) - 1).^2) .* (1 + 10 * sin(pi * w(x1) + 1).^2) + (w(x2) - 1).^2 .* (1 + sin(2*pi*w(x2)).^2) ;
k = 1:5; 
K = @(x1,x2) sum(k' .* cos((k+1)' .* x1 + k'), 1) .* sum(k' .* cos((k+1)' .* x2 + k'), 1);
S = @(x1,x2) arrayfun(@(a,b) K(a,b), x1, x2);
funcs{1} = L;
funcs{2} = S;

% define borders
gebiet(1,:) = [-10 10 -10 10];
gebiet(2,:) = [-5.1 5.1 -5.1 5.1];

% plot
for j = 1:2
    [bestX, bestFx, xHist, bHist] = PSO(funcs{j},gebiet(j,:),params);
    [x1, x2] = meshgrid(gebiet(j,1):0.1:gebiet(j,2),gebiet(j,3):0.1:gebiet(j,4));
    result = funcs{j}(x1,x2);
    figure;
    for i = 1:16
        subplot(4,4,i)
        hold on
        contour(x1,x2,result);
        scatter(squeeze(xHist(i,:,1)), xHist(i,:,2),[],"red");
        title("i = " + i);
        hold off
    end
end

