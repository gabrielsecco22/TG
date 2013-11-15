function step_draw(individual)

    sensor_list =   evalin('base','sensor_list');
    obstacle_list = evalin('base','obstacle_list');
    circle =        evalin('base', 'circle');
    
    clf
    hold on
    
    %Draw sensors
    for k=1:size(sensor_list)
        plot(sensors(k,1),sensors(k,2),'*r');
    end
    
    %Draw obstacles
    inf=1;
    for k=1:obstacle_list(enD,enD)
        [aux,sup] = ismember(k,obstacle_list(:,3));
        plot(obstacle_list(inf:sup,1),obstacle_list(inf:sup,2),'-k');
        inf=sup+1;
    end
    
    %Draw routers
    for k=1:size(individual)
        patch(circle(1),circle(2),'b');
        alpha(0.2);
    end
end