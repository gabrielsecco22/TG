function x=intercept(i,j,s_x,s_y,p1_x,p1_y,p2_x,p2_y)

    x=0;
    
    %v= ponto-sensor
    v_x=i-s_x;
    v_y=j-s_y;
    
    %a=ponto-barreira1
    a_x=i-p1_x;
    a_y=j-p1_y;
    
    %b=ponto-barreira2
    b_x=i-p2_x;
    b_y=j-p2_y;
    
    %cross1 = v X a
    cross_1 = v_x*a_y - v_y*a_x;
    
    %cross1 = v X b
    cross_2 = v_x*b_y - v_y*b_x;
    
    
    if cross_1*cross_2<0
        
        v_x=p1_x-p2_x;
        v_y=p1_y-p2_y;
    
        a_x=p1_x-i;
        a_y=p1_y-j;
    
        b_x=p1_x-s_x;
        b_y=p1_y-s_y;
    
        cross_3 = v_x*a_y - v_y*a_x;
        cross_4 = v_x*b_y - v_y*b_x;
       
        if cross_3*cross_4<0
            x=1;
        end
        
    end
        
        
end
    
    