function splineplot(x, y, xx)
    % ������ֵ
    % x,y:  ���ݵ�
    % xx:   ��ֵ��Χ
    if nargin==2
       xx = linspace(min(x),max(x),7*length(x));
    end
    
    yy = spline(x,y,xx);
    plot(x,y,'o',xx,yy);
    title('spline');xlabel('x');ylabel('y');
end