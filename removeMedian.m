function [result] = removeMedian(x)

blockedX = blockHamIt(x,1024,512);
fft_blockedX = (fft(blockedX));
fft_r = abs(fft_blockedX);

fft_median = median(fft_r);

result = ifft(fft_blockedX-repmat(fft_median,1024,1));

result = unBlockIt(result,1024,512);

end