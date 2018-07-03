function [sortedArray] = sort_bubble_show(unsortedArray,pauseTime)
    % ð������, ��������
    % argin:    unsortedArray(�����������), pauseTime(��ʾ��ͣʱ��)
    % argout:   sortedArray(�����������)
    if nargin==1
        pauseTime = 0.01;
    end
    len = length(unsortedArray);
    scatter(1:len,unsortedArray);
    
    for i=len-1:-1:1
        for j=1:i
            if unsortedArray(j)>unsortedArray(j+1)
                tmp=unsortedArray(j);unsortedArray(j)=unsortedArray(j+1);unsortedArray(j+1)=tmp;
                % ��unsortedArray([j,j+1]) = unsortedArray([j+1,j]);
            end
            pause(pauseTime);               % ��ͣ����������Ч��
            scatter(1:len,unsortedArray);   % ����ɢ��ͼ
        end
    end
    sortedArray = unsortedArray;
end