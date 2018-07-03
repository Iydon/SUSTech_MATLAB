function [sortedArray] = sort_bogo_show(unsortedArray,pauseTime)
    % ���޺�������, ��������
    % argin:    unsortedArray(�����������), pauseTime(��ʾ��ͣʱ��)
    % argout:   sortedArray(�����������)
    if nargin==1
        pauseTime = 0.01;
    end
    len = length(unsortedArray);
    scatter(1:len,unsortedArray);

    while 1
        for i=1:len
            j = randi([1,len]);
            unsortedArray([i,j]) = unsortedArray([j,i]);
            pause(pauseTime);               % ��ͣ����������Ч��
            scatter(1:len,unsortedArray);   % ����ɢ��ͼ
        end
        if unsortedArray(1:len-1)<unsortedArray(2:len)
            break;
        end
    end
    sortedArray = unsortedArray;
end