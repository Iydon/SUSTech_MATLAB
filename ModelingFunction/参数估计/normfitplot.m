function [muhat, sigmahat, muci, sigmaci] = normfitplot(data, alpha)
    % ��̬�ֲ�������в�������
    % data:             ���ݵ�ϵ��
    % alpha:            ����(1-alpha)����������
    % muhat, sigmahat:  ����ֵ, ���������Ȼ���ƣ�Ҳ��ʹ��mle
    %                   mle('norm',data,alph)
    % muci, sigmaci:    ��������
    if nargin==1
        alpha = 0.05;
    end
    
    [muhat, sigmahat, muci, sigmaci] = normfit(data, alpha);
    
    figure;
    ye = linspace(0,1,length(data));
    scatter(data, ye, 5);
    data = sort(data);
    y = normpdf(data,muhat,sigmahat);
    hold on;
    plot(data, y);
    legend('Raw Data', 'Normal probability density function');
    xlabel('x');ylabel('ylabel');

    % ����ʹ��errorbar����ʾ�������䡣����:
    % y=[10 6 17 13 20]; e=[2 1.5 1 3 1]; errorbar(y,e);
end