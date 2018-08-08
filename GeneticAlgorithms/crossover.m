function new_population = crossover(new_population,outstanding_gene,Pc,Pcn,total_amount,outstanding_gene_amount,triangle_num)
    % �������
    crossover_index = rand(1,total_amount/2)<Pc;
    % �������
    crossover_gene_index = repelem((rand(9*triangle_num,total_amount/2)<Pcn), 8, 1);
    % ����λ����Ŀ
    crossover_gene_index(:,~crossover_index) = 0;
    % �ǽ������λ������Ϊ0
    gene_index_diff = zeros(72*triangle_num,total_amount);
    gene_index_diff(:,1:2:total_amount) = crossover_gene_index;
    gene_index_diff(:,2:2:total_amount) = -crossover_gene_index;
    % 
    [X,Y] = meshgrid(1:total_amount,1:72*triangle_num);
    new_gene_index = sub2ind([72*triangle_num,total_amount],Y,X+gene_index_diff);
    % ���±�ת��Ϊ��������
    new_population = new_population(new_gene_index);
    tmpIdx = total_amount-outstanding_gene_amount+1:total_amount;
    new_population(:,tmpIdx) = outstanding_gene;
end