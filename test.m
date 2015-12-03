% % make;
% % clear;
% % load('features.mat');
% % load('genres.mat');
% load('birdclef-MFCC.mat');
% n = 10;
% 
% featureSet = size(features);
% setSize = featureSet(1);
% testSetSize = round(setSize/n);
% trainSetSize = setSize - testSetSize;
% 
% trainData = features(testSetSize+1:end,:);
% testData = features(1:testSetSize,:);
% 
% features_mean = mean(trainData);
% features_std = std(trainData);
% 
% trainData = (trainData - repmat(features_mean,trainSetSize,1)) ./ repmat(features_std,trainSetSize,1);
% testData = (testData - repmat(features_mean,testSetSize,1)) ./ repmat(features_std,testSetSize,1);
% trainLabels = labels(testSetSize+1:end);
testLabels = labels(1:testSetSize);
% 
% 
% % labels = transformed_classes;
% % lenData = size(features);
% % lenData = lenData(1);
% % startIndex = 1001;
% 
% % labels = genres;
% 
% % classes = unique(genres);
%  
% model = svmtrain(trainLabels,trainData);

[predicted_label, accuracy, dec_values] = svmpredict(testLabels,testData,model);



% for i = 1:length(classes)
%     class = classes(i,1);
%     labels = zeros(size(genres));
%     
%     labels(genres ~= classes(i)) = 'b';
%     labels(genres == classes(i)) = 'a';
%     %training
%     models = [models, svmtrain(features, labels)];
% %     testLabel = ['a'];
%     %prediction
% %     testMatrix = features(labels == 'a');
%     testLabelVector = rand(length(features(300)), 1);
% %     [predicted_label, accuracy, prob_estimates] = svmpredict(testLabelVector, testMatrix, models(i));
%     [predicted_label, accuracy, prob_estimates] = svmpredict(testLabelVector,features(300),models(i));
% end