function [sortedArray] = sort_insertion_show(unsortedArray,pauseTime)
    % ��������, ��������
    % argin:    unsortedArray(�����������), pauseTime(��ʾ��ͣʱ��)
    % argout:   sortedArray(�����������)
    if nargin==1
        pauseTime = 0.01;
    end
    len = length(unsortedArray);
    sortedArray = unsortedArray(1);
    scatter(1:len,unsortedArray);
    
    for i=2:len
        entry = unsortedArray(i);
        sortedArray = [sortedArray(sortedArray<entry),entry,sortedArray(sortedArray>=entry)];
        pause(pauseTime);	% ��ͣ����������Ч��
        scatter(1:i,sortedArray);
        hold on;
        scatter(i+1:len,unsortedArray(i+1:len));	% ����ɢ��ͼ
        hold off;
    end
end