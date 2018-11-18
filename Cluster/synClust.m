function synClust(data, numClust)
    % data:         ���ݣ�ӦΪtable��
    % numClust:     ������������
    
    %% �����޸�
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

    %% K-Means ����
    kidx = kmeans(data, numClust, 'distance', dist_k);
    % ���ƾ���Ч��ͼ
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
    
    %% ��ξ���
    hidx = clusterdata(data, 'maxclust', numClust, 'distance' , dist_h, 'linkage', link);

    % ���ƾ���Ч��ͼ
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
     
   %% ������
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

    %% ģ��C-Means����
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

    %% ��˹��Ͼ��� (GMM)
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

   %% k-Means����ȷ����ѵľ��������
    % ���Ƽ����������������µ�ƽ������ֵͼ
    figure('Name','k-Means����ȷ����ѵľ��������', 'NumberTitle','off');
    for i=2:4
        kidx = kmeans(data,i,'distance',dist_k);
        subplot(3,1,i-1)
        [~,F6] = silhouette(data,kidx,dist_k);
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