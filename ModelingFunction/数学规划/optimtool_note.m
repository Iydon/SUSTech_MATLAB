%���Թ滮 linprog()
%���ι滮 quadprog()

%һά�Ż�����MATLAB�������еĻ�������
x = fminbnd(fun, x1, x2);
%����(x1, x2)�к���fun�ļ�Сֵ
x = fminbnd(fun, x1, x2, options);
%optiions:	Display(off, iter, final)������Ϊ��ʾ�ķ�ʽ
%			Tolx		�Ա����ľ���
%			MaxFunEval	����Ŀ�꺯����鲽��
%			MaxIter		���ĵ�������
%			FunValCheck	���Ŀ�꺯����ֵ�Ƿ�ɽ���
%			OutputFcns	�û��Զ���Ļ�ͼ����������ÿ��������������
[x, fval] = fminbnd(...);
%ͬʱ����x���ڵ�x����Ŀ�꺯��ֵ
[x, fval, exitflag] = fminbnd(..);
%�������exitflag���غ���fminbnd�����״̬���ɹ�ʧ�ܣ�
%���������Ž�(1)			�ﵽ����������(0)
%�Զ��庯��������˳�(-1)	�߽�������Э��(-2)
[x, fval, exitflag, output] = fminbnd(...);
%�����Ż��㷨���������۴����������������˳���Ϣ



%��Լ���Ż�����MATLAB�������еĻ�������
X = fminunc(fun, X_0);
%������ʼ��X_0������fun�ľֲ���С��X^*	X_0�����Ǳ�����������
X = fminunc(fun, X_0, options);
%options����ָ�����Ż���������fun����Сֵ
%optiions:	Display(off, iter, final, notify)������Ϊ��ʾ�ķ�ʽ
%			Tolx		�Ա����ľ���
%			MaxFunEval	����Ŀ�꺯����鲽��
%			MaxIter		���ĵ�������
%			FunValCheck	���Ŀ�꺯����ֵ�Ƿ�ɽ���
%			OutputFcns	�û��Զ�����������������ÿ��������������
%			PlotFcns	�û��Զ���Ļ�ͼ����������ÿ��������������
%			TolFun		Ŀ�꺯��ֵ�ľ���
[x, fval] = fminunc(...);
%ͬʱ����x���ڵ�x����Ŀ�꺯��ֵ
[x, fval, exitflag] = fminunc(..);
%�������exitflag���غ���fminbnd�����״̬���ɹ�ʧ�ܣ�
%���������Ž�(1)			�ﵽ����������(0)
%�Զ��庯��������˳�(-1)	�߽�������Э��(-2)
[x, fval, exitflag, output] = fminunc(...);
%�����Ż��㷨���������۴����������������˳���Ϣ
[x, fval, exitflag, output, grad] = fminunc(...);
%���غ���fun�ڼ�Сֵ��X���ݶ�
[x, fval, exitflag, output, grad, hessian] = fminunc(...);
%���غ���fun�ڼ�Сֵ��X����Hessian����

X = fminsearch(fun, X_0);
X = fminsearch(fun, X_0, options);
[X, fval] = fminsearch(...);
[X, fval, exitflag] = fminsearch(...);
[X, fval, exitflag, output] = fminsearch(...);
%i.e.
>>	fx = @(x) -1/((x(1)-2)^2+3)-1/((x(2)+1)^2-5);
	[x, f] = fminsearch(fx, [0, 0]);
ans
	x = 2.0000   -1.0000
	f = -0.1333



%���Թ滮����MATLAB�������еĻ�������
%			minf(X)
%		{	A*X <= b
%	s.t.{	Aeq*X = Beq
%		{	Lb <= X <= Ub
%
%����ʽԼ������(A)			��ʽԼ����ϵ������(Aeq)
%����ʽԼ���ĳ�������(b)	��ʽԼ���ĳ�������(Beq)
%�Ա����������޷�Χ(Lb, Ub)
[X, fval] = linprog(f, A, b);
[X, fval] = linprog(f, A, b, Aeq, Beq);
%������ʽ�����ڣ�����A=[], b=[]
[X, fval] = linprog(f, A, b, Aeq, Beq, Lb, Ub);
[X, fval] = linprog(f, A, b, Aeq, Beq, Lb, Ub, X_0);
%���ó�ֵΪX_0
[X, fval] = linprog(f, A, b, Aeq, Beq, Lb, Ub, X_0, options);
%��optionsָ�����Ż�����������С��
X = linprog(...);
%�������X��ֵ