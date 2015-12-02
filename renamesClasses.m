numObs = length(classes);

unique_classes = unique(classes);

num_unique_classes = length(unique_classes);

transformed_classes = zeros(numObs,1); 

for k=1:num_unique_classes
    for j=1:numObs 
        indices = strcmp(classes(j),unique_classes(k));
        if(indices~=0) 
            transformed_classes(j) = k;
        end
    end
end
    
 
