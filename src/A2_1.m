
i = 1:5; 
S = @(x1,x2) sum(i' .* cos((i+1)' .* x1 + i'), 1) .* sum(i' .* cos((i+1)' .* x2 + i'), 1);
omega_S = -5.1:0.1:5.1; 
[x1, x2] = meshgrid(omega_S); 
result = arrayfun(@(a,b) S(a,b), x1, x2); 
subplot(2,2,1)
surf(x1, x2, result); 
title("Surface Plot der Shubert-Funktion")
subplot(2,2,2)
contour(x1,x2,result)
title("Contour Plot der Shubert-Funktion")


w = @(x) 1 + (x-1)./4;
L = @(x1,x2) sin(pi*w(x1)).^2 + ((w(x1) - 1).^2) .* (1 + 10 * sin(pi * w(x1) + 1).^2) + (w(x2) - 1).^2 .* (1 + sin(2*pi*w(x2)).^2) ;
omega_L = -10:0.1:10;
[x1, x2] = meshgrid(omega_L);
result = L(x1,x2);
subplot(2,2,3)
surf(x1,x2,result)
title("Surface Plot der Levy-Funktion")
subplot(2,2,4)
contour(x1,x2,result)
title("Contour Plot der Levy-Funktion")

result(islocalmin(result))
min(result,[],"all")
