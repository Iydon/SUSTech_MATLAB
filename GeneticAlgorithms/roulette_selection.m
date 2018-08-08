function new_population = roulette_selection(population, fitness_array, outstanding_gene, individual_amount, total_amount,triangle_num)
    % ���̶ķ�ѡ�����
    fitness_array_norm = fitness_array / sum(sum(fitness_array));
    % ��Ӧ�ȹ�һ��
    fitness_array_cum = [0, cumsum(fitness_array_norm)];
    roulette_number = rand(1,individual_amount);
    survive_index = discretize(roulette_number ,fitness_array_cum);
    % �����ݷ��鵽����У��ۼӹ�������Ӧ��Խ����������Խ��
    new_population = zeros(72*triangle_num,total_amount);
    new_population(:,1:individual_amount) = population(:,survive_index);
    new_population(:,individual_amount+1:total_amount) = outstanding_gene;
    new_population = new_population(:,randperm(total_amount));
    % ����û�������new_population�еĻ���˳��
end