#!/usr/bin/octave-cli -q

# dat2allan.m computes Allan deviation from temporal dataset and disp the result to stdout (with tab spaced values)
#
# use with gnuplot:
#		set log xy
#		set format "%E"
#		plot "< dat2allan.m 'file.dat' column_i gain_i ad_opt" u 1:2:3 with yerrorlines
#	or
#		plot "< dat2allan.m 'file.dat' [column_i,column_j] [gain_i,gain_j] [ad_opt_i,ad_opt_j]" u 1:2:3 with yerrorlines
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
	ad_all = [];
	for i = [1:length(col)]
		data.freq = load(filename)(:,col(i)).*mult(i);
		if ad_opt(i) == 1
			data.freq = detrend(data.freq);
		elseif ad_opt(i) == 2
			data.freq = data.freq./mean(data.freq);
		elseif ad_opt(i) == 3
			data.freq = detrend(data.freq./mean(data.freq));
		end
		data.rate = fs(i);
		[ad, S, err, tau] = allan(data, horzcat(reshape([1:0.1:9]'.*10.^[0:round(log10(length(data.freq)))-1],1,[]), 10^(round(log10(length(data.freq)))-1))./data.rate, strcat(strsplit(filename, '/'){end}, num2str(i)), 0);
		ad_all = horzcat(ad_all, ad', err');
	end
end
dlmwrite(stdout, horzcat(tau', ad_all), '\t')
exit
