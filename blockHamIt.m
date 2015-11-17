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

function blockedSignal = blockHamIt(x, windowSize, hopSize)

    % Edge case
    if hopSize > windowSize
        disp('Hop size must be smaller than the window size');
        return;
    end
    
    %Create hamming window
    hamWindow = hamming(windowSize);
    
    L=length(x);
    numBlocks = ceil(L/hopSize)-1;
    blockedSignal = zeros(windowSize, numBlocks);

    for i = 1:numBlocks
        iStart = (i - 1) .* hopSize + 1;
        iEnd   = min(iStart + windowSize - 1, L);
        blockedSignal(1:(iEnd-iStart+1), i) = x(iStart:iEnd);
        blockedSignal(:,i) = blockedSignal(:,i).*hamWindow;
%         blockedSignal(:, i) = x(iStart:iEnd);
%         blockedSignal(:,i) = blockedSignal(:,i).*hamWindow;
    end
end
