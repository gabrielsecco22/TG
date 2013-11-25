function tam = compConex(A,init,t)
    tam = size(A,1);
    t = [t init];
    tam2 = size(t,2);
    for i=1:tam
        if A(init,i) ==1
           A(init,i)=0;
           A(i,init)=0;
           for j=1:tam2
            if 
                compConex(A,i,t);
            end
        end
    end
    
    
    
end

