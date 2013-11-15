function fitness = fitness(individual,table)

num_sensor = size(table,3)-1;
coverage_list = zeros(1,num_sensor);
bagua_list =zeros(1,num_sensor);
num_rot = size(individual);
num_rot = num_rot(2)/2;
alpha=0.6;
%Each router contribute to the fitness with a bonus defined at this table
for k=1:num_rot
    
    x=individual(1,2*k-1);
    y=individual(1,2*k);
    for n =1: num_sensor
        if table(x+1,y+1,n+1) == 1
           coverage_list(1,n) = 1;
           bagua_list(1,n) = bagua_list(1,n)+1; 
        end
    end
    
end
count = 0;
for n =1: num_sensor
    if  bagua_list(1,n) == 0
       count = count +bagua_list(1,n); 
    end
end

%More penalizations or bonus here

Adj=zeros(num_rot);

range_router=evalin('base','range_router');
vert_list=evalin('base', 'vertl');
obstacle_list=evalin('base', 'obs');

for i=1:num_rot
    for j=i:num_rot
        
        xi=individual(1,2*i-1);
        yi=individual(1,2*i);
        
        xj=individual(1,2*j-1);
        yj=individual(1,2*j);
        
        distance= sqrt((xi-xj)^2+(yi-yj)^2);
                     
        if distance <= range_router;

            count=0;

            %se intercepta o intervalo aberto
            for k=1:size(obstacle_list,1)
                p1_x=obstacle_list(k,1);
                p1_y=obstacle_list(k,2);
                p2_x=obstacle_list(k,3);
                p2_y=obstacle_list(k,4);

                if intercept(xi,yi,xj,yj,p1_x,p1_y,p2_x,p2_y)
                    count=count+1;
                end
            end

            %vert_list=[];
            %se intercepa os pontos
            for k=1:size(vert_list,1)
                p_x=vert_list(k,1);
                p_y=vert_list(k,2);
                if (p_x-xj)^2 +(p_y-yj)^2 <= range_router^2
                    %if xi*(yj-p_y)-yi*(xj-p_x)+xj*p_y-yj*p_x==0 
                    %if xi*yj-xi*p_y-yi*xj+yi*p_x+xj*p_y-yj*p_x==0
                    if double(xi)*double(yj)-double(xi)*double(p_y)-double(yi)*double(xj)+double(yi)*double(p_x)+double(xj)*double(p_y)-double(yj)*double(p_x)==double(0)
                        if (p_x>xi && p_x<xj || p_x>xj && p_x<xi)||(p_y>yi && p_y<yj || p_y>yj && p_y<yi)
                            count=count+1;
                        end
                    end
                end
            end

            if distance <= range_router*alpha^count                   
                Adj(i,j)=1;
            end
        end
    end
end

B=largestcomponent(Adj);
tam_cc=size(B,2);

fitness = 2*(sum(coverage_list))^2 + tam_cc^2;
if fitness < 0
   fitness = 0; 
end

end
