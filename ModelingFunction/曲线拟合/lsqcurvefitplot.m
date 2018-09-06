function [coefficient, resnorm] = lsqcurvefitplot(dataX, dataY, fcn, x0)
    % �������������
    % fcn:              fcn = @(coefficient, data)......
    % coefficient:      ϵ��
    % resnorm:          �в�
    % x, y:             ����
    % x0:               ʹ�õ�������Ҫ��ʼ������
    len = length(dataX);
    if nargin==3
        x0 = zeros(len, 1);
    end
    dataX = reshape(dataX, len, 1);
    dataY = reshape(dataY, len, 1);
    
    
    [coefficient, resnorm] = lsqcurvefit(fcn, x0, dataX, dataY);
     ye = fcn(coefficient, dataX);
    
    figure;
    plot(dataX, dataY, 'bo');
    hold on;
    plot(dataX, ye, 'r:');
    legend('Raw Data', 'Lsqcurvefit');
    xlabel('x');ylabel('y');
end