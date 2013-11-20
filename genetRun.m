
fileName = 'teste';
fileExt = '.mat';
file = 'teste1.mat';
figCoverageName = 'coverageteste';
figCCName = 'ccteste';
figAvgName = 'avgteste';
figExt ='.jpg';

matTest = [1 2 3 4 5 6 7 8 9 10];
matRot = [4 4 8 8 15 12 18 18 30 22];
matIt = [100 100 200 200 400 400 600 600 1000 1000];
matPop = [100 100 200 200 400 400 600 600 1600 800];
fits1 = zeros(size(matTest,2),1);
avgs = zeros(size(matTest,2),1);

for sqi = 9:size(matTest,2)
    file = strcat(fileName,strcat(num2str(matTest(1,sqi)),fileExt));
    load (file)
    range_router = 200;
    [fits(sqi),avgs(sqi)] = genet(matRot(1,sqi),matIt(1,sqi),matPop(1,sqi),300+sqi,[]);
    fits
    avgs

    hgexport(figure(3), strcat(figCoverageName,strcat(num2str(sqi+300),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
    hgexport(figure(6), strcat(figCCName,strcat(num2str(sqi+300),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
    hgexport(figure(7), strcat(figAvgName,strcat(num2str(sqi+300),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
end