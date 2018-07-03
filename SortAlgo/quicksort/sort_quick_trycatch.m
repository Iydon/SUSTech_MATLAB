function [sortedArray] = sort_quick_trycatch(unsortedArray)
    % ��������, ��������
    % argin:    unsortedArray(�����������)
    % argout:   sortedArray(�����������)
    
    try
        sortedArray = [sort_quick_trycatch(unsortedArray(unsortedArray<unsortedArray(1))),...
                       unsortedArray(1),...
                       sort_quick_trycatch(unsortedArray(unsortedArray>unsortedArray(1)))];
    catch
        sortedArray = unsortedArray;
    end
    
end