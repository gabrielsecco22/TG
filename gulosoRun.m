clear

fileName = 'teste';
fileExt = '.mat';
file = 'teste1.mat';
figCoverageName = 'coverageteste';
figCCName = 'ccteste';
figAvgName = 'avgteste';
figExt ='.jpg';

matTest = [1 2 3 4 5 6 7 8 9 10];
matRot = [6 5 14 12 20 17 21 18 34 21];
fits1 = zeros(size(matTest,2),1);


for sqi = 1:size(matTest,2)
    
    file = strcat(fileName,strcat(num2str(matTest(1,sqi)),fileExt));
    
    load (file)
    
    
    for ks = 1:100
        ns = guloso(matRot(1,sqi));
        if ns > fits1(sqi,1)
            fits1(sqi,1)=ns;
        end
    end
    file
    fits1


end
