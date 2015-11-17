%% Represent the signal in blocks for blockwise processing
% blockedSignal = BlockIt(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process
%   hopSize = int, hop size of the blockwise process
% Output:
%   blockedSignal = windowSize*numBlocks float vector, blocked signal
% 23rd Sept 2015
% -Avrosh 

function blockedSignal = BlockIt(x, windowSize, hopSize)

    % Edge case
    if hopSize > windowSize
        disp('Hop size must be smaller than the window size');
        return;
    end
    
    L=length(x);
    numBlocks = ceil(L/hopSize);
    blockedSignal = zeros(windowSize, numBlocks);

    for i = 1:numBlocks
        iStart = (i - 1) .* hopSize + 1;
        iEnd   = min(iStart + windowSize - 1, L);
        blockedSignal(1:(iEnd-iStart+1), i) = x(iStart:iEnd);
    end
    
end
