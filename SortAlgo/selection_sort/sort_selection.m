function [sortedArray,timerVal] = sort_selection(unsortedArray)
    % ѡ������, ��������
    % argin:    unsortedArray(�����������)
    % argout:   sortedArray(�����������), timerVal(ʱ������)
    len = length(unsortedArray);
    
    tic;
    for i=1:len
        idx = getMin(unsortedArray(i:len));
        % ��[~,idx]=min(unsortedArray(i:len));
        tmp=unsortedArray(i);unsortedArray(i)=unsortedArray(idx+i-1);unsortedArray(idx+i-1)=tmp;
        % ��unsortedArray([i,idx+i-1]) = unsortedArray([idx+i-1,i]);
    end
    timerVal = toc;
    sortedArray = unsortedArray;
end

function idx = getMin(array)
    for idx=1:length(array)
        if array(idx)<=array
            return;
        end
    end
end