function [array,timerVal] = sort_heap(array)
	% ������, ��������
    % argin:    unsortedarrayrray(�����������)
    % argout:   sortedarrayrray(�����������), timerVal(ʱ������)
	array = build_max_heap(array);
	len = length(array);

	tic;
	for i=len:-1:2
	    array([1,i]) = array([i,1]);
	    len = len-1;
	    array = max_heapify(array,len,1);
	end
	timerVal = toc;
end

function [array] = build_max_heap(array)
	len = length(array);
    for i=floor(len/2):-1:1
    	array = max_heapify(array,len,i);
    end
end

function [array] = max_heapify(array,len,i)
	left = 2*i;
	right = 2*i+1;
	largest = i;
	if left<=len
		if array(left)>array(i)
			largest = left;
		end

		if right<=len && array(right)>array(largest)
			largest = right;
		end

		if largest~=i
		    tmp=array(i);array(i)=array(largest);array(largest)=tmp;
            % ��array([i,largest]) = array([largest,i]);
		    array = max_heapify(array,len,largest);
		end
	end
end