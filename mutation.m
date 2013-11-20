function individual = mutation(individual, grain)
    
    numbits = grain * size(individual,2);
    constant = 1/5;
    probability = constant / numbits;
%     probability = 0.001;
    
    for k=1:size(individual,2)
        mask=0;
        for i=0:grain-1
            if rand()<probability
                mask=mask+2^i;
            end
        end
        individual(1,k)=bitxor(individual(1,k),mask);
                
    end

end