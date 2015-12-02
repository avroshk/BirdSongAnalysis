%testScript
clear;
% [classes, metaFiles, count, missingIndexes] = getBirdCLEFMetaData();
[features, classes] = getBirdCLEFMetaData();

%  csvwrite('mfcc_dataset.csv',[features transformed_classes]);