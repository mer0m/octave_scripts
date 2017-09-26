function T = res2temp16947(R)

res2temp16947 = @(R) 10.^(3.4597 * (log10(1000./R)).^2 + 5.2422 * log10(1000./R) + 2.4169);

T = res2temp16947(R);
