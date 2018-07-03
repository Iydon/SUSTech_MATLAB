function [sortedArray,timerVal] = sort_insertion(unsortedArray)
    % ��������, ��������
    % argin:    unsortedArray(�����������)
    % argout:   sortedArray(�����������), timerVal(ʱ������)
    len = length(unsortedArray);
    sortedArray = unsortedArray(1);
    
    tic;
    for i=2:len
        entry = unsortedArray(i);
        sortedArray = [sortedArray(sortedArray<entry),entry,sortedArray(sortedArray>=entry)];
        % ʵ��Ӧ���ö��ַ�������ֵ
    end
    timerVal = toc;
end