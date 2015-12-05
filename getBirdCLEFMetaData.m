%%Bird Song Analysis
%arguments : windowSize, hopSize
% return : features, metadata 

function [features, classes, clipBoundaries] = getBirdCLEFMetaData
    
    numFiles = 14027;
    startIndex = 1;
%     numMetaData = 21
    numFeatures = 26;
    clipBoundaries = zeros(numFiles,2);
    
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
            
%             if (strcmp(metadata(j).MetaData.Quality.Text,'1'))
%                 if (isempty(metadata(j).MetaData.BackgroundSpecies.Text))
%                     if ~(isempty(strfind(metadata(j).MetaData.Content.Text,'song')))
            
                        count = count + 1;
%                         disp(j); disp(metadata(j).MetaData.Quality.Text);
%                         disp(metadata(j).MetaData.BackgroundSpecies.Text);
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
%                         song_22k = removeMedian(song_22k);
%                         ws = 2*fs(j);
%                         hs = (1/4)*ws;
%                         if(length(song_22k))
                        ws = 1024;
                        hs = 512;
                        
%                         [S,a,T] = spectrogram(song_22k,hannWindow,ws-hs,ws,fs_22k,'yaxis'); 
%                         subplot(2, 1, 1); spectrogram(song_22k,hannWindow,ws-hs,ws,fs_22k,'yaxis'); colormap bone; colorbar off; 
                        
                        features_mfcc = ComputeFeature('SpectralMfccs',song_22k,fs_22k,hannWindow,ws,hs);
                        D_mfcc = computeSelfDistMat(features_mfcc);
%                         kernel_size = 6;
%                         MFCC = computeSdmNovelty(D_mfcc,kernel_size);
                        R = computeLagDistMatrix(D_mfcc);

%                         SDM_mfcc_bin = computeBinSdm(R,mean(mean(R)));
                        mean1 = mean(mean(R(R>0)));
%                         std1 = mean(std(R));
                        mean2 = mean(mean(R));
                        mean3 = abs(mean2-mean1);
                        if(mean1>mean2) 
                            final_mean=mean1-mean3/2;
                        else
                            final_mean=mean2-mean3/2;
                        end
                        SDM_mfcc_bin = computeBinSdm(R,final_mean);

% imagesc(SDM_mfcc_bin);
                        E = erodeDilate(SDM_mfcc_bin,30);
                        
                        [l1,l2] = findPhrase(E);
                        
                        if l1==0
                            l1 = 1;
                        end
                        
                     
                        
                        
%                         subplot(2, 1, 2);imagesc(E); hold on; 
                        
%                         rectangle('Position',[l1 0 l2-l1 length(E)],'EdgeColor','r'); hold off;
                        [S,c,T]= spectrogram(song_22k,hannWindow,ws-hs,ws,fs_22k,'yaxis');
%                         subplot(2, 1, 1); spectrogram(song_22k,hannWindow,ws-hs,ws,fs_22k,'yaxis'); colormap bone; colorbar off; 
%                         hold on;
%                         if (max(T) > 60)
%                             rectangle('Position',[T(l1)/60 0 (T(l2)-T(l1))/60 11],'EdgeColor','r');
%                         else
%                             rectangle('Position',[T(l1) 0 T(l2)-T(l1) 11],'EdgeColor','r');
%                         end
                        
%                         hold off;
                        clipStart = min(T);
                        clipEnd = max(T);
                        lengthOfClip = T(l2) - T(l1);
                        if(lengthOfClip > 30 )
                            lengthOfClip = 30;
                        end
                        
                        if(max(T) > 5.5)
                            if(T(l1)-2 > 0)
                                clipStart = T(l1)-2;
                            end
                            if(T(l2)+2 < max(T))
                                clipEnd = clipStart + lengthOfClip + 4;
                            else
                                clipEnd = max(T);
                            end
                        end
                        
                        clipBoundaries(j,:) = [clipStart clipEnd];
                        
                        
%                         hold on; 
%                         if (max(T) > 60)
%                             rectangle('Position',[clipStart/60 0 (clipEnd-clipStart)/60 11],'EdgeColor','g');
%                         else
%                             rectangle('Position',[clipStart 0 clipEnd-clipStart 11],'EdgeColor','g');
%                         end
%                         
%                         hold off;
                        
                        features(count,:) = extractFeatures(song_22k(round(clipStart*fs_22k):round(clipEnd*fs_22k)),hannWindow,blockLength,hopLength,fs_22k);
                        classes(count,1) = cellstr(s.Audio.Species.Text);

%                         
%                         subplot(6,1,5);
%                         spectro_song = spectrogram(song_filt1,hannWindow,blockLength-hopLength,blockLength,fs_22k,'yaxis'); colormap bone; colorbar off;
                        
%                         spectro_song_bin = computeBinSdm(spectro_song,0.5);
%                         subplot(6,1,6);
%                         imagesc(spectro_song_bin);
%                         player1 = audioplayer(song_noisy,fs(j));
%                         pl ayer2 = audioplayer(song,fs(j));
                        
%                          features(count,:) = extractFeatures(song_22k,hannWindow,blockLength,hopLength,fs(j));
%                          classes(count,1) = cellstr(s.Audio.Species.Text);
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