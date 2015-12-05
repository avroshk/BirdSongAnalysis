function [ longestStart, longestEnd ] = findPhrase( x )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    l = size(x, 1);

    temp = ones(l);

    temp = rot90(triu(rot90(temp)),3);

    x = temp .* x;

    longest = 0;
    longestStart = 0;
    longestEnd = 0;
    
    length = 0;

	for i = l:-1:1;      % rows
        for j = 2:l    %cols
            if (j == 2)
                length = 0;
                start = 0;
            end
            if (x(i,j-1) == 0 && x(i,j) == 1)  %start
                if (j <= 3)
                    start = j;
                    length = 1;
                elseif (x(i,j-2) == 1 || x(i,j-3) == 1)
                    length = length + 1;
                else
                    start = j;
                    length = 1;
                end
            elseif (x(i,j-1) == 1 && x(i,j) == 1)  %increment
                length = length+1;
                if (j== l)
                    if (length > longest)
                        longest = length;
                        longestStart = start;
                        longestEnd = j;
                    end
                end
            elseif (x(i,j-1) == 0 && x(i,j) == 0)  %end
                if (j < l-1 && j > 2)
                    if (x(i,j-2) == 1)
                        length = length+1;
                    end
                end
            elseif (x(i,j-1) == 1 && x(i,j) == 0)  %end
                if (j >= l-2)
                    if (length > longest)
                        longest = length;
                        longestStart = start;
                        longestEnd = j-1;
                    end
                elseif (x(i,j+1) == 0 && x(i,j+2) == 1)
                    length = length+1;
                elseif (length > longest)
                    longest = length;
                    longestStart = start;
                    longestEnd = j-1;
                end
            end
        end
    end

end

