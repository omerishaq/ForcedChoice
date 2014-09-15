function [ TPlist, TNlist ] = create_TP_TN( Data )

TPlist = [];
TNlist = [];
% create the true positive TP list and the true negative TN list
for i = 1:length(Data)
    element = Data(i);
    
    logicalIndexOfElementTP = arrayfun(@(x)all((x.r == element.r)&&(x.c==element.c)),TPlist);
    [t1] = find(logicalIndexOfElementTP);
    logicalIndexOfElementTN = arrayfun(@(x)all((x.r == element.r)&&(x.c==element.c)),TNlist);
    [t2] = find(logicalIndexOfElementTN);
    
    if isempty(t1) && isempty(t2)
        logicalIndexOfElement = arrayfun(@(x)all((x.r == element.r)&&(x.c==element.c)),Data);
        [Indices_t] = find(logicalIndexOfElement);
        data_subset = Data(Indices_t);
    
        loe = arrayfun(@(x)all((x.peak == 1)),data_subset);
        [Indices_p] = find(loe);
        disp([num2str(length(Indices_p)) '   ' num2str(length(Indices_t))])
        if length(Indices_p) > length(Indices_t)/2;
            if isempty(TPlist)
                clear TPlist;
                TPlist(1)=element; 
            else
                TPlist(end+1)=element;
            end
                
        else
            if isempty(TNlist)
                clear TNlist;
                TNlist(1)=element; 
            else
                TNlist(end+1)=element;
            end
            
        end
        
    end

end


end

