function T = res2temp16941(R)

res2temp16941 = @(R) 10.^(2.9486 * (log10(1000./R)).^2 + 4.5862 * log10(1000./R) + 2.266);

T = res2temp16941(R);
