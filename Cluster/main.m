%% k-means����
%{
http://blog.csdn.net/taoyanqi8932/article/details/53727841
%}
%{
1����D�����ȡk��Ԫ�أ���Ϊk���صĸ��Ե����ġ�
2���ֱ����ʣ�µ�Ԫ�ص�k�������ĵľ��룬����ЩԪ�طֱ𻮹鵽������С�Ĵء�
3�����ݾ�������ͨ������ƽ��ֵ���¼���k���ظ��Ե����ġ�
4����D��ȫ��Ԫ�ذ����µ��������¾��ࡣ
5���ظ���4����ֱ���ص����ı仯С��Ԥ����
6������������
%}
%{
�ŵ㣺
1.�ǽ�����������һ�־����㷨���򵥡�����
2.�Դ�������ݼ������㷨���ֿ������Ժ͸�Ч��
3.����������ܼ��ģ�����Ч���Ϻ�
ȱ�㣺
1.�ڴص�ƽ��ֵ�ɱ����������²���ʹ�ã����ܲ�������ĳЩӦ��
2.�������ȸ���k��Ҫ���ɵĴص���Ŀ�������ҶԳ�ֵ���У����ڲ�ͬ�ĳ�ʼֵ�����ܻᵼ�²�ͬ�����
3.���ʺ��ڷ��ַ�͹��״�Ĵػ��ߴ�С���ܴ�Ĵ�
4.�������͹�������������
%}

%% ��ά���ȷֲ�
figure(1)
data = rand(2,10000);
kmeansII(data,10,100)
disp('Done')

%% ��ά���ȷֲ�
figure(2)
data = rand(3,10000);
kmeansIII(data,7,100)
disp('Done')

%% ��͹�ֲ�
data = rand(2,10000)*6-3;
dist = data(1,:).^2+data(2,:).^2;
loc = or(dist>27,and(dist<8,dist>1));
data(:,loc)=[];
figure(3)
kmeansII(data,2)
disp('Done')



%% ��ξ���
%{
http://blog.csdn.net/u012500237/article/details/65437525
https://www.cnblogs.com/xmeo/p/6543057.html
%}
%{
AGNES: bottom-up
DIANA: top-down
���k-means������ѡ��������ô��ξ�����൱��ϣ��������鲢����
������ֳ����������⣬ͨ���ݹ�����ķ����㷨��⡣
%}



%% FCM����
%{
http://blog.csdn.net/zjsghww/article/details/50922168
%}



%% ��͹�ֲ�
data = rand(2,10000)*6-3;
dist = data(1,:).^2+data(2,:).^2;
loc = or(dist>9,and(dist<4,dist>1));
data(:,loc)=[];
data = data';

[center,U,obj_fcn] = FCMCluster(data,3); 
figure(4)
plot(data(:,1),data(:,2),'o'); 
figure(5)
index1=find(U(1,:)==max(U));    % �ҳ�����Ϊ��һ����������� 
index2=find(U(2,:)==max(U));    % �ҳ�����Ϊ�ڶ������������ 
index3=find(U(3,:)==max(U));    % �ҳ�����Ϊ��������������� 
scatter(data(index1,1),data(index1,2)); 
hold on; 
scatter(data(index2,1),data(index2,2)); 
hold on; 
scatter(data(index3,1),data(index3,2)); 
hold on; 
plot((center([1 2 3],1)),(center([1 2 3],2)),'*','color','k');

figure(6)
kmeansII(data',3,100,1e-5,0);
disp('Done')



%% �ۺ�
load('testSynClusteringMatrix.mat')
scatter3(A(:,1),A(:,2),A(:,3));
title('ԭʼ����')
pauseFlag = input('continue?');
synClust(A,3)



%% ��������ࣨAPP��
% Iris Flower
load('iris_dataset')

% ctrl+r/t
% % �����������APP
% data = irisInputs;
% idx = irisTargets;
% x = irisInputs(1,:);
% y = irisInputs(2,:);
% z = irisInputs(3,:);
% % ԭʼ����
% figure(1)
% scatter3(x,y,z);
% % ʵ������
% figure(2)
% scatter3(x(idx(1,:)==1),y(idx(1,:)==1),z(idx(1,:)==1),'r');
% hold on
% scatter3(x(idx(2,:)==1),y(idx(2,:)==1),z(idx(2,:)==1),'g');
% scatter3(x(idx(3,:)==1),y(idx(3,:)==1),z(idx(3,:)==1),'b');
% % �����������
% figure(3)
% scatter3(x(output(1,:)==1),y(output(1,:)==1),z(output(1,:)==1));
% hold on
% scatter3(x(output(2,:)==1),y(output(2,:)==1),z(output(2,:)==1));
% scatter3(x(output(3,:)==1),y(output(3,:)==1),z(output(3,:)==1));
% scatter3(x(output(4,:)==1),y(output(4,:)==1),z(output(4,:)==1));



%% ����
% keams��ά
function kmeansII(data,numClust,maxIt,error,pauseTime)
    % ����Ԥ����
    %
    %
    if nargin<4,error=eps;pauseTime=1;end;if nargin<3,maxIt=1000;end
    len = length(data);
    tmp = randperm(len, numClust);
    idx = zeros(1,len);
    idx(tmp) = 1:length(tmp);
    centr = data(:,tmp);    % ����
    colour = linspace(0,1,numClust);
	
    % ��������
    for it = 1:maxIt
        oldCentr = centr;
        scatter(centr(1,:),centr(2,:),50,'filled');
        hold on;
        
        for i=1:len
            [~,id] = min(sum((data(:,i)-centr).^2,1));
            idx(i) = id;
        end
        
        for i=1:numClust
            tmp = (idx==i);
            centr(:,i) = mean(data(:,tmp),2);
            scatter(data(1,tmp),data(2,tmp),20,ones(1,sum(tmp))*colour(i));
        end
        pause(pauseTime)
        hold off;
        
        if sum((oldCentr-centr).^2)<error
            % �ﵽ���Ⱥ���ֹ
            return;
        end
    end
    
end
% kmeans��ά
function kmeansIII(data,numClust,maxIt,error)
    % ����Ԥ����
    if nargin<4,error=eps;end;if nargin<3,maxIt=1000;end
    len = length(data);
    tmp = randperm(len, numClust);
    idx = zeros(1,len);
    idx(tmp) = 1:length(tmp);
    centr = data(:,tmp);    % ����
    colour = linspace(0,1,numClust);
	
    % ��������
    for it = 1:maxIt
        oldCentr = centr;
        scatter3(centr(1,:),centr(2,:),centr(3,:),50,'filled');
        hold on;
        
        for i=1:len
            [~,id] = min(sum((data(:,i)-centr).^2,1));
            idx(i) = id;
        end
        
        for i=1:numClust
            tmp = (idx==i);
            centr(:,i) = mean(data(:,tmp),2);
            scatter3(data(1,tmp),data(2,tmp),data(3,tmp),20,ones(1,sum(tmp))*colour(i));
        end
        pause(1)
        hold off;
        
        if sum((oldCentr-centr).^2)<error
            % �ﵽ���Ⱥ���ֹ
            return;
        end
    end
    
end
% FCM
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
    
    if nargin==2,options=[2;100;1e-5;0];end
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
% �Ӻ��� ģ�������ʼ��
function U = initfcm(cateNum,data_n)
	U = rand(cateNum,data_n);
	col_sum = sum(U);
	U = U./col_sum(ones(cateNum,1),:);
end
% �Ӻ��� �𲽾���
function [U_new,center,obj_fun] = stepfcm(data,U,cateNum,expo)
	mf = U.^expo;
	center = mf*data ./ ( (sum(mf,2))*ones(1,size(data,2)) );
	dist = distfcm(center,data);
	obj_fun = sum( sum((dist.^2).*mf) );
	tmp = dist.^( -2/(expo-1) );
	U_new = tmp ./ ( ones(cateNum,1)*sum(tmp) );
end
% �Ӻ��� �������
function out = distfcm(center,data)
	out = zeros(size(center,1),size(data,1));
	for k=1:size(center,1)
		out(k,:) = sqrt(sum(((data-repmat(center(k,:),size(data,1),1)).^2),2));
	end
end