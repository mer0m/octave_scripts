#!/usr/bin/octave-cli

filename = argv(){1};
col = eval(argv(){2});
mult = eval(argv(){3});

data.freq = load(filename)(:,col).*mult;
data.rate = 1;

[ad, s, err, tau] = allan(data, 2.^(0:12), '', 0);
tosave = vertcat(tau, ad, err)';
save('-ascii', strcat(strsplit(filename, '.'){1}, '_ad.dat'), 'tosave');

exit
