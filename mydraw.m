    
    %Plot variables
    xmin= -50;
    xmax= 562;
    ymin= -50;
    ymax= 562;

    %Solution Plot
    figure(1);
    clf
    hold on
    
    for i=1:size(sens,1)
        plot(sens(i,1), sens(i,2),'r*')
    end
    
    for i=1:size(obs,1)
        hold on
        plot([obs(i,1),obs(i,3)],[obs(i,2),obs(i,4)],'k');
    end
%     axis xy
    axis([xmin xmax ymin ymax])
    axis on
    
    
    %Router_range plot for giant component visualization
    
  
    
    figure(2);
    hold off
    clf
    imshow(imrotate(mat2gray(table(:,:,1)),90));
    
    hold on
    
    for i=1:size(sens,1)
        plot(sens(i,1),2^grain - sens(i,2),'r*')
    end
    
    for i=1:size(obs,1)
        hold on
        plot([obs(i,1),obs(i,3)],2^grain-[obs(i,2),obs(i,4)],'g');
    end
    
    axis([xmin xmax ymin ymax])
    axis on