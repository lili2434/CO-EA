function ind = randompoint(prob, n)
%RANDOMNEW to generate n new point randomly from the mop problem given.

if (nargin==1)%nargin��������ɵ���һ������
    n=1;
end

randarray = rand(prob.pd, n);%n��popsize��Ⱥ��С��30*101��-----Ĭ��0-1��
lowend = prob.domain(:,1);%������Ӧ��û�а�����һ����0-----���domain�Ƕ�����Ҳ����x��ȡ0-1֮�������
span = prob.domain(:,2)-lowend;%һ����1��һ����0=1
point = randarray.*(span(:,ones(1, n)))+ lowend(:,ones(1,n));%��ʼ�㣿��
cellpoints = num2cell(point, 1);%��point�����һ��

indiv = struct('parameter',[],'objective',[], 'estimation', []);%���壿
ind = repmat(indiv, 1, n);%����101��
[ind.parameter] = cellpoints{:};%ind��parameter��������30*1����

% estimation = struct('obj', NaN ,'std', NaN);
% [ind.estimation] = deal(repmat(estimation, prob.od, 1));
end
