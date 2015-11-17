%% Represent the signal in blocks for blockwise processing and apply hamming window
% blockedSignal = blockHamIt(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process
%   hopSize = int, hop size of the blockwise process
% Output:
%   blockedSignal = windowSize*numBlocks float vector, blocked signal
% 23rd Sept 2015
% -Avrosh 

function result = unBlockIt(x, windowSize, hopSize)

    % Edge case
    if hopSize > windowSize
        disp('Hop size must be smaller than the window size');
        return;
    end
    
    %Create hamming window
%     hamWindow = hamming(windowSize);
    
    sizeX = size(x);
    numBlocks = sizeX(2);
    lenBlock = sizeX(1);

    result = zeros(numBlocks*hopSize,1);
    
    for i = 1:numBlocks
        iStart = (i-1) .* hopSize + 1;
        iEnd   = iStart + windowSize-1;
        result(iStart:iEnd) = x(:,i);
    
%         blockedSignal(:, i) = x(iStart:iEnd);
%         blockedSignal(:,i) = blockedSignal(:,i).*hamWindow;
    end
end
