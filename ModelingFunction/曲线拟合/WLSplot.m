function [polyCoefficient, err] = WLSplot(x, y, W, order)
    % ��Ȩ��С�������ʽ���
    % ע�⣬��Ȩ����ӦΪ�����ξ�����ά����xԪ�ظ������
    % x, y:     ���ݵ�ϵ��
    % W:        Ȩ�ؾ���
    % order:    ��Ͻ���
    if nargin==3
        order = 1;
    end
    len = length(x);
    x = reshape(x, len, 1);
    y = reshape(y, len, 1);
    
    A(:,order+1) = ones(len, 1);
    for i = order:-1:1
        A(:,i) = A(:, i+1) .* x;
    end
    
    polyCoefficient = (W*A)\y;
    ye = polyval(polyCoefficient, x);
    err = norm(y-ye)/norm(y);
    
    figure;
    plot(x, y, 'bo');
    hold on;
    plot(x, ye, 'r:');
    legend('Raw Data', 'Polyfit');
    xlabel('x');ylabel('y');
end