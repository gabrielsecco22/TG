function [segment_list] = vert2seg(vertice_list)
    
    segment_list=[];

    for k=1:size(vertice_list,1)-1
        if(vertice_list(k,3)==vertice_list(k+1,3))
            x1=vertice_list(k,1);
            y1=vertice_list(k,2);
            x2=vertice_list(k+1,1);
            y2=vertice_list(k+1,2);
            segment_list=[segment_list; x1 y1 x2 y2];
        end
     end
end