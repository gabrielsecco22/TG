function [table,vert_list] = create_table(sensor_list,obstacle_list,grain,range)

    alpha =0.6;
    num_sensors = size(1);
    %Create a table
    table=(zeros(2^grain,2^grain,num_sensors+1));
    
    vert_list=[];
    
    for i=1:size(obstacle_list,1)
        for j=1:2
            add=1;
            for k=1:size(vert_list,1)
                if vert_list(k,1)==obstacle_list(i,2*j-1)
                    if vert_list(k,2)==obstacle_list(i,2*j)
                        add=0;
                        break;
                    end
                end
            end
            if add==1
                x=obstacle_list(i,2*j-1);
                y=obstacle_list(i,2*j);
                vert_list=[vert_list;x,y];
            end
        end
    end
        
    for i=1:2^grain
        for j=1:2^grain
            for n=1:size(sensor_list,1)
                
               
                s_x = sensor_list(n,1);
                s_y = sensor_list(n,2);
                
                d2 = (i-s_x)^2 + (j-s_y)^2;
                d=sqrt(double(d2));
             
                if d <= range;
                    
                    count=0;
                    
                    %se intercepta o intervalo aberto
                    for k=1:size(obstacle_list,1)
                        p1_x=obstacle_list(k,1);
                        p1_y=obstacle_list(k,2);
                        p2_x=obstacle_list(k,3);
                        p2_y=obstacle_list(k,4);
                        
                        if intercept(i,j,s_x,s_y,p1_x,p1_y,p2_x,p2_y)
                            count=count+1;
                        end
                    end
                    
                    %vert_list=[];
                    %se intercepa os pontos
                    for k=1:size(vert_list,1)
                        p_x=vert_list(k,1);
                        p_y=vert_list(k,2);
                        if (p_x-s_x)^2 +(p_y-s_y)^2 <= range^2
                            %if i*(s_y-p_y)-j*(s_x-p_x)+s_x*p_y-s_y*p_x==0 
                            %if i*s_y-i*p_y-j*s_x+j*p_x+s_x*p_y-s_y*p_x==0
                            if double(i)*double(s_y)-double(i)*double(p_y)-double(j)*double(s_x)+double(j)*double(p_x)+double(s_x)*double(p_y)-double(s_y)*double(p_x)==double(0)
                                if (p_x>i && p_x<s_x || p_x>s_x && p_x<i)||(p_y>j && p_y<s_y || p_y>s_y && p_y<j)
                                    count=count+1;
                                end
                            end
                        end
                    end
                                                            
                    if d <= range*alpha^count                   
                        table(i,j,1)=table(i,j,1)+1;
                        table(i,j,n+1) = 1;
                    end
                end
            end
        end
    end                         
end