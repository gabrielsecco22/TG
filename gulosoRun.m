clear

fileName = 'teste';
fileExt = '.mat';
file = 'teste1.mat';
figCoverageName = 'coverageteste';
figCCName = 'ccteste';
figAvgName = 'avgteste';
figExt ='.jpg';

matTest = [1 2 3 3 3 4 5 6 6 7 8 9 9 10];
matRot = [4 4 8 9 10 8 15 11 12 18 18 26 30 20];
fits1 = zeros(size(matTest,2),1);


for sqi = 1:size(matTest,2)
    
    file = strcat(fileName,strcat(num2str(matTest(1,sqi)),fileExt));
    file
    fits1
    load (file)
    
    range_router = 200;
    
    for ks = 1:100
        ns = guloso(matRot(1,sqi));
        if ns > fits1(sqi,1)
            fits1(sqi,1)=ns;
        end
    end


end

fits1