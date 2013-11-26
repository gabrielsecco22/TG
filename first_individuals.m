function [individual] = first_individuals(n_routers)

    table = evalin('base','table');
    grain = evalin('base', 'grain');
    num_rot_need =-1;
    individual=zeros(1,2*n_routers);
    
    %Placing routers untill a new router cover zero sensors.
    for k=1:n_routers
        [aux, i]=max(table(:,:,1));
        [fit,j]=max(aux);
        i=i(j);
        sensores_cobertos_iter=table(i,j,1);
        
        if sensores_cobertos_iter == 0
            num_rot_need = k-1;
            break;
        else
            individual(1,2*k-1:2*k)=[i-1,j-1];
        end
        
        for sen=2:size(table,3)
       
            if table(i,j,sen)==1
                table(:,:,1)=table(:,:,1)-table(:,:,sen);
                table(:,:,sen)=zeros(size(table,1));
            end
        end
    end
    %Placing the remaining rounters randomly
    if num_rot_need >0
        for i=(num_rot_need+1):n_routers
            individual(1,2*i-1:2*i)=randi(2^grain-1,[1,2])-ones(1,2);
        end
    end
    
end
    
