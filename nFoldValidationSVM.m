function [accuracy] = nFoldValidationSVM(features,labels,n,K)
 
% numClasses = 5;
featureSet = size(features);
setSize = featureSet(1);
testSetSize = round(setSize/n);
trainSetSize = setSize - testSetSize;
accuracy = 0;
% positives = 0;

% randomize the songs sequence
randomPositions = randi(setSize,setSize,1);

% confusionMatrices = zeros(numClasses,numClasses,10);

for i=1:n
    
    testData = features(randomPositions(i*testSetSize-testSetSize+1:i*testSetSize),:);
    testLabels = labels(randomPositions(i*testSetSize-testSetSize+1:i*testSetSize),:);
  
    if i==n
        trainData  = features(randomPositions(1:i*testSetSize-testSetSize),:);
        trainLabels = labels(randomPositions(1:i*testSetSize-testSetSize));
    else 
        if i==1
           trainData = features(randomPositions(i*testSetSize+1:setSize),:); 
           trainLabels = labels(randomPositions(i*testSetSize+1:setSize));
        else
            trainData = features(randomPositions(i*testSetSize+1:setSize),:);
            trainLabels = labels(randomPositions(i*testSetSize+1:setSize));
            trainData = [trainData;features(randomPositions(1:i*testSetSize-testSetSize),:)];
            trainLabels = [trainLabels;labels(randomPositions(1:i*testSetSize-testSetSize))];
        end
    end
    
%     mean_trainData = mean(trainData);
%     std_trainData = std(trainData);
% 
%     trainData = (trainData - repmat(mean_trainData,trainSetSize,1)) ./ repmat(std_trainData,trainSetSize,1);
%     testData = (testData - repmat(mean_trainData,testSetSize,1)) ./ repmat(std_trainData,testSetSize,1);
%     
    %Run the classifier
%     estimatedClasses = myKnn(testData, trainData, trainLabels, K);
    %-------------------
    model = svmtrain(trainLabels,trainData);

    [predicted_label, acc, dec_values] = svmpredict(testLabels,testData,model);
    
    accuracy = accuracy + acc;
    %-------------------
    
    %confusion Matrix
%     confusionMatrices(:,:,i) = confusionmat(testLabels,estimatedClasses);
    
    %count positives
%     for j=1:length(testLabels)
%         if (estimatedClasses(j) == testLabels(j))
%             positives = positives + 1;
%         end
%     end
    
    %do the confusion Matrix and visualize data
end
%     accuracy = (positives*100)/(n*testSetSize); %return accuracy in percentage
%     confusionMatrix = mean(confusionMatrices,3);
    accuracy = accuracy/n;
end