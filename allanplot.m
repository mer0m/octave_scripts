#!/usr/bin/octave-cli --persist

filename = argv(){1};
col = eval(argv(){2});
mult = eval(argv(){3});

data.freq = load(filename)(:,col).*mult;
data.rate = 1;

ad = allan(data, 2.^(0:nextpow2(length(data.freq))), strsplit(filename, '/'){end}, 1);
input("Press to continue...");
exit
