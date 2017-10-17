#!/usr/bin/octave-cli --persist

filename = argv(){1};
col = eval(argv(){2});
mult = eval(argv(){3});

if length(col) == length(mult)
    figure
    hold all
    grid on
    cc = 'bkcgmry';
    for i = [1:length(col)]
        data.freq = load(filename)(:,col(i)).*mult(i);
        data.rate = 1;
        [ad, S, err, tau] = allan(data, 2.^[0:nextpow2(length(data.freq))-3]./data.rate, strcat(strsplit(filename, '/'){end}, num2str(i)), 0);
        loglogerr(tau, ad, err, cc(mod(i, length(cc))))
        leg{i} = strcat(filename, ' col', num2str(col(i)));
        hold on
    end
    legend(leg)
    input("Press to continue...");
end
exit
