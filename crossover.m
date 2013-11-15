function cros = crossover (ind1,ind2,grain)

    cross_prob=0.6;
    a=ind1;
    b=ind2;
    for cromossomo=1:size(ind1,2) 
        if (rand() < cross_prob)
            rand_point = randi(grain)-1;
            mask1 = 0;
            for n =1:rand_point
                mask1 = mask1 + 2^n; 
            end
            
            mask2 = 2^grain - mask1 - 1;
            ind1(1,cromossomo);
            mask1;
            ind2(1,cromossomo);
            mask2;
            a(1,cromossomo)=bitand(ind1(1,cromossomo),mask1)+ bitand(ind2(1,cromossomo),mask2);
            b(1,cromossomo)=bitand(ind1(1,cromossomo),mask2)+ bitand(ind2(1,cromossomo),mask1);
        
        end
    end
    cros = [a;b];
end