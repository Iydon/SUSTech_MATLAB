function [sortedArray] = sort_shell_show(unsortedArray,pauseTime)
    % ϣ������, ��������
    % argin:    unsortedArray(�����������), pauseTime(��ʾ��ͣʱ��)
    % argout:   sortedArray(�����������)
    if nargin==1
        pauseTime = 0.01;
    end
    len = length(unsortedArray);
    gap = 2;
    scatter(1:len,unsortedArray);
    
    while gap>0
        for i=gap:len-1
            for j=i:-gap:gap
                if unsortedArray(j-gap+1)>unsortedArray(j+1)
                    tmp=unsortedArray(j-gap+1);unsortedArray(j-gap+1)=unsortedArray(j+1);unsortedArray(j+1)=tmp;
                    % ��unsortedArray([j-gap+1,j+1])=unsortedArray([j+1,j-gap+1]);
                    pause(pauseTime);               % ��ͣ����������Ч��
                    scatter(1:len,unsortedArray);   % ����ɢ��ͼ
                end
            end
        end
        gap = floor(gap/2);
    end
    
    sortedArray = unsortedArray;
end