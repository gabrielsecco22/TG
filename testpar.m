function testepar=testpar()
    tic;
    for i=1:10000
        x=ones(10000,1);
        y=fft(x);
    end
    toc;
end
