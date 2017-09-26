function T = res2temp16945(R)

res2temp16945 = @(R) 10.^(3.2497 * (log10(1000./R)).^2 + 5.1777 * log10(1000./R) + 2.499);

T = res2temp16945(R);
