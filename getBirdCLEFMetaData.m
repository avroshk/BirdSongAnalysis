%%Bird Song Analysis
%arguments : windowSize, hopSize
% return : features, metadata 

function [classes, metadata, missingFamily] = getBirdCLEFMetaData()
    
    numFiles = 20;
%     numMetaData = 21;
    
    features = zeros(numFiles, 1);
    fs = zeros(numFiles,1);
    metadata = struct('MetaData',0);
    
    audioFiles = cell(numFiles,1);
    metaFiles = cell(numFiles,1);
    
    path = 'LIFECLEF2014_BIRDAMAZON_XC_WAV_RN';
    wavExtension = '.wav';
    xmlExtension = '.xml';    
    
    
    for i=1:numFiles
        audioFiles{i,1} = strcat(path,num2str(i),wavExtension);
        metaFiles{i,1} = strcat(path,num2str(i),xmlExtension);
    end
    
    %collect indexes of missing files
    missingIndexes = [];
    missingFamily = [];
    
    %detect classes
    classes = cell(0);
    
    for j=1:numFiles
        try
            s= xml2struct(char(metaFiles(j,1)));
            metadata(j).MetaData  = s.Audio;
            [song,fs(j)] = audioread(char(audioFiles(j,1)));
            subplot(3,1,1);
            spectrogram(song,1024,512,1024,fs(j),'yaxis'); colormap bone;
            
            song_16 = resample(song,22050,fs(j));
            subplot(3,1,2);
            spectrogram(song_16,1024,512,1024,22050,'yaxis'); colormap bone;
            
            song_filt1 = removeMedian(song_16);
            subplot(3,1,3);
            spectrogram(song_filt1,1024,512,1024,22050,'yaxis'); colormap bone;
            
            if length(classes)==0
                classes = [classes; s.Audio.Content.Text]; 
            else
                currentSize = size(classes);
                flag = 0;
                for k=1:currentSize(1)
                    if strcmp(s.Audio.Content.Text, classes(k,:))
                        flag = 1;
                    end
                end
                if flag == 0
                    classes = [classes; s.Audio.Content.Text];
                end 
            end
 
        catch ME
            missingIndexes = [missingIndexes;j];
        end
    end
end