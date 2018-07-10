#!/usr/bin/octave-cli --persist

filename = argv(){1};
col1 = eval(argv(){2});
col2 = eval(argv(){3});
mult1 = eval(argv(){4});
mult2 = eval(argv(){5});

if length(col1) == length(mult1)
	figure
	hold all
	grid on
	cc = 'bkcgmry';
	for i = [1:length(col1)]
		data.freq = load(filename)(:,col1(i)).*mult1(i);
		data.freq2 = load(filename)(:,col2(i)).*mult2(i);
		data.freq = data.freq(1:min(length(data.freq), length(data.freq2)));
		data.freq2 = data.freq2(1:min(length(data.freq), length(data.freq2)));
		if eval(argv(){end-1}) == 1
			printf('\ndata1 drift removed\n\n')
			data.freq = detrend(data.freq);
		end
		if eval(argv(){end}) == 1
			printf('\ndata2 drift removed\n\n')
			data.freq2 = detrend(data.freq2);
		end
		data.rate = 1;
		[ad, S, err, tau] = allan_cov(data, horzcat(reshape([1:0.1:9]'.*10.^[0:round(log10(length(data.freq)))-1],1,[]), 10^(round(log10(length(data.freq)))-1))./data.rate, strcat(strsplit(filename, '/'){end}, num2str(i)), 0);
		loglogerr(tau, ad, err, strcat(cc(mod(i, length(cc))), '-s'))
		leg{i} = strcat(filename, ' cov col', num2str(col1(i)), ' col', num2str(col2(i)));
		axis(10.^ceil(log10([tau(1), tau(end)])))
		hold on
	end
	legend(leg)
	input("Press to continue...");
end
exit
