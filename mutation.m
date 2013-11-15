function individual = mutation(individual, grain)
    
<<<<<<< HEAD
    probability = 0.1;
=======
    probability = 0.05;
>>>>>>> 253bd49192da9aa84a2ea0d14763aedb820b0d89
    
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