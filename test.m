% make;
clear;
load('features.mat');
load('genres.mat');

labels = genres;

classes = unique(genres);
 
model = svmtrain(labels,features,'-c 1 -g 0.2 -b 1');

testLabelVector = rand(length(features(1)), 1);
[predicted_label, accuracy, prob_estimates] = svmpredict(1,features(1),model);



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