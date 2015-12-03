%%Bird Song Analysis
%arguments : windowSize, hopSize
% return : features, metadata 

function [features, classes] = getBirdCLEFMetaData
    
    numFiles = 750;
    startIndex = 1;
%     numMetaData = 21
    numFeatures = 26;
    
   features = zeros(numFiles, numFeatures);
%     features = zeros(1, numFeatures);
%     features = [];
    fs = zeros(numFiles,1);
    metadata = struct('MetaData',0);
    
     %detect classes
    classes = cell(numFiles,1);
    
    audioFiles = cell(numFiles,1);
    metaFiles = cell(numFiles,1);
    
    path = 'LIFECLEF2014_BIRDAMAZON_XC_WAV_RN';
    wavExtension = '.wav';
    xmlExtension = '.xml';    
    
    
    for i=startIndex:numFiles
        audioFiles{i,1} = strcat(path,num2str(i),wavExtension);
        metaFiles{i,1} = strcat(path,num2str(i),xmlExtension);
    end
    
    %collect indexes of missing files
    missingIndexes = [];
    missingFamily = [];
    
    count = 0;
    
   
    fs_22k = 22050;
    blockLength = 1024;
    hopLength = 512;
    hannWindow = hann(blockLength,'periodic');
    
    for j=startIndex:numFiles
        try
            s= xml2struct(char(metaFiles(j,1)));
            metadata(j).MetaData  = s.Audio;
            
%             if (strcmp(metadata(j).MetaData.Quality.Text,'4'))
%                 if (isempty(metadata(j).MetaData.BackgroundSpecies.Text))
%                     if ~(isempty(strfind(metadata(j).MetaData.Content.Text,'song')))

                        count = count + 1;
                        [song_noisy,fs(j)] = audioread(char(audioFiles(j,1)));
%                         song  = song_noisy;
%                         subplot(6,1,1);
%                         plot(song_noisy);
                        
                        

                        song = denoise(song_noisy,fs(j));
                        
                    

%                         [rms,t] = ComputeFeature('SpectralMfccs',song,fs(j),[],blockLength,hopLength);
%                         spectral_centroid = ComputeFeature('SpectralCentroid',song,fs(j),hannWindow,blockLength,hopLength);
%                         spectral_flatness = ComputeFeature('SpectralFlatness',song,fs(j),hannWindow,blockLength,hopLength);
%                       rms_blocked = blockIt(rms,20,10);
%                       rms_flux = FeatureSpectralFlux(rms_blocked);
% 
%                         subplot(6,1,2);
%                         plot(song);

%                         subplot(6,1,3);
%                         plot(rms);
% 
%                         subplot(6,1,4);
%                         plot(spectral_centroid);

%                         subplot(6,1,4);
%                         spectrogram(song,hannWindow,blockLength-hopLength,blockLength,fs(j),'yaxis'); colormap bone; colorbar off;

                        song_22k = resample(song,fs_22k,fs(j));
%                         subplot(7,1,6);
%                         spectrogram(song_22k,hannWindow,blockLength-hopLength,blockLength,fs_22k,'yaxis'); colormap bone; colorbar off; 

%                         song_filt1 = removeMedian(song_22k);
%                         subplot(6,1,5);
%                         spectro_song = spectrogram(song_filt1,hannWindow,blockLength-hopLength,blockLength,fs_22k,'yaxis'); colormap bone; colorbar off;
                        
%                         spectro_song_bin = computeBinSdm(spectro_song,0.5);
%                         subplot(6,1,6);
%                         imagesc(spectro_song_bin);
%                         player1 = audioplayer(song_noisy,fs(j));
%                         pl ayer2 = audioplayer(song,fs(j));
                        
                         features(count,:) = extractFeatures(song_22k,hannWindow,blockLength,hopLength,fs(j));
                         classes(count,1) = cellstr(s.Audio.Species.Text);
%                            pitchchroma = ComputeFeature('SpectralPitchChroma',song_filt1,fs_22k,hannWindow,blockLength,hopLength);

            %             imagesc(pitchchroma);

%                         if length(classes)==0
%                             classes = [classes; s.Audio.Content.Text]; 
%                         else
%                             currentSize = size(classes);
%                             flag = 0;
%                             for k=1:currentSize(1)
%                                 if strcmp(s.Audio.Content.Text, classes(k,:))
%                                     flag = 1;
%                                 end
%                             end
%                             if flag == 0
%                                 classes = [classes; s.Audio.Content.Text];
%                             end 
%                         end 
%  
                    
%                     end
%                 end
%             end
                

 
        catch ME
            missingIndexes = [missingIndexes;j];
        end
    end
end