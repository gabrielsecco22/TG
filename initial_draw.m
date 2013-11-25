function[table,sensor_list,obstacle_list,vert_list]= initial_draw()

    grain = evalin('base', 'grain');
    range = evalin('base', 'range');
    
    sensor_list=int16([]);
    vertice_list=int16([]);
    
    Size = 2^grain;
    
    figure(1);
    clf
    hold on;
    axis manual;
    axis square;
    axis((Size+1)*[-0.15 1.15 -0.15 1.15]);
    
    %Draw border
    plot([0.6 Size+0.4 Size+0.4 0.6 0.6],[0.6 0.6 Size+0.4 Size+0.4 0.6],'-k');
    
    
    %Draw everything else
    [x,y,key] = ginput(1);
    x=uint16(x);
    y=uint16(y);
    
    obstacle_index=1;
    
    while char(key) ~= 'q' 
        
        if char (key) == 's'
            sensor_list=[sensor_list;x,y];
            plot(x,y,'r*');
        end
        
        if char(key) == 'v'
            vertice_list = [vertice_list; x,y,obstacle_index];
            [aux,start] = ismember(obstacle_index-1,vertice_list(:,3));
            plot(vertice_list(start+1:end,1),vertice_list(start+1:end,2),'-k');
        end
        
        if char(key) == 'o'
            obstacle_index = obstacle_index+1;
        end
        
        [x,y,key] = ginput(1);
        x=uint16(x);
        y=uint16(y);
        
    end
    
    hold off
    
    
    obstacle_list=vert2seg(vertice_list)
    
    [table,vert_list]=create_table(sensor_list,obstacle_list,grain,range);
    %{
    for i=1:size(table,1)
        for j=1:size(table,2)
            if table(i,j)>0
                plot(i,j,'ro')
            end
        end
    end
    %}
    
   % table=filter2(fspecial('gaussian',[4 4],15),uint16(table));
    table_x=mat2gray(table(:,:,1));
    
    figure(2);
    
    clf
    imshow(imrotate(table_x,90));
    hold on
    obs=obstacle_list;
    sens=sensor_list;
    for i=1:size(obs,1)
        plot([obs(i,1),obs(i,3)],2^grain-[obs(i,2),obs(i,4)],'g');
    end
    for i=1:size(sens,1)
       plot(sens(i,1),2^grain - sens(i,2),'r*')
    end
    
    
   

end