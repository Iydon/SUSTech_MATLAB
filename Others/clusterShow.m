classdef clusterShow < handle
    %% properties
    properties (Access=public)
        data       % [V1,V2,...,Vn]
        numClust
        maxIt
        error
        FCMOptions
    end
    %% constructor
    methods
        function obj = clusterShow(data,numClust,maxIt,error,FCMOptions)
            % default properties
            if nargin<5,FCMOptions=[2;100;1e-5;1];end
            if nargin<4, error=eps;end
            if nargin<3, maxIt=100;end
            if nargin<2,numClust=2;end
            obj.data       = data;
            obj.numClust   = numClust;
            obj.maxIt      = maxIt;
            obj.error      = error;
            obj.FCMOptions = FCMOptions;
        end
    end
    %% methods
    % k-means
    methods (Static=true)
        function kmeansII(obj)
            [data,numClust,maxIt,error]=deal(obj.data,obj.numClust,obj.maxIt,obj.error);
            data = data(1:2,:);
            fig = figure('Name','k-means����','NumberTitle','off');
            colordef(fig,'black');set(fig,'Colormap',spring);
            % data preprocessing
            len = length(data);
            tmp = randperm(len, numClust);
            idx = zeros(1,len);
            idx(tmp) = 1:length(tmp);
            centr = data(:,tmp);    % centre
            colour = linspace(0,1,numClust);
            % body
            for it = 1:maxIt
                oldCentr = centr;
                scatter(centr(1,:),centr(2,:),50,'filled');hold on;
                for i=1:len
                    [~,id] = min(sum((data(:,i)-centr).^2,1));
                    idx(i) = id;
                end
                for i=1:numClust
                    tmp = (idx==i);
                    centr(:,i) = mean(data(:,tmp),2);
                    scatter(data(1,tmp),data(2,tmp),20,ones(1,sum(tmp))*colour(i));
                end
                pause(1);hold off;
                % terminate when reaching the precision
                if sum((oldCentr-centr).^2)<error
                    return;
                end
            end
        end
        
        function kmeansIII(obj)
            [data,numClust,maxIt,error]=deal(obj.data,obj.numClust,obj.maxIt,obj.error);
            data = data(1:3,:);
            fig = figure('Name','k-means����','NumberTitle','off');
            colordef(fig,'black');set(fig,'Colormap',spring);
            % data preprocessing
            len = length(data);
            tmp = randperm(len, numClust);
            idx = zeros(1,len);
            idx(tmp) = 1:length(tmp);
            centr = data(:,tmp);    % centre
            colour = linspace(0,1,numClust);
            % body
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
                pause(1);hold off;
                % terminate when reaching the precision
                if sum((oldCentr-centr).^2)<error
                    return;
                end
            end

        end
    end
    
    % FCM
    methods (Static=true)
        function[center,U,obj_fun] = FCMCluster(obj)
            %����ģ��C��ֵ�����ݼ�data��Ϊn��
            % ���룺
            % data			n*m����n����������ÿ��������ά��Ϊm
            % cateNum	   	�����
            % options 4*1 	����
            % options(1):	�����Ⱦ���U�ļ�Ȩָ��
            % options(2):	����������
            % options(3):	��������С�仯����������ֹ����
            % options(4):	ÿ�ε����Ƿ������Ϣ��־
            % �����
            % center	    ��������
            % U		        �����Ⱦ���
            % obj_fun       Ŀ�꺯��ֵ
            [data,numClust,options]=deal(obj.data',obj.numClust,obj.FCMOptions);
            data_n = size(data,1);
            %��options �еķ����ֱ�ֵ���ĸ�����
            expo      = options(1);
            max_iter  = options(2);
            min_impro = options(3);
            display   = options(4);
            obj_fun   = zeros(max_iter,1);
            % ��ʼ��ģ���������
            U = obj.init(numClust,data_n);
            % ��ʼ��ͼ��
            fig = figure('Name','FCM����','NumberTitle','off');
            colordef(fig,'black');set(fig,'Colormap',spring);
            % ������
            for i=1:max_iter
                [U,center,obj_fun(i)] = obj.stepwise(obj,data,U,numClust,expo);
                if display
                    fprintf('FCM:Iteration count=%d,obj_fun=%f\n',i,obj_fun(i));
                    scatter3(center(:,1),center(:,2),center(:,3),50,'filled');
                    hold on;
                    for k=1:numClust
                        dist    = obj.calcDist(center,data);
                        [~,idx] = min(dist);
                        tmp     = (idx==k);
                        scatter3(data(tmp,1),data(tmp,2),data(tmp,3),20);
                    end
                    pause(1);hold off;
                end
                % ��ֹ�����б�
                if i>1
                    if abs(obj_fun(i)-obj_fun(i-1))<min_impro
                        % ��Ŀ�꺯��ʣ�µĲ����ÿ�
                        obj_fun(i+1:max_iter) = [];
                        return
                    end
                end
            end
        end
        function U = init(numClust,data_n)
            % �Ӻ��� ģ�������ʼ��
            U       = rand(numClust,data_n);
            col_sum = sum(U);
            % ��һ��
            U       = U./col_sum(ones(numClust,1),:);
        end
        function [U_new,center,obj_fun] = stepwise(obj,data,U,numClust,expo)
            % �Ӻ��� �𲽾���
            mf      = U.^expo;
            center  = mf*data ./ ( (sum(mf,2))*ones(1,size(data,2)) );
            dist    = obj.calcDist(center,data);
            obj_fun = sum( sum((dist.^2).*mf) );
            tmp     = dist.^( -2/(expo-1) );
            U_new   = tmp ./ ( ones(numClust,1)*sum(tmp) );
        end
        function out = calcDist(center,data)
            % �Ӻ��� �������
            out = zeros(size(center,1),size(data,1));
            for k=1:size(center,1)
                out(k,:) = sqrt(sum(((data-repmat(center(k,:),size(data,1),1)).^2),2));
            end
        end
    end
    
    % neural net
    methods (Static=true)
        function net = SOM(obj,dimensions)
            if nargin<2,dimensions=[3 3];end
            data     = obj.data;
            % ��������
            net = selforgmap(dimensions);
            net.trainParam.showWindow = 0;
            % ѵ������
            [net,~] = train(net,data);
            nidx    = net(data);
            nidx    = vec2ind(nidx)';
            % ���ƾ���Ч��ͼ
            figure('Name','���������', 'NumberTitle','off');
            F3 = plot3(data(1,nidx==1), data(2,nidx==1),data(3,nidx==1),'r*', ...
                       data(1,nidx==2), data(2,nidx==2),data(3,nidx==2), 'bo', ...
                       data(1,nidx==3), data(2,nidx==3),data(3,nidx==3), 'kd');
            set(gca,'linewidth',2);
            grid on
            set(F3,'linewidth',2, 'MarkerSize',8);
            xlabel('x','fontsize',12);
            ylabel('y','fontsize',12);
            zlabel('z','fontsize',12);
            title('�����緽��������')
            % ���˽ṹ
            figure('Name','self-organizing map topology','NumberTitle','off');
            plotsomtop(net);
            figure('Name','self-organizing map neighbor connections','NumberTitle','off');
            plotsomnc(net);
            figure('Name','self-organizing map neighbor distances','NumberTitle','off');
            plotsomnd(net);
            figure('Name','self-organizing map weight planes','NumberTitle','off');
            plotsomplanes(net);
            figure('Name','self-organizing map sample hits','NumberTitle','off');
            plotsomhits(net,data);
            figure('Name','self-organizing map weight positions','NumberTitle','off');
            plotsompos(net);
        end
    end
    
    % DBSCAN
    methods (Static=true)
        function [idx, isnoise] = DBSCAN(obj,epsilon,MinPts)
            if nargin<3,MinPts =1;end
            if nargin<2,epsilon=1;end
            data    = obj.data(1:3,:)';
            label   = 0;
            data_n  = size(data,1);
            idx     = zeros(data_n,1);
            D       = pdist2(data,data);
            visited = false(data_n,1);
            isnoise = false(data_n,1);
            figure('Name','DBSCAN','NumberTitle','off');
            colordef black; 
            colour = linspace(0,1,data_n);
            for i=1:data_n
                
                if ~visited(i)
                    visited(i) = true;
                    Neighbors = RegionQuery(i);
                    if numel(Neighbors)<MinPts
                        % data(i,:) is NOISE
                        isnoise(i) = true;
                    else
                        label = label+1;
                        Expandlabelluster(i,Neighbors,label);
                    end
                end
            end
            function Expandlabelluster(i,Neighbors,label)
                idx(i) = label;
                k = 1;
                while true
                    j = Neighbors(k);
                    if ~visited(j)
                        visited(j) = true;
                        Neighbors2 = RegionQuery(j);
                        if numel(Neighbors2)>=MinPts
                            Neighbors = [Neighbors Neighbors2]; %#ok
                        end
                    end
                    if idx(j)==0
                        idx(j) = label;
                    end
                    k = k + 1;
                    if k>numel(Neighbors)
                        break;
                    end
                end
            end
            function Neighbors = RegionQuery(i)
                Neighbors = find(D(i,:)<=epsilon);
                Idx = max(idx);
                for lambda=1:Idx
                    tmp = (idx==lambda);
                    scatter3(data(tmp,1),data(tmp,2),data(tmp,3),20,ones(1,sum(tmp))*colour(lambda));
                    axis([min(data(:,1)),max(data(:,1)),min(data(:,2)),max(data(:,2)),min(data(:,3)),max(data(:,3))]);
                    hold on;
                end
                pause(0.1)
            end
        end
    end
    
    % synthesis
    methods (Static=true)
        function synClust(obj)
            data     = (obj.data)';
            numClust = obj.numClust;
            % �����޸�
            % �����������ӻ�����
                versiableData = [data(:,1), data(:,2), data(:,3)];
            % K-Means����
                dist_k = 'cosine';            % kmeans
                    % 'sqeuclidean', 'cityblock', 'cosine', 'correlation', 'hamming'
            % ��ξ���
                dist_h = 'spearman';          % clusterdata
                link = 'weighted';
            % ����������
                dimension1 = 3;
                dimension2 = 1;

            % K-Means ����
            kidx = kmeans(data, numClust, 'distance', dist_k);
            %���ƾ���Ч��ͼ
            figure('Name','K-Means ����', 'NumberTitle','off');
            F1 = plot3(versiableData(kidx==1,1), versiableData(kidx==1,2),versiableData(kidx==1,3), 'r*', ...
                       versiableData(kidx==2,1), versiableData(kidx==2,2),versiableData(kidx==2,3), 'bo', ...
                       versiableData(kidx==3,1), versiableData(kidx==3,2),versiableData(kidx==3,3), 'kd');
            set(gca,'linewidth',2);
            grid on;
            set(F1,'linewidth',2, 'MarkerSize',8);
            xlabel('x','fontsize',12);
            ylabel('y','fontsize',12);
            zlabel('z','fontsize',12);
            title('Kmeans����������')

            % ������������س̶�
            dist_metric_k = pdist(data,dist_k);
            dd_k = squareform(dist_metric_k);
            [~,idx] = sort(kidx);
            dd_k = dd_k(idx,idx);
            figure('Name','K-Means ����', 'NumberTitle','off');
            imagesc(dd_k)
            set(gca,'linewidth',2);
            xlabel('���ݵ�','fontsize',12)
            ylabel('���ݵ�', 'fontsize',12)
            title('k-Means��������س̶�ͼ', 'fontsize',12)
            ylabel(colorbar,['�������:', dist_k])
            axis square

            % ��ξ���
            hidx = clusterdata(data, 'maxclust', numClust, 'distance' , dist_h, 'linkage', link);

            %���ƾ���Ч��ͼ
            figure('Name','��ξ���', 'NumberTitle','off');
            F2 = plot3(versiableData(hidx==1,1), versiableData(hidx==1,2),versiableData(hidx==1,3),'r*', ...
                       versiableData(hidx==2,1), versiableData(hidx==2,2),versiableData(hidx==2,3), 'bo', ...
                       versiableData(hidx==3,1), versiableData(hidx==3,2),versiableData(hidx==3,3), 'kd');
            set(gca,'linewidth',2);
            grid on
            set(F2,'linewidth',2, 'MarkerSize',8);
            set(gca,'linewidth',2);
            xlabel('x','fontsize',12);
            ylabel('y','fontsize',12);
            zlabel('z','fontsize',12);
            title('��ξ��෽��������')

            % ������������س̶�
            dist_metric_h = pdist(data,dist_h);
            dd_h = squareform(dist_metric_h);
            [~,idx] = sort(hidx);
            dd_h = dd_h(idx,idx);
            figure('Name','��ξ���', 'NumberTitle','off');
            imagesc(dd_h)
            set(gca,'linewidth',2);
            xlabel('���ݵ�', 'fontsize',12)
            ylabel('���ݵ�', 'fontsize',12)
            title('��ξ�������س̶�ͼ')
            ylabel(colorbar,['�������:', dist_h])
            axis square

            % ����ͬ�����ϵ��
            Z = linkage(dist_metric_h, link);
            cpcc = cophenet(Z, dist_metric_h);
            disp('ͬ�����ϵ��: ')
            disp(cpcc)

            % ��νṹͼ
            set(0,'RecursionLimit',5000)
            figure('Name','��ξ���', 'NumberTitle','off');
            dendrogram(Z)
            set(gca,'linewidth',2);
            set(0,'RecursionLimit',500)
            xlabel('���ݵ�', 'fontsize',12)
            ylabel ('��׼����', 'fontsize',12)
             title('��ξ��෨��νṹͼ')

            % ������
            % ��������
            net = selforgmap([dimension1 dimension2]);
            net.trainParam.showWindow = 0;
            % ѵ������
            [net,~] = train(net,data');
            nidx = net(data');
            nidx = vec2ind(nidx)';

            % ���ƾ���Ч��ͼ
            figure('Name','���������', 'NumberTitle','off');
            F3 = plot3(versiableData(nidx==1,1), versiableData(nidx==1,2),versiableData(nidx==1,3),'r*', ...
                       versiableData(nidx==2,1), versiableData(nidx==2,2),versiableData(nidx==2,3), 'bo', ...
                       versiableData(nidx==3,1), versiableData(nidx==3,2),versiableData(nidx==3,3), 'kd');
            set(gca,'linewidth',2);
            grid on
            set(F3,'linewidth',2, 'MarkerSize',8);
            xlabel('x','fontsize',12);
            ylabel('y','fontsize',12);
            zlabel('z','fontsize',12);
            title('�����緽��������')

            % ģ��C-Means����
            options = nan(4,1);
            options(4) = 0;
            [~,U] = fcm(data,numClust, options);
            [~, fidx] = max(U);
            fidx = fidx';

            % ���ƾ���Ч��ͼ
            figure('Name','ģ��C-Means����', 'NumberTitle','off');
            F4 = plot3(versiableData(fidx==1,1), versiableData(fidx==1,2),versiableData(fidx==1,3),'r*', ...
                       versiableData(fidx==2,1), versiableData(fidx==2,2),versiableData(fidx==2,3), 'bo', ...
                       versiableData(fidx==3,1), versiableData(fidx==3,2),versiableData(fidx==3,3), 'kd');
            set(gca,'linewidth',2);
            grid on
            set(F4,'linewidth',2, 'MarkerSize',8);
            xlabel('x','fontsize',12);
            ylabel('y','fontsize',12);
            zlabel('z','fontsize',12);
            title('ģ��C-Means����������')

            % ��˹��Ͼ��� (GMM)
            gmobj = gmdistribution.fit(data,numClust);
            gidx = cluster(gmobj,data);

            % ���ƾ���Ч��ͼ
            figure('Name','��˹��Ͼ���', 'NumberTitle','off');
            F5 = plot3(versiableData(gidx==1,1), versiableData(gidx==1,2),versiableData(gidx==1,3),'r*', ...
                       versiableData(gidx==2,1), versiableData(gidx==2,2),versiableData(gidx==2,3), 'bo', ...
                       versiableData(gidx==3,1), versiableData(gidx==3,2),versiableData(gidx==3,3), 'kd');
            set(gca,'linewidth',2);
            grid on
            set(F5,'linewidth',2, 'MarkerSize',8);
            xlabel('x','fontsize',12);
            ylabel('y','fontsize',12);
            zlabel('z','fontsize',12);
            title('��˹��Ϸ���������')

            % k-Means����ȷ����ѵľ��������
            % ���Ƽ����������������µ�ƽ������ֵͼ
            figure('Name','k-Means����ȷ����ѵľ��������', 'NumberTitle','off');
            for i=2:4
                kidx = kmeans(data,i,'distance',dist_k);
                subplot(3,1,i-1)
                [~,F6] = silhouette(data,kidx,dist_k); %#ok
                xlabel('����ֵ','fontsize',12);
                ylabel('�����','fontsize',12);
                set(gca,'linewidth',2);
                title([num2str(i) '���Ӧ������ֵͼ ' ])
                snapnow
            end

            % ����ƽ������ֵ
            numC = 15;
            silh_m = nan(numC,1);
            for i=1:numC
                kidx = kmeans(data,i,'distance',dist_k,'MaxIter',500);
                silh = silhouette(data,kidx,dist_k);
                silh_m(i) = mean(silh);
            end

            % ���Ƹ��������Ӧ��ƽ������ֵͼ
            figure('Name','ƽ������ֵͼ', 'NumberTitle','off');
            F7 = plot(1:numC,silh_m,'o-');
            set(gca,'linewidth',2);
            set(F7, 'linewidth',2, 'MarkerSize',8);
            xlabel('�����', 'fontsize',12)
            ylabel('ƽ������ֵ','fontsize',12)
            title('ƽ������ֵvs.�����')
        end
    end
    
end