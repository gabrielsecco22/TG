    function [best_fit] = genet(n_routers)
    
    %Constants and variables
    table = evalin('base','table');
    num_individuals = 400;
    num_iterations =100;
    grain = evalin('base', 'grain');
    range = evalin('base','range');
    range_router = evalin('base','range_router');
    obs = evalin('base', 'obs');
    sens=evalin('base','sens');
    
    %Plot variables
    xmin= -50;
    xmax= 562;
    ymin= -50;
    ymax= 562;
    
    
    %First Individuals Generator
     population =randi(2^grain,[num_individuals,2*n_routers])-ones(num_individuals,2*n_routers);
%      ini = round((9*num_individuals)/10);
%      for i=ini:num_individuals
%          population(i,:)=first_individuals(n_routers);
%      end
    
    
    

    %Initial allocations
    best_fit=0;
    best_ind=0;
    fitness_values = zeros(num_individuals,1);
    new_generation = zeros(num_individuals,2*n_routers);
    
    avg_fit = zeros(1,num_iterations);
    max_fit_plot = zeros(1,num_iterations);
    best_fit_plot = zeros(1,num_iterations);
    %Stopping criteria = number of generations
    tic
    for n=1:num_iterations
               
        if mod(n,10)==0
            n
        end
        
        %Fitness function evaluation for each individual
        
        for k=1:num_individuals
           [fitness_values(k,1)] = fitness(population(k,:),table);
        end
        
        
        %population average fitness
        avg_fit(n) = sum(fitness_values)/num_individuals;
        

        %Draw the individual with best fitness
        [max_fit,index_of_max]=max(fitness_values);
        max_fit_plot(n) =max_fit;
        if max_fit > best_fit
            best_fit = max_fit;
            n;
            best_ind = population(index_of_max,:);
            %Perfect individual found
            if best_fit == 2*(size(sens,1)^2) + n_routers^2
                break;
            end
        end
        
        best_fit_plot(n) = best_fit;
        
        %Choose the couples
        fitness_sum=sum(fitness_values);
        for m=1:num_individuals
            
            value = fitness_sum*rand();
            i=1;
            while value - fitness_values(i)>0
                value = value - fitness_values(i);
                i=i+1;
            end
            couples(m,1)=i;
        end
        
        %Crossover operation
        for k=1:num_individuals/2
            x = couples(2*k-1,1);
            y = couples(2*k,1);
            2*k;
            new_generation(2*k-1:2*k,:) = crossover(population(x,:),population(y,:),grain);
        end

        %Perform mutation
        for k=1:num_individuals
            new_generation(k) = mutation(new_generation(k),grain);
        end

        population = new_generation;

    end
    
    toc
    
    rout_list=[];
    
    for i=1:size(best_ind,2)/2
        rout_list=[rout_list;best_ind(1,2*i-1),best_ind(1,2*i)];
    end
    
    
    table_final=create_table(rout_list,obs,grain,range);
   
    table_final=mat2gray(table_final(:,:,1));
    
    %Solution Plot
    figure(3);
    hold off
    clf
    imshow(imrotate(table_final,90));
    
    hold on
    
    for i=1:size(best_ind,2)/2
        plot(best_ind(1,2*i-1),2^grain - best_ind(1,2*i),'b+');
    end
    
    for i=1:size(sens,1)
        plot(sens(i,1),2^grain - sens(i,2),'r*')
    end
    
    for i=1:size(obs,1)
        hold on
        plot([obs(i,1),obs(i,3)],2^grain-[obs(i,2),obs(i,4)],'g');
    end
%     axis xy
    axis([xmin xmax ymin ymax])
    axis on
    
    
    %Router_range plot for giant component visualization
    
    
    table_final_router=create_table(rout_list,obs,grain,range_router);
   
    table_final_router=mat2gray(table_final_router(:,:,1));
    
    
    figure(6);
    hold off
    clf
    imshow(imrotate(table_final_router,90));
    
    hold on
    
    for i=1:size(best_ind,2)/2
        plot(best_ind(1,2*i-1),2^grain - best_ind(1,2*i),'b+');
    end
    
    for i=1:size(sens,1)
        plot(sens(i,1),2^grain - sens(i,2),'r*')
    end
    
    for i=1:size(obs,1)
        hold on
        plot([obs(i,1),obs(i,3)],2^grain-[obs(i,2),obs(i,4)],'g');
    end
    
%     axis xy
    axis([xmin xmax ymin ymax])
    axis on
    
    figure(7);
    hold off
    clf
    hold on
    h1=plot(avg_fit,'r');
    h2=plot(max_fit_plot,'b');
    set(h1,'Displayname','Fitness M�dio');
    set(h2,'Displayname','Fitness M�ximo');
    legend('Location','southeast')
%     plot(best_fit_plot,'g');
    grid;
    

end