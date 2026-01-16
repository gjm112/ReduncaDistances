toothtype = "LM2"
dddd = readtable("/Users/gregorymatthews/Dropbox/teeth-scriptus-pricei/data/matlab/pairwise_distances_" + toothtype + ".csv")
%dddd = readtable("/Users/gregorymatthews/Dropbox/teeth-scriptus-pricei/data/matlab/nas/pairwise_distances_" + toothtype + ".csv")
%dddd = readtable("/Users/gregorymatthews/Dropbox/teeth-scriptus-pricei/data/matlab/pairwise_distances_" + toothtype + ".csv")
dddd = table2array(dddd)
%$dddd(40,:) = []
%dddd(:,40) = []
size(dddd)

figure(1);clf
imagesc(dddd)
colorbar

y = mdscale(dddd, 2)
figure(1); clf
plot(y(1:38,1),y(1:38,2),'*r',LineWidth=5)
hold on;
plot(y(39:end,1),y(39:end,2),'*g',LineWidth=5)
