function tam = compConex(A,init,t)
    tam = size(A,1);
    for i=1:tam
        if A(init,i) ==1
           t = [t i];
           A(init,i)=0;
           A(i,init)=0;
        end
    end
    
    
    
end

