#!/usr/bin/octave-cli

filename = argv(){1};
col = eval(argv(){2});
mult = eval(argv(){3});
ad_opt = eval(argv(){4});

if length(col) == length(mult)
	for i = [1:length(col)]
		data.freq = load(filename)(:,col(i)).*mult(i);
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
		data.rate = 1;
		[ad, S, err, tau] = allan(data, 2.^[0:nextpow2(length(data.freq))-3]./data.rate, strcat(strsplit(filename, '/'){end}, num2str(i)), 0);
		ad_tosave{i} = vertcat(ad, err)';
	end
tosave = tau';
for i = [1:length(col)]
	tosave = horzcat(tosave, ad_tosave{i});
end
save('-ascii', '-double', '-tabs', strcat(strsplit(filename, '.'){1}, '_ad.dat'), 'tosave');
end
