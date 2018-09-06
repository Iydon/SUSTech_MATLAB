function interp1plot(x, y, xi, method)
    % һά��ֵ
    % x, y:     ԭʼ����
    % xi:       ��ֵ��
    % method:   ָ���㷨���в�ֵ
    if nargin==3
        method = 'linear';
    end
    
    yi_nearest = interp1(x, y, xi, 'nearest');  % �ٽ����ֵ
    yi_linear = interp1(x, y, xi);              % ���Բ�ֵ
    yi_spine = interp1(x, y, xi, 'spine');      % ����������ֵ
    yi_pchip = interp1(x, y, xi, 'pchip');      % Hermite��ֵ
    yi_v5cubic = interp1(x, y, xi, 'v5cubic');  % ���ζ���ʽ��ֵ
    
    figure;
    hold on;
    subplot(231);
        plot(x,y,'ro');								% �������ݵ�
        title('��֪���ݵ�');
    subplot(232);
        plot(x,y,'ro',xi,yi_nearest,'b-');			% �ٽ����ֵ
        title('�ٽ����ֵ');
    subplot(233);	
        plot(x,y,'ro',xi,yi_linear,'b-');			% ���Բ�ֵ
        title('���Բ�ֵ');
    subplot(234);
        plot(x,y,'ro',xi,yi_spine,'b-');			% ����������ֵ
        title('����������ֵ');
    subplot(235);
        plot(x,y,'ro',xi,yi_pchip,'b-');			% �ֶ�����Hermite��ֵ
        title('�ֶ�����Hermite��ֵ');
    subplot(236);
        plot(x,y,'ro',xi,yi_v5cubic,'b-');			% ���ζ���ʽ��ֵ
        title('���ζ���ʽ��ֵ');
    
    yi = interp1(x, y, xi, method);
    figure;
    plot(x,y,'ro',xi,yi,'b-');
    title(method);xlabel('x');ylabel('y');

end