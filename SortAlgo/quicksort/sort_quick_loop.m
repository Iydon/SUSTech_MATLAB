function [sortedArray] = sort_quick_loop(unsortedArray)
    % ��������, ��������
    % argin:    unsortedArray(�����������)
    % argout:   sortedArray(�����������)
    
    sortedArray = quickSort(unsortedArray,1,length(unsortedArray));
end

function [array] = quickSort(array,low,high)
    if low<high
        [array,idx]=partition(array,low,high);
        % ȡ�������½��п������򣬷���
        array=quickSort(array,low,idx-1);
        array=quickSort(array,idx+1,high);
    end
end

function [array,idx] = partition(array,low,high)
    x=array(high);
    i=low-1;
    for j=low:high-1
        if array(j)<=x
            i=i+1;
            tmp=array(j);array(j)=array(i);array(i)=tmp;
            % ��array([i,j])=array([j,i]);
        end
    end
     tmp=array(i+1);array(i+1)=array(high);array(high)=tmp;
     % ��array([high,i+1])=array([i+1,high]);
     idx=i+1;
end
