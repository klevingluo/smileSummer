figure(3);
input = '10.jpg';

[Xs, Ys] = getLandmark(input);

for k=1:83
    disp(['<part name=''', int2str(k), ''' x=''', int2str(Xs(k)), ''' y=''', int2str(Ys(k)), ''' />'])
end