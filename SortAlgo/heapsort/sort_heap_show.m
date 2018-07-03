function [array] = sort_heap_show(array,pauseTime)
	% ������, ��������
    % argin:    unsortedarrayrray(�����������), pauseTime(��ʾ��ͣʱ��)
    % argout:   sortedarrayrray(�����������)
    if nargin==1
        pauseTime = 0.01;
    end
    len = length(array);
    scatter(1:len,array);
	array = build_max_heap(array,len,pauseTime);

    for i=len:-1:2
	    array([1,i]) = array([i,1]);
	    len = len-1;
	    array = max_heapify(array,len,1,pauseTime);
    end
end

function [array] = build_max_heap(array,len,pauseTime)
    for i=floor(len/2):-1:1
    	array = max_heapify(array,len,i,pauseTime);
        pause(pauseTime);       % ��ͣ����������Ч��
        scatter(1:len,array);   % ����ɢ��ͼ
    end
end

function [array] = max_heapify(array,len,i,pauseTime)
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
		    array([i,largest]) = array([largest,i]);
            pause(pauseTime);       % ��ͣ����������Ч��
            scatter(1:length(array),array);   % ����ɢ��ͼ
		    array = max_heapify(array,len,largest,pauseTime);
		end
	end
end