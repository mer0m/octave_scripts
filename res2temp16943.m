function T = res2temp16943(R)

res2temp16943 = @(R) 10.^(3.4738 * (log10(1000./R)).^2 + 5.1198 * log10(1000./R) + 2.3681);

T = res2temp16943(R);
