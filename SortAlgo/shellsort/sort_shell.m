function [sortedArray,timerVal] = sort_shell(unsortedArray)
    % ϣ������, ��������
    % argin:    unsortedArray(�����������)
    % argout:   sortedArray(�����������), timerVal(ʱ������)
    len = length(unsortedArray);
    gap = floor(len/2);
    
    tic;
    while gap>0
        for i=gap:len-1
            for j=i:-gap:gap
                if unsortedArray(j-gap+1)>unsortedArray(j+1)
                    tmp=unsortedArray(j-gap+1);unsortedArray(j-gap+1)=unsortedArray(j+1);unsortedArray(j+1)=tmp;
                    % ��unsortedArray([j-gap+1,j+1])=unsortedArray([j+1,j-gap+1]);
                    % ����ʹ�ò����������Ч��
                end
            end
        end
        gap = floor(gap/2);
    end
    timerVal = toc;
    
    sortedArray = unsortedArray;
end