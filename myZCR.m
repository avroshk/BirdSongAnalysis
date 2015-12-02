%% Novelty function: zero crossing rate
% [nvt] = myZCR(fft_blockedX, windowSize, numBlocks)
% input: 
%   blockedX: N by M float vector, blocked input signal
%   windowSize: int, number of samples per block
%   numBlocks: int, number of blocks
% output: 
%   nvt: n by 1 float vector, the resulting novelty function 

function [nvt] = myZCR(blockedX, windowSize, numBlocks)

    blockedX_shifted = [blockedX(2:windowSize,:);blockedX(windowSize,:)];
    
    nvt = sum(abs(sign(blockedX)-sign(blockedX_shifted)))./(2*windowSize); 
end