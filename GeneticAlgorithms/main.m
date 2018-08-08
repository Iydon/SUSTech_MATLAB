%% ���ݶ�ȡ������趨
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif',...
                       'ѡ��ͼƬ�ļ�'});
% ��ȡ�ļ�
pic_origin = imread(fullfile(pathname,filename));
figure;
imshow(pic_origin);
% ��ȡ����ʾѡ��ͼƬ
individual_amount = 100;
% ��Ⱥ��Ŀ
outstanding_gene_amount = 10;
% ׿Խ������Ŀ�����㷨��׿Խ��������չ�
target_accuracy = 0.999;
% Ŀ��׼ȷ��
generation_number = 100000;
% ���������ﵽ��������ʱû�дﵽĿ��׼ȷ��Ҳֹͣ
triangle_num = 3;
% �����θ���
Pc = 0.7;   % �������
Pcn = 0.3;  % ����λ����Ŀ
Pm = 0.001; % ����ͻ�����

%% �Ŵ��㷨����
pic_out = GA_Triangle_Draw(pic_origin ,individual_amount ,outstanding_gene_amount ,target_accuracy ,generation_number ,Pc ,Pcn ,Pm,triangle_num);

%% Ŀ��ͼ�񱣴�����ʾ
figure;
imshow(pic_out);
new_filename = regexp(filename,'(\w+)[.]','tokens');
new_filename = [new_filename{1}{1},'_Triangle.jpg'];
imwrite(pic_out,new_filename);