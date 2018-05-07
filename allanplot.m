#!/usr/bin/octave-cli --persist

# allanplot.m computes Allan deviation from temporal dataset
#
# use :	allanplot.m file.dat column_i gain_i ad_opt
#		allanplot.m file.dat [column_i,column_j] [gain_i,gain_j] [ad_opt_i,ad_opt_j]
#
# inputs:
#	file.dat : [string]			file to load
#	columns : int or [int]		columns to load
#	fs : int or [int]			sampling frequency
#	gains : float or [float]	gains to apply
#	ad_opt : int or [int]		ad options :
#										0 direct allan computation
#										1 drift removed ad
#										2 relative ad
#										3 relative drift removed ad

filename = argv(){1};
col = eval(argv(){2});
fs = eval(argv(){3});
mult = eval(argv(){4});
ad_opt = eval(argv(){5});

if length(col) == length(mult)
	figure
	hold all
	grid on
	cc = 'bkcgmry';
	for i = [1:length(col)]
		data.freq = load(filename)(:,col(i)).*mult(i);
		if nargin == 4
			if ad_opt(i) == 1
				printf(strcat(filename, ' col', num2str(col(i)), ' drift removed\n\n'))
				data.freq = detrend(data.freq);
			elseif ad_opt(i) == 2
				printf(strcat(filename, ' col', num2str(col(i)), ' relative ad : mean=', num2str(mean(data.freq)), '\n\n'))
				data.freq = data.freq./mean(data.freq);
			elseif ad_opt(i) == 3
				printf(strcat(filename, ' col', num2str(col(i)), ' drift removed relative ad\n\n'))
				data.freq = detrend(data.freq./mean(data.freq));
			end
		endif
		data.rate = fs(i);
		[ad, S, err, tau] = allan(data, 2.^[0:nextpow2(length(data.freq))-3]./data.rate, strcat(strsplit(filename, '/'){end}, num2str(i)), 0);
		loglogerr(tau, ad, err, strcat(cc(mod(i, length(cc))), '-s'))
		leg{i} = strcat(filename, ' col', num2str(col(i)));
		axis(10.^ceil(log10([tau(1), tau(end)])))
		hold on
	end
	legend(leg)
	input("Press to continue...");
end
exit
