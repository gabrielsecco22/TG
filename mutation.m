function individual = mutation(individual, grain)
    
    probability = 0.03;
    
    for k=1:size(individual)
        
        mask=0;
        for i=0:grain-1
            if rand()<probability
                mask=mask+2^i;
            end
        end
        individual(k)=bitxor(individual(k),mask);
                
    end

end