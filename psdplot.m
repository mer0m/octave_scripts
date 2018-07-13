#!/usr/bin/octave-cli --persist

filename = argv(){1};
col = eval(argv(){2});
mult = eval(argv(){3});
data.rate = eval(argv(){4});
d = eval(argv(){5});

if length(col) == length(mult)
	figure
	hold all
	grid on
	cc = 'bkcgmry';
	for i = [1:length(col)]
		data.freq = diff(load(filename)(:,col(i)).*mult(i), d)*data.rate**d;
		[p, f] = pwelch(data.freq, hanning(length(data.freq)/1), 0.5, [], data.rate, 'onesided', 'power');
		semilogx(f, 10*log10(p), cc(mod(i, length(cc))))
		leg{i} = strcat(filename, ' col', num2str(col(i)));
		hold on
	end
	legend(leg)
	input("Press to continue...");
end
exit
