function [distancefee,timespan,remuneration] = rsm( chrosm,cus,Qt,j )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %ÿ��Ⱦɫ���ÿ��·�߶�Ҫ�����
    % distancefee = {zeros(25,10)};
    % distancefee = repmat(distancefee,1,100);
    distancefee = zeros(1,10);
    %����ʱ��
%     timespan = zeros(1,100);
%     remuneration = zeros(1,100);
    %˾������

    %Qt = zeros(1,100);%��¼����ʱ��
    Qd = zeros(1,100);%��¼����ʱ��

    %ÿ��Ⱦɫ���ÿ��·�߶�Ҫ�����
    % distancefee = {zeros(25,10)};
    % distancefee = repmat(distancefee,1,100);
%     distancefee = zeros(100,10);
    %����ʱ��
    timespan = 0;
    %remuneration = 0;
    %˾������

    
    
    %RSM����Ŀ��ֵ����
    N = 10;
    %for j = 1 : 100

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
                        if count2 == 1
                            distancefee(1,k) = distancefee(1,k) + distancexy(cus,indi1,0);%���㵽�ֿ�ľ��� 
                        else                    
                            indi2 = chrosm{1,j}(count1,count2-1);
                            distancefee(1,k) = distancefee(1,k) + distancexy(cus,indi1,indi2);%���㵽�ֿ�ľ���
                            %disp(distancefee{1,1}(1,k));
                        end
                        capacitycount = capacitycount + cus.randemand(indi1);
                        if capacitycount > 200

                            Qd(1,k) = Qd(1,k) + distancexy(cus,indi1,0)*2;
                        end
                        count2 = count2 + 1;
                        count  = count + 1;
                    end
                    indi1 = chrosm{1,j}(count1,count2-1);
                    distancefee(1,k) = distancefee(1,k) + distancexy(cus,indi1,0);
                    count1 = count1 + 1; 
                    count2 = 1;
                    capacitycount = 0;%��¼�ж�����Լ��
                end            
            end
            timespan = timespan + distancefee(1,k) + Qt(1,j)+90*25;
            if timespan <= 6000%25���˵��ĸ�Сʱ
                remuneration = 10*timespan;            
            else
                remuneration = 80+20*(timespan-6000);   
            end
   % end
end

