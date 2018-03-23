function ind=genetic_op(subproblems, index, domain, params)
%GENETICOP function implemented the DE operation to generate a new
%individual from a subproblems and its neighbours.------�����µ����������������

%   subproblems: is all the subproblems.------����������
%   index: the index of the subproblem need to
%   handle.-----Ҫ����������������------��1-101
%   domain: the domain of the origional multiobjective problem.-----ԭʼ��Ŀ���������
%   ind: is an individual structure.-------һ������ṹ��

    neighbourindex = subproblems(index).neighbour;%���������----��һ�����ŵ�������
    
    %The random draw from the neighbours.
    nsize = length(neighbourindex);%�����Ӧ�ö���20��
    si = ones(1,3)*index;%���Ǹ�ɶ
    
    si(1)=neighbourindex(ceil(rand*nsize));%ceil(rand*nsize)�ǲ���һ��1-20���������������ȡ�����һ����
    while si(1)==index%һ��Ҫ���ǲ����
        si(1)=neighbourindex(ceil(rand*nsize));
    end
    
    si(2)=neighbourindex(ceil(rand*nsize));
    while si(2)==index || si(2)==si(1)
        si(2)=neighbourindex(ceil(rand*nsize));
    end
    
    si(3)=neighbourindex(ceil(rand*nsize));
    while si(3)==index || si(3)==si(2) || si(3)==si(1)
        si(3)=neighbourindex(ceil(rand*nsize));
    end
    %Ҳ�������si�е�������������indexҲ�������
     
    %retrieve the individuals.-----��������
    points = [subproblems(si).curpoint];%Ӧ����һ��1*3�ģ�ÿ��curpoint����һ����INDS���Ե�-----��Щ������ѡ������
    selectpoints = [points.parameter];
    
    oldpoint = subproblems(index).curpoint.parameter;%ԭʼ��
    parDim = size(domain, 1);%������Ե���30
    
    jrandom = ceil(rand*parDim);%����1-30��һ�������
    
    randomarray = rand(parDim, 1);%���Ĭ�����ɵ���0-1֮����������ŶŶ����Ҫ�����������н������
    deselect = randomarray<params.CR;
    deselect(jrandom)=true;
    newpoint = selectpoints(:,1)+params.F*(selectpoints(:,2)-selectpoints(:,3));
    newpoint(~deselect)=oldpoint(~deselect);
    
    %repair the new value.
    newpoint=max(newpoint, domain(:,1));
    newpoint=min(newpoint, domain(:,2));
    
    ind = struct('parameter',newpoint,'objective',[], 'estimation',[]);
    %ind.parameter = newpoint;
    %ind = realmutate(ind, domain, 1/parDim);
    ind = gaussian_mutate(ind, 1/parDim, domain);
    
    %clear points selectpoints oldpoint randomarray deselect newpoint neighbourindex si;
end