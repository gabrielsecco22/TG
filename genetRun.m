clear

fileName = 'teste';
fileExt = '.mat';
file = 'teste1.mat';
figCoverageName = 'coverageteste';
figCCName = 'ccteste';
figAvgName = 'avgteste';
figExt ='.jpg';

matTest = [1 2 3 4 5 6 7 8 9 10];
matRot = [4 4 8 8 15 12 18 18 26 20];
matIt = [50 100 200 200 ];
matPop = [];
fits1 = zeros(size(matTest,2),1);


for sqi = 1:size(matTest,2)
    
    file = strcat(fileName,strcat(num2str(matTest(1,sqi)),fileExt));
    fits1
    load (file)
    
    range_router = 200;
    
    for ks = 1:100
        ns = genet(matRot(1,sqi),matIt(1,sqi),matPop(1,sqi));
        if ns > fits1(sqi,1)
            fits1(sqi,1)=ns;
        end
    end


end

    hgexport(figure(3), strcat(figCoverageName,strcat(num2str(i),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
    hgexport(figure(6), strcat(figCCName,strcat(num2str(i),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
    hgexport(figure(7), strcat(figAvgName,strcat(num2str(i),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
end