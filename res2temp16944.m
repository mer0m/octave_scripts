function T = res2temp16944(R)

res2temp16944 = @(R) 10.^(3.3674 * (log10(1000./R)).^2 + 5.2874 * log10(1000./R) + 2.5165);

T = res2temp16944(R);
