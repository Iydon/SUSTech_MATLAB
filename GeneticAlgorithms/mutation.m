function new_population = mutation(new_population,outstanding_gene,Pm,total_amount,outstanding_gene_amount,triangle_num)
    % ����ͻ��
    mutation_index = rand(72*triangle_num,total_amount)<Pm;
    new_population = char(uint8(xor(new_population>48,mutation_index))+48);
    % ����ֵת��Ϊ�����ƻ����ʾ
    tmpIdx = total_amount-outstanding_gene_amount+1:total_amount;
    new_population(:,tmpIdx) = outstanding_gene;
end