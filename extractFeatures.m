function [features] = extractFeatures(x,window,blockLength,hopLength,fs)
    numFeatures = 26;
    
    features = zeros(1,numFeatures);

%     spectral_flux = ComputeFeature('SpectralFlux',x,fs,window,blockLength,hopLength);   
%     spectral_centroid = ComputeFeature('SpectralCentroid',x,fs,window,blockLength,hopLength);
%     spectral_rolloff = ComputeFeature('SpectralRolloff',x,fs,window,blockLength,hopLength);
%     spectral_flatness = ComputeFeature('SpectralFlatness',x,fs,window,blockLength,hopLength);
%     zcr = ComputeFeature('TimeZeroCrossingRate',x,fs,window,blockLength,hopLength);
    mfcc = ComputeFeature('SpectralMfccs',x,fs,window,blockLength,hopLength);
%try crest
%     
%     features(1) = mean(spectral_flux);
%     features(2) = std(spectral_flux);
% %     
%     features(3) = mean(spectral_centroid);
%     features(4) = std(spectral_centroid);
%     
%     features(5) = mean(spectral_rolloff);
%     features(6) = std(spectral_rolloff);
%     
%     features(7) = mean(spectral_flatness);
%     features(8) = std(spectral_flatness);
%     
%     features(9) = mean(zcr);
%     features(10) = std(zcr);
%     
    features(1:13) = mean(mfcc,2);
    features(14:26) = std(mfcc,0,2);
end