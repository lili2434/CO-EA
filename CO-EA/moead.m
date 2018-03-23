function pareto = moead( mop, varargin)
%   MOEAD runs moea/d algorithms for the given mop.
%   Detailed explanation goes here
%   The mop must to be minimizing.--------mop�Ƕ�Ŀ�꣬��С����
%   The parameters of the algorithms can be set through varargin.---���б���
%   ������
%   popsize: The subproblem's size.������Ĵ�С---------��Ⱥ��С
%   niche: the neighboursize, must less then the popsize.---------------�����С
%   iteration: the total iteration of the moead algorithms before
%   finish.--------------- һ���������ٴ�200��
%   method: the decomposition method, the value can be 'ws' or 'ts'.
%   �ֽ�ķ�����Ӧ��һ����Ȩ�طֲ���һ�����б�ѩ��


    starttime = clock;

    %global variable definition.------ȫ�ֱ�������������ǣ�
    global params idealpoint objDim parDim itrCounter;
    
    %set the random generator.�����������----���۶��ٴζ���һ���Ľ��
    rand('state',10);
    
    %Set the algorithms parameters.-----�����㷨�Ĳ���
    paramIn = varargin;
    [objDim, parDim, idealpoint, params, subproblems]=init(mop, paramIn);   %�ó�ʼ��������ʼ�����������od=2��pd=30
    
    itrCounter=1;
    while ~terminate(itrCounter)%�ж�ֹͣʱ��
        tic;
        subproblems = evolve(subproblems, mop, params);%����--�����mopӦ���Ѿ����1*101����
 %       disp(sprintf('iteration %u finished, time used: %u', itrCounter, toc));%tic�������浱ǰʱ�䣬����ʹ��toc����¼�������ʱ��
        itrCounter=itrCounter+1;
    end
    
    %display the result.
    pareto=[subproblems.curpoint];
    pp=[pareto.objective];
    scatter(pp(1,:), pp(2,:));
  %  disp(sprintf('total time used %u', etime(clock, starttime)));
end

function [objDim, parDim, idealp, params, subproblems]=init(mop, propertyArgIn)
%Set up the initial setting for the MOEA/D.------------------------------------------------��ʼ������������������
    objDim=mop.od;%2
    parDim=mop.pd;%30    
    idealp=ones(objDim,1)*inf;      %inf�������=.=
    
    %the default values for the parameters.---------������Ĭ��ֵ
    params.popsize=100;params.niche=30;params.iteration=100;
    params.dmethod='ts';
    params.F = 0.5; %F��CR����ʲô�������Ǳ���������?
    params.CR = 0.5;
    
    %handle the parameters, mainly about the
    %popsize-------�������������demo���¸�ֵ����Ҫ��עpopsize
    while length(propertyArgIn)>=2
        prop = propertyArgIn{1};
        val=propertyArgIn{2};
        propertyArgIn=propertyArgIn(3:end);

        switch prop
            case 'popsize'
                params.popsize=val;
            case 'niche'
                params.niche=val;
            case 'iteration'
                params.iteration=val;
            case 'method'
                params.dmethod=val;
            otherwise
                warning('moea doesnot support the given parameters name');
        end
    end
    %������Щ��������popsize=100��niche=20��objdim=2��iteration=200��dmethod=��te��
    
    subproblems = init_weights(params.popsize, params.niche, objDim);
    %��ʼ��Ȩ������������
    
    params.popsize = length(subproblems);%101
    
    %initial the subproblem's initital state.--------��ʼ��������ĳ�ʼ״̬
    inds = randompoint(mop, params.popsize);%�����Ҫ�Ǹ�ind��ֵ--------��1*101�Ľṹ�壬ÿ������30*1��
    [V, INDS] = arrayfun(@evaluate, repmat(mop, size(inds)), inds, 'UniformOutput', 0);
   
    %repmat(mop, size(inds))��evaluate�Ĵ���������V�inds��evaluate�Ĵ���������INDS��
    %Ŀǰû�а취��--------------------��������������������������������������������������������
    v = cell2mat(V);
    idealp = min(idealp, min(v,[],2));%2�ǰ�������С��1�ǰ�������С
    %disp(v);
    
    %indcells = mat2cell(INDS, 1, ones(1,params.popsize));8j
    [subproblems.curpoint] = INDS{:};%����ǰ�õ���INDS�ŵ��������curpoint��
    clear inds INDS V indcells;%���
end
    
function subproblems = evolve(subproblems, mop, params)%��������
    global idealpoint;%�ο���
   
    for i=1:length(subproblems)%1-101
        %new point generation using genetic operations, and evaluate
        %it.���Ŵ��㷨�����µĵ㣬����������µĸ���
        ind = genetic_op(subproblems, i, mop.domain, params);
        [obj,ind] = evaluate(mop, ind);
        %update the idealpoint.------���²ο���
        idealpoint = min(idealpoint, obj);
        
        %update the neighbours.------��������
        neighbourindex = subproblems(i).neighbour;
        subproblems(neighbourindex)=update(subproblems(neighbourindex),ind, idealpoint);
        %clear ind obj neighbourindex neighbours;        

        clear ind obj neighbourindex;
    end
end

function subp =update(subp, ind, idealpoint)
    global params
    
    newobj=subobjective([subp.weight], ind.objective,  idealpoint, params.dmethod);
    oops = [subp.curpoint]; 
    oldobj=subobjective([subp.weight], [oops.objective], idealpoint, params.dmethod );
    
    C = newobj < oldobj;
    [subp(C).curpoint]= deal(ind);
    clear C newobj oops oldobj;
end

function y =terminate(itrcounter)
    global params;
    y = itrcounter>params.iteration;
end
