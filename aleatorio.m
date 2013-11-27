function [best_fit] = aleatorio(n_routers,num_iterations,num_individuals)

    table = evalin('base','table');
    grain = evalin('base', 'grain');
    obs = evalin('base','obs');
    sens= evalin('base', 'sens');
    range= evalin('base', 'range');
    best_fit=0;
    best_ind=0;
    fitness_values = zeros(num_individuals,1);
    
    table_copy=table;
    
    individual=zeros(1,2*n_routers);
    
    avg_fit = zeros(1,num_iterations);
    max_fit_plot = zeros(1,num_iterations);
    best_fit_plot = zeros(1,num_iterations);
    
    for i=1:num_iterations
        population =randi(2^grain,[num_individuals,2*n_routers]);
        population= population -ones(num_individuals, 2*n_routers);
        
        for k=1:num_individuals
           fitness_values(k,1) = fitness(population(k,:),table);
        end

        [max_fit,index_of_max]=max(fitness_values);
         max_fit_plot(i) =max_fit;
         avg_fit(i) = sum(fitness_values)/num_individuals;
         
        if max_fit > best_fit
            best_fit = max_fit;
            best_ind = population(index_of_max,:);
            if best_fit == size(sens,1)^2 + size(sens,1)
                break;
            end
        end
    end
    
    figure(7);
    hold off
    clf
    hold on
    h1=plot(avg_fit,'r');
    h2=plot(max_fit_plot,'b');
    axis([1 num_iterations 0 11])
    set(h1,'Displayname','Fitness Médio');
    set(h2,'Displayname','Fitness Máximo');
    legend('Location','north')
%     plot(best_fit_plot,'g');
    grid;
    
    
    
    
   %%% hora de printar!!
%     rout_list=[];
%     individual = best_ind;
%     for i=1:size(individual,2)/2
%         rout_list=[rout_list;individual(1,2*i-1),individual(1,2*i)];
%     end
%     
%     
%     table_final=create_table(rout_list,obs,grain,range);
%    
%     table_final=mat2gray(table_final(:,:,1));
%     
%     
%     figure(5);
%     hold off
%     clf
%     imshow(imrotate(table_final,90));
%     hold on
%     
%     for i=1:size(individual,2)/2
%         plot(individual(1,2*i-1),2^grain - individual(1,2*i),'b+');
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
    
