function [sortedArray,timerVal] = sort_bubble(unsortedArray)
    % ð������, ��������
    % argin:    unsortedArray(�����������)
    % argout:   sortedArray(�����������), timerVal(ʱ������)
    len = length(unsortedArray);
    
    tic;
    for i=len-1:-1:1
        for j=1:i
            if unsortedArray(j)>unsortedArray(j+1)
                tmp=unsortedArray(j);unsortedArray(j)=unsortedArray(j+1);unsortedArray(j+1)=tmp;
                % ��unsortedArray([j,j+1]) = unsortedArray([j+1,j]);
            end
        end
    end
    timerVal = toc;
    sortedArray = unsortedArray;
end