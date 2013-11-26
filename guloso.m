function [fit,num_rot_need] = guloso(n_routers)

    table = evalin('base','table');
    grain = evalin('base', 'grain');
    obs = evalin('base','obs');
    sens= evalin('base', 'sens');
    range= evalin('base', 'range');
    num_rot_need =-1;
    table_copy=table;
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
            individual(1,2*i-1:2*i)=randi(2^grain,[1,2])-ones(1,2);
        end
    end
    
    [aux, i]=max(table(:,:,1));
    [fit,j]=max(aux);
    i=i(j);
    table(i,j,1);
    
    [fit A]=fitness(individual,table_copy);
    B=largestcomponent(A);
    
    
    rout_list=[];
    
    for i=1:size(individual,2)/2
        rout_list=[rout_list;individual(1,2*i-1),individual(1,2*i)];
    end
    
    
    %Plotting the solution
%     table_final=create_table(rout_list,obs,grain,range);
%     table_final=mat2gray(table_final(:,:,1));
%     
%     figure(4);
%     hold off
%     clf
%     imshow(imrotate(table_final,90));
%     hold on
%     
%     for i=1:size(individual,2)/2
%         plot(individual(1,2*i-1),2^grain - individual(1,2*i),'b+');
%     end
%     
%     for i=1:size(B,2)
%         plot(individual(1,2*B(1,i)-1),2^grain - individual(1,2*B(1,i)),'bo');
%     end
%     
%     for i=1:size(sens,1)
%         plot(sens(i,1),2^grain - sens(i,2),'r*')
%     end
%     
%     for i=1:size(obs,1)
%         hold on
%         plot([obs(i,1),obs(i,3)],2^grain-[obs(i,2),obs(i,4)],'g');
%     end
end
    
