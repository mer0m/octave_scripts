#!/usr/bin/octave-cli --persist

filename = argv(){1};
col = eval(argv(){2});
mult = eval(argv(){3});
data.fs = eval(argv(){4});
f_hp = eval(argv(){5});

[b, a] = butter (3, f_hp, "high");

if length(col) == length(mult)
	figure
	hold all
	grid on
	cc = 'bkcgmry';
	for i = [1:length(col)]
		data.x = filter(b, a, load(filename)(:,col(i)).*mult(i))(floor(end/4):end);
		N = length(data.x);
		f = (data.fs/N)*((-(N-1)/2):((N-1)/2));
		X = abs(fftshift(ifft(data.x)));
		plot(f, X, cc(mod(i, length(cc))))
		leg{i} = strcat(filename, ' col', num2str(col(i)));
		hold on
	end
	legend(leg)
	input("Press to continue...");
end
exit
