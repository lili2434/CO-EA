function child = crossover( child,carnum,parent)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    numm = zeros(1,25);%��ʱ��Ÿ��忴����û���ظ���------��ĸ1����--------------------------------
    j =1;
    count1 = 1;
    count2 = 1;
    count = 1;
    while count1<=(carnum(1,parent)+1)
        temp = child{1,parent}(count1,count2);
        if temp ~= 0
            if any(numm == temp)%�ж���û���ظ�ֵ���еĻ������Ԫ��ǰ��
                child{1,parent}(count1,count2:24) = child{1,parent}(count1,(count2+1):25);                    
            else
                numm(1,j) = temp;
                j = j + 1;
                count2 = count2 + 1;
            end                
            count = count + 1;
        else
            count1 = count1 + 1;
            count2 = 1;
        end
    end
    %ȥ��ȫ����
    for k = 1:20
        if child{1,parent}(k,1) == 0 && child{1,parent}(k+1,1) ~= 0
             child{1,parent}(k:23,:) = child{1,parent}(k+1:24,:); 
        end
    end
end

