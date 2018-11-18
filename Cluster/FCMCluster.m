function[center,U,obj_fun]=FCMCluster(data,cateNum,options)
	%����ģ��C��ֵ�����ݼ�data��Ϊn��
	%�÷�
	% 1: [center,U,obj_fcn]=FCMCluster(data,n,options);
	% 2: [center,U,obj_fcn]=FCMCluster(data,n);

	% ����
	% data			n*m����n����������ÿ��������ά��Ϊm
	% cateNum	   	�����
	% options 4*1 	����
	% options(1):	�����Ⱦ���U�ļ�Ȩָ��
	% options(2):	����������
	% options(3):	��������С�仯����������ֹ����
	% options(4):	ÿ�ε����Ƿ������Ϣ��־
	% ���
	% center	��������
	% U			�����Ⱦ���
	% obj_fun   Ŀ�꺯��ֵ
    
    if nargin==2,options=[2;100;1e-5;1];end
	data_n = size(data,1);

	%��options �еķ����ֱ�ֵ���ĸ�����
	expo = options(1);
	max_iter = options(2);
	min_impro = options(3);
	display = options(4);
	obj_fun = zeros(max_iter,1);

	%��ʼ��ģ���������
	U = initfcm(cateNum,data_n);


	%% ������
	for i=1:max_iter
		[U,center,obj_fun(i)]=stepfcm(data,U,cateNum,expo);
		if display
			fprintf('FCM:Iteration count=%d,obj_fun=%f\n',i,obj_fun(i));
		end
		%��ֹ�����б�
		if i>1
			if abs(obj_fun(i)-obj_fun(i-1))<min_impro
				break;
			end
			end
	end
	iter_n=i;
	obj_fun(iter_n+1:max_iter)=[];
end

%% �Ӻ��� ģ�������ʼ��
function U = initfcm(cateNum,data_n)
	U = rand(cateNum,data_n);
	col_sum = sum(U);
	U = U./col_sum(ones(cateNum,1),:);
end


%% �Ӻ��� �𲽾���
function [U_new,center,obj_fun] = stepfcm(data,U,cateNum,expo)
	mf = U.^expo;
	center = mf*data ./ ( (sum(mf,2))*ones(1,size(data,2)) );
	dist = distfcm(center,data);
	obj_fun = sum( sum((dist.^2).*mf) );
	tmp = dist.^( -2/(expo-1) );
	U_new = tmp ./ ( ones(cateNum,1)*sum(tmp) );
end


%% �Ӻ��� �������
function out = distfcm(center,data)
	out = zeros(size(center,1),size(data,1));
	for k=1:size(center,1)
		out(k,:) = sqrt(sum(((data-repmat(center(k,:),size(data,1),1)).^2),2));
	end
end

%% ��������
%{
data=rand(100,2); 
[center,U,obj_fcn] = FCMCluster(data,2); 
figure(1)
plot(data(:,1),data(:,2),'o'); 
figure(2)
index1=find(U(1,:)==max(U));    %�ҳ�����Ϊ��һ����������� 
index2=find(U(2,:)==max(U));    %�ҳ�����Ϊ�ڶ������������ 
plot(data(index1,1),data(index1,2),'g*'); 
hold on; 
plot(data(index2,1),data(index2,2),'r*'); 
hold on; 
plot([center([1 2],1)],[center([1 2],2)],'*','color','k');
%}