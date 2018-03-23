function [v, x] = evaluate( prob, x )
%EVALUATE function evaluate an individual structure of a vector point with
%the given multiobjective problem.

%   Detailed explanation goes here
%   prob: is the multiobjective problem.---prob�Ƕ�Ŀ������
%   x: is a vector point, or a individual structure.----x�Ǹ���Ľṹ��
%   v: is the result objectives evaluated by the mop.-------v��Ŀ�����۵Ľ��
%   x: if x is a individual structure, then x's objective field
%   is modified with the evaluated value and pass
%   back.-----���x��һ������ṹ�壬x��Ŀ��������ֵ�Ľ���ͬʱ����

%   TODO, need to refine it to operate on a vector of points.
    if isstruct(x)
        v = prob.func(x.parameter);%�ж�x�Ƿ���һ���ṹ�壬����ǵĻ���ȡind.paramenter����Ŀ�꺯������
        %Ȼ���v��ind���Ǹ�objective------Ӧ����inds���
        x.objective=v;
    else
        v = prob.func(x);%x���ǽṹ�壨��ô������������أ���������-----���Ҳ�������Ҫ������������������ˣ�����
    end