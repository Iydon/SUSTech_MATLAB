function [sortedArray,timerVal] = sort_bucket(unsortedArray,pauseTime)
    % Ͱ����, ��������
    % argin:    unsortedArray(�����������), pauseTime(��ʾ��ͣʱ��)
    % argout:   sortedArray(�����������), timerVal(ʱ������)
    if nargin==1
        pauseTime = 0.01;
    end
    len = length(unsortedArray);
end