clear

fileName = 'teste';
fileExt = '.mat';
file = 'teste1.mat';
figCoverageName = 'coverageteste';
figCCName = 'ccteste';
figAvgName = 'avgteste';
figExt ='.jpg';
figname = 'aleatorio';

matTest = [1 2 3 4 5 6 7 8 9 10];
matRot = [6 5 14 12 20 17 21 18 34 21];
matIt = [200 200 400 400 600 600 800 800 1200 1200];
fits1 = zeros(size(matTest,2),1);



for sqi = 1:size(matTest,2)
    vetFit =zeros(1,matIt(1,sqi));
    file = strcat(fileName,strcat(num2str(matTest(1,sqi)),fileExt));
    
    load (file)
     
    fits1(sqi,1) = aleatorio(matRot(1,sqi),matIt(1,sqi),matIt(1,sqi));
  
    
    hgexport(figure(7), strcat(figname,strcat(num2str(sqi),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
    
    
    file
    fits1


end
