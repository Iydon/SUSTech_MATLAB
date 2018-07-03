function [sortedArray] = sort_selection_show(unsortedArray,pauseTime)
    % ѡ������, ��������
    % argin:    unsortedArray(�����������), pauseTime(��ʾ��ͣʱ��)
    % argout:   sortedArray(�����������)
    if nargin==1
        pauseTime = 0.01;
    end
    len = length(unsortedArray);
    scatter(1:len,unsortedArray);
    xlim([1,len])
    ylim([min(unsortedArray),max(unsortedArray)]);
    
    for i=1:len
        [~,idx] = min(unsortedArray(i:len));
        unsortedArray([i,idx+i-1]) = unsortedArray([idx+i-1,i]);
        pause(pauseTime);               % ��ͣ����������Ч��
        scatter(1:len,unsortedArray);   % ����ɢ��ͼ
    end
    sortedArray = unsortedArray;
end