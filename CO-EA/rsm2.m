function [ distancefee,timespan,remuneration,count1 ] = rsm2( chrosm,cus,j  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


    distancefee = zeros(1,10);
 

    Qt = zeros(1,100);%��¼����ʱ��
    Qd = zeros(1,100);%��¼����ʱ��

    timespan = 0;
    

    pe = 0.2;%�絽
    pee = 0.3;%��
    
    %RSM����Ŀ��ֵ����
    N = 10;           

        nowtime = 0;%��¼Ŀǰ��ʱ��----------------------------Ҫ��+.+         

        for k = 1 : N
            cus.randemand = zeros(25);
            cus.sigma = zeros(25);
            cus.sigma = (1/3*cus.u).*rand;
            cus.randemand = abs(floor(normrnd(cus.u,cus.sigma)));%�����1-N������
            count1 = 1;%��һ��·��
            count2 = 1;%��һ���ڵ�
            count = 0;
            capacitycount = 0;%��¼�ж�����Լ��

            %indi1 = chrosmosome{1,j}(count1,count2);
            while count~=25%�ж��Ƿ�25���ͻ���������------��һ��ѭ����һ��Ⱦɫ���·��-------
                while chrosm{1,j}(count1,count2)%����0�������-----��һ��ѭ��������һ��·�ߵ�------
                    indi1 = chrosm{1,j}(count1,count2);
                    if count2 == 1%��һ��·�ߵĵ�һ���ڵ�
                        distancefee(1,k) = distancefee(1,k) + distancexy(cus,indi1,0);%���㵽�ֿ�ľ��� 
                        nowtime = max(cus.earlyt(indi1),distancexy(cus,indi1,0));
                        if nowtime<cus.earlyt(indi1)
                            Qt(1,j) = Qt(1,j)+pe*(cus.earlyt(ind1) - nowtime);%��¼���ϵȴ�ʱ��
                       elseif nowtime>cus.latet(indi1)
                            Qt(1,j) = Qt(1,j)+pee*(nowtime - cus.latet(indi1) );%��¼���ϵȴ�ʱ��
                       end        
                    else                    
                        indi2 = chrosm{1,j}(count1,count2-1);
                        distancefee(1,k) = distancefee(1,k) + distancexy(cus,indi1,indi2);%���㵽ǰһ���ڵ�ľ���

                        nowtime = max(cus.earlyt(indi1),distancexy(cus,indi1,indi2)+10+nowtime);%�ں��߿�ʼ��ʱ�䡪������������������������������������������������������

                        if nowtime<cus.earlyt(indi1)
                            Qt(1,j) = Qt(1,j)+pe*(cus.earlyt(indi1) - nowtime);%��¼���ϵȴ�ʱ��
                       elseif nowtime>cus.latet(indi1)
                            Qt(1,j) = Qt(1,j)+pee*(nowtime - cus.latet(indi1) );%��¼���ϵȴ�ʱ��
                       end        
                        %disp(distancefee{1,1}(1,k));

                    end
                    capacitycount = capacitycount + cus.randemand(indi1);
                    if capacitycount > 200

                        Qd(1,k) = Qd(1,k) + distancexy(cus,indi1,0)*2;
                    end
                    
                    count2 = count2 + 1;
                    
                    count  = count + 1;
                end
%                 if count2 == 1
%                     indi1 = chrosm{1,j}(count1,count2);
%                 else
%                     disp(count2);
%                     disp(j)
                    indi1 = chrosm{1,j}(count1,count2-1);%����������������������������������������������������
                    
%                     disp(indi1);
%                 end
                
                distancefee(1,k) = distancefee(1,k) + distancexy(cus,indi1,0);
                count1 = count1 + 1; 
                count2 = 1;
                capacitycount = 0;%��¼�ж�����Լ��
                nowtime = 0;
            end

        end

        timespan = timespan + distancefee(1,k) + Qt(1,j)+10*25;%��������������������������������������������������������
        if timespan <= 6000%25���˵��ĸ�Сʱ
            remuneration = 10*timespan;            
        else
            remuneration = 80+20*(timespan-6000);   
        end
   
end

