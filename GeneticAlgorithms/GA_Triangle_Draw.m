function pic_out = GA_Triangle_Draw(pic_origin ,individual_amount ,outstanding_gene_amount ,target_accuracy ,generation_number ,Pc ,Pcn ,Pm,triangle_num)
    %% ����Ԥ����
    [W,L,~] = size(pic_origin);
    pic_resize = double(imresize(pic_origin,[256,256]));
    total_amount = individual_amount + outstanding_gene_amount;

    %% ������Ⱥ
    population = char(randi([48,49],72*triangle_num,total_amount));
    % ACSII��48��49��Ӧ��ֵΪ0��1���Դ˱�ʾ�����ƻ���
    %��Ⱦɫ�峤��Ϊ7200
    % optimal_fitness��������Ӧ��
    % optimal_gene��������Ӧ�ȶ�Ӧ�Ļ���
    fitness_array = zeros(1,total_amount);

    %% �Ŵ��㷨
    figure('Name','optimal_gene');
    for generation_counter = 1:generation_number
        parfor i=1:total_amount
            % ���м�����Ӧ��
            gene = population(:,i);
            fitness_array(i) = Calculate_Fitness(pic_resize,gene,triangle_num);
        end
        [optimal_fitness, idx] = max(fitness_array);
        optimal_gene = population(:,idx);
        % ɸѡ��������Ӧ�����Ӧ�Ļ���

        if optimal_fitness>=target_accuracy
            break;
        end

        %% ѡ����������������Ӵ���ֱ���Ŵ�����һ��
        [~,idx] = sort(fitness_array);
        outstanding_gene = population(:, idx(end-outstanding_gene_amount+1:end));

        %% ���̶ķ�ѡ�����
        new_population = roulette_selection(population,fitness_array,outstanding_gene,individual_amount, total_amount,triangle_num);
        % population��           ��Ⱥ
        % fitness_array��        ��Ӧ������
        % outstanding_gene��     ���ŵĻ���
        % individual_amount��    ��Ⱥ����
        % total_amount��         ��Ⱥ���������Ż��������
        % triangle_num:              �����θ���
        
        %% �������
        new_population = crossover(new_population,outstanding_gene,Pc,Pcn,total_amount,outstanding_gene_amount,triangle_num);
        % new_population��           �µ���Ⱥ
        % outstanding_gene��         ���ŵĻ���
        % Pc��                       �������
        % Pcn��                      ����λ����Ŀ
        % total_amount��             ��Ⱥ���������Ż��������
        % outstanding_gene_amount��  ���Ż��������
        % triangle_num:              �����θ���
        
        %% ����ͻ��
        population = mutation(new_population,outstanding_gene,Pm,total_amount,outstanding_gene_amount,triangle_num);
        % new_population����         �µ���Ⱥ
        % outstanding_gene��         ���ŵĻ���
        % Pm��                       ����ͻ�����
        % total_amount��             ��Ⱥ���������Ż��������
        % outstanding_gene_amount��  ���Ż��������
        % triangle_num:              �����θ���
        
        %% �������
        disp(['generation_',num2str(generation_counter),': ',num2str(optimal_fitness)]);
        pic_out = Draw_Picture(optimal_gene,triangle_num);
        pic_out = imresize(pic_out,[W,L]);
        imshow(uint8(pic_out));
    end
    pic_out = Draw_Picture(optimal_gene,triangle_num);
    pic_out = imresize(pic_out,[W,L]);
end

