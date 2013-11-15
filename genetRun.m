clear;

fileName = 'teste';
fileExt = '.mat';
file = 'teste1.mat';
figCoverageName = 'coverageteste';
figCCName = 'ccteste';
figExt ='.jpg';

for i = 1:2
    
    file = strcat(fileName,strcat(num2str(i),fileExt));
    
    load (file)
    
    sens=evalin('base','sens');

    tam = size(sens,1);
    
    [fit,num_need]=guloso(1);
    n = 2;
    while num_need == -1
        [fit,num_need]=guloso(n);
        n=n+1;
    end

    n= num_need
    tic;
    curr_fit =genet(n)
    tempo_Fase1 = toc
    %Must be changed if fitness expression changes.
    fit_perfect_solution = 2*tam^2 + n^2

    while curr_fit < fit_perfect_solution
        n=n+1;
        curr_fit=genet(n)
        fit_perfect_solution= 2*tam^2 + n^2

    end
    tempoFase2 = toc - tempo_Fase1
    hgexport(figure(3), strcat(figCoverageName,strcat(num2str(i),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
    hgexport(figure(6), strcat(figCCName,strcat(num2str(i),figExt)), hgexport('factorystyle'), 'Format', 'jpeg');
end