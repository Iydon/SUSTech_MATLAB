function interp2plot(x, y, z, xi, yi, method)
    % ��ά��ֵ
    % x, y:         ���ݷ�Χ
    % z:            �۲�����
    % xi, yi:       ��ֵ��Χ
    % eg: [x,y]=meshgrid(-5:1:5); z=peaks(x,y); [xi,yi]=meshgrid(-5:0.8:5);
    if nargin==5
        method = 'linear';
    end
    
    zi_nearest=interp2(x,y,z,xi,yi,'nearest');		% �ٽ����ֵ
    zi_linear=interp2(x,y,z,xi,yi);					% ���Բ�ֵ
    zi_spline=interp2(x,y,z,xi,yi,'spline');		% ����������ֵ
    zi_cubic=interp2(x,y,z,xi,yi,'cubic');			% ���ζ���ʽ��ֵ
    
    figure;
    hold on;
    subplot(231);
        surf(x,y,z);				% ԭʼ���ݵ�
        title('ԭʼ����');
    subplot(232);
        surf(xi,yi,zi_nearest);		% �ٽ����ֵ
        title('�ٽ����ֵ');
    subplot(233);
        surf(xi,yi,zi_linear);		% ���Բ�ֵ
        title('���Բ�ֵ');
    subplot(234);
        surf(xi,yi,zi_spline);		% ����������ֵ
        title('����������ֵ');
    subplot(235);
        surf(xi,yi,zi_cubic);		% ���ζ���ʽ��ֵ
        title('���ζ���ʽ��ֵ');
        
     zi = interp2(x,y,z,xi,yi,method);
     figure;
     surf(xi,yi,zi);
     title(method);xlabel('x');ylabel('y');ylabel('z');

end