function Fitness = Calculate_Fitness(pic ,gene,triangle_num)
    max_diff = 255^3*3;
    % ����ͼ��Ϊ256*256����Ϊ��ͨ�������ݼ���Ϊ255
    % �������ݹ�һ��ʱʹ��max_diff
    
    [W,L,~] = size(pic);
    triangle_point = gene(1:48*triangle_num);
    % �����εĶ�����1::4800����
    triangle_color = gene(48*triangle_num+1:72*triangle_num);
    % �����ε���ɫ��4801:7200����
    triangle_point = reshape(triangle_point,6*triangle_num,8);
    triangle_color = reshape(triangle_color,3*triangle_num,8);
    triangle_point = bin2dec(triangle_point) + 1;
    triangle_color = bin2dec(triangle_color);
    % �����ı���ʾ�Ķ���������ת��Ϊʮ��������
    triangle_point = reshape(triangle_point,triangle_num,6);
    % ÿ���������ݷֱ��ʾ������ĺ�������
    triangle_color = reshape(triangle_color,triangle_num,3);
    % ÿ���������ݷֱ���ɫ��RGB
    pic_gene = insertShape(ones(W,L,3)*255,'FilledPolygon',triangle_point,'Color',triangle_color,'Opacity',0.7);
    % Insert shapes in image or video
    Fitness = abs(pic - pic_gene);
    Fitness = 1 - sum(Fitness(:))/max_diff;
    % ������Ӧ��
end

