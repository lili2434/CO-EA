function subp=init_weights(popsize, niche, objDim)
% init_weights function initialize a pupulation of subproblems structure
% with the generated decomposition weight and the neighbourhood
% relationship.
    subp=[];
    for i=0:popsize
        if objDim==2
            p=struct('weight',[],'neighbour',[],'optimal', Inf, 'optpoint',[], 'curpoint', []);
            weight=zeros(2,1);
            weight(1)=i/popsize;
            weight(2)=(popsize-i)/popsize;
            p.weight=weight;
            subp=[subp p];
        elseif objDim==3
        %TODO
        end
    end

% weight = lhsdesign(popsize, objDim, 'criterion','maximin', 'iterations', 1000)';
% p=struct('weight',[],'neighbour',[],'optimal', Inf, 'optpoint',[], 'curpoint', []);
% subp = repmat(p, popsize, 1);
% cells = num2cell(weight);
% [subp.weight]=cells{:};

    %Set up the neighbourhood.
    leng=length(subp);%101
    distanceMatrix=zeros(leng, leng);%�������101*101��ȫ0
    for i=1:leng
        for j=i+1:leng
            A=subp(i).weight;B=subp(j).weight;
            distanceMatrix(i,j)=(A-B)'*(A-B);
            distanceMatrix(j,i)=distanceMatrix(i,j);
        end
        [s,sindex]=sort(distanceMatrix(i,:));%s�Ǵ�С��������Ľ����sindex�Ƿ��ص������distanceMatrix����Ԫ����ԭ�������е�λ��
        subp(i).neighbour=sindex(1:niche)';%ȡǰ20��
    end
   
end