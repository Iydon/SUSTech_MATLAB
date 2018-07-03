function [sortedArray] = sort_quick_recursion(unsortedArray)
    % ��������, ��������
    % argin:    unsortedArray(�����������)
    % argout:   sortedArray(�����������)
    
    if length(unsortedArray)<2
        sortedArray = unsortedArray;
        return
    end
    
    sortedArray = [sort_quick_recursion(unsortedArray(unsortedArray<unsortedArray(1))),...
                   unsortedArray(unsortedArray==unsortedArray(1)),...
                   sort_quick_recursion(unsortedArray(unsortedArray>unsortedArray(1)))];
    
end