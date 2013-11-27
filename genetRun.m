
fileName = 'teste';
fileExt = '.mat';
file = 'teste1.mat';
figCoverageName = 'coverageteste';
figCCName = 'ccteste';
figAvgName = 'avgteste';
figExt ='.jpg';


matTest = [1 2 3 4 5 6 7 8 9 10];
% matRotini = [4 4 8 8 15 12 18 18 30 22];
matRotfinal = [7 7 11 12 16 14 22 22 40 30];
matIt = [100 100 200 200 400 400 600 600 1000 1000];
matPop = [100 100 200 200 400 400 600 600 1600 800];
fits1 = zeros(size(matTest,2),1);
avgs = zeros(size(matTest,2),1);
perfectfound=0;

% for sqi = 1:size(matTest,2)
for sqi = 1:2
    file = strcat(fileName,strcat(num2str(matTest(1,sqi)),fileExt));
    load (file)
    [f initial] = guloso(50);
    for k = initial:matRotfinal(1,sqi)
    [a,b,perfectfound] = genet(k,80*k,80*k,sqi,[]);
        if perfectfound ==1
            fits(sqi) =a;
            avgs(sqi) =b;
            hgexport(figure(3), strcat(figCoverageName,strcat(num2str(sqi),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
            hgexport(figure(6), strcat(figCCName,strcat(num2str(sqi),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
            hgexport(figure(7), strcat(figAvgName,strcat(num2str(sqi),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
            perfectfound=0;
            break;
        end
    end

    
end