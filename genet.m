    function [best_fit,last_avg,perfectfound] = genet(n_routers,num_iterations,num_individuals,num_teste,pop)
    
    %Constants and variables
    table = evalin('base','table');
    grain = evalin('base', 'grain');
    range = evalin('base','range');
    range_router = evalin('base','range_router');
    obs = evalin('base', 'obs');
    sens=evalin('base','sens');
    adjMat = zeros(num_individuals);
    isperfect = 0;
    perfectfound = 0;
    indexofperfect = 0;
    num_exec = 0;
    population = [];
    
    %Plot variables
    xmin= -round(2^grain)/20;
    xmax= 2^grain - xmin;
    ymin= xmin;
    ymax= xmax;
    
    
    %First Individuals Generator
    
     rp = 2^(grain-5);
     pop_n_routers = size(pop,2)/2;
     diff =n_routers - pop_n_routers;
     Matrand =  zeros(num_individuals,2*n_routers);
     if size(pop,1)==num_individuals && diff ==0
         population = pop;
     else if diff > 0
         if diff == n_routers
            Matrand =  randi([-rp rp],num_individuals,2*n_routers);
            cabra = first_individuals(n_routers);
            for t =1:num_individuals
                population(t,:) = cabra;
            end
         population = mod(population + Matrand,2^grain);

         else
             Matrand =  randi([1 2^grain-1],num_individuals,2*diff);
             population = [pop Matrand];
         end
         end
     end

    
    %Initial allocations
    best_fit=0;
    best_ind=0;
    fitness_values = zeros(num_individuals,1);
    new_generation = zeros(num_individuals,2*n_routers);
    
    avg_fit = zeros(1,num_iterations);
    max_fit_plot = zeros(1,num_iterations);
    best_fit_plot = zeros(1,num_iterations);
    %Stopping criteria = number of generations
    total_time = 0;
    for n=1:num_iterations
        
        %Condi��o de parada por saida perfeita.  
        if perfectfound == 1
            best_ind = population(indexofperfect,:);
            best_fit = fitness(best_ind,table);
            break;
        end
        
        num_exec = num_exec +1;
        
        %Fitness function evaluation for each individual
        tic
        
        for k=1:num_individuals
           [fitness_values(k,1), adjMat, isperfect] = fitness(population(k,:),table);
           if isperfect == 1
               perfectfound = 1;
               indexofperfect = k;
            end
        end
        toc
        
        
        %population average fitness
        avg_fit(n) = sum(fitness_values)/num_individuals;
        
        

        %Draw the individual with best fitness
        [max_fit,index_of_max]=max(fitness_values);
        max_fit_plot(n) =max_fit;
        if max_fit > best_fit
            best_fit = max_fit;
            n;
            best_ind = population(index_of_max,:);
        end
        
        best_fit_plot(n) = best_fit;
        
        
        if mod(n,10)==0
            
            strcat('avg= ',num2str(avg_fit(n)),' best= ',num2str(best_fit),' iteration= ',num2str(n),' total_time= ',num2str(total_time))
            
            if mod(n,50)==0
                save(strcat('result_teste',num2str(num_teste),'.mat'),'best_ind','population','avg_fit','best_fit_plot');
            end
            
        end
        
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
            new_generation(2*k-1:2*k,:) = crossover(population(x,:),population(y,:),grain);
        end

        %Perform mutation
        for k=1:num_individuals
            new_generation(k,:) = mutation(new_generation(k,:),grain);
        end
        if perfectfound ~= 1
            population = new_generation;
        end
        total_time = total_time +toc;
        
        %condi��o de parada por convergencia
%         if (best_fit - avg_fit(n) < 0.5) && n > 100
%             avg_fit(n)
%             break;
%         end

    end
    
    last_avg = avg_fit(num_exec);
    
    rout_list =zeros(size(best_ind,2)/2,2);
    for i=1:size(best_ind,2)/2
        rout_list(i,:)=[best_ind(1,2*i-1) best_ind(1,2*i)];
    end
    
    
    table_final=create_table(rout_list,obs,grain,range);
   
    table_final=mat2gray(table_final(:,:,1));
    
    %Solution Plot
    figure(3);
    hold off
    clf
    imshow(imrotate(table_final,90));
    
    hold on
    
    table_final_router=create_table(rout_list,obs,grain,range_router);

    
    [f A]=fitness(best_ind,table_final_router);
    B=largestcomponent(A);
    
    %router plot
    for i=1:size(best_ind,2)/2
        plot(best_ind(1,2*i-1),2^grain - best_ind(1,2*i),'b+');
    end
    
    %giant component indicator plot
    
    for i=1:size(B,2)
        plot(best_ind(1,2*B(1,i)-1),2^grain - best_ind(1,2*B(1,i)),'bo');
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
    
    %Plot router's giant component interconection lintes.
    drawlines = 1;
    for i = 1:size(A,1)
        for j = i:size(A,1)
            if drawlines == 1 && A(i,j) ==1
                dlx1 = best_ind(1,2*i-1);
                dly1 = best_ind(1,2*i);
                dlx2 = best_ind(1,2*j-1);
                dly2 = best_ind(1,2*j);
                plot([dlx1 dlx2],2^grain - [dly1 dly2],'m')
            end
        end
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
    axis([1 num_iterations 0 11])
    set(h1,'Displayname','Fitness M�dio');
    set(h2,'Displayname','Fitness M�ximo');
    legend('Location','southeast')
%     plot(best_fit_plot,'g');
    grid;
    
    end