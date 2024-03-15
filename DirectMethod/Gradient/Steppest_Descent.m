% Gradient Descent Algorithm
% Written By: Rasit
% 15-Mar-2024
clc,clear all,close all;
%% Steppest Descent
Nmax = 500;  % Max Step
x = [-4.5 -3.5]';  % Initial Condition
k = 0; % Loop Count
syms X1 X2


F = @(x) 3 + (x(1) - 1.5 * x(2))^2 + (x(2)-2)^2;
G = @(x) [2*(x(1)-1.5*x(2))
    -3*(x(1)-1.5*x(2))+2*(x(2)-2)];

X = [];
figure('units','normalized','outerposition',[0 0 1 1],'color','w')
while 1
    k = k + 1;

    f = F(x);
    p = -G(x);
    s = GoldenSection(x,p)
    x = x + s*p;   % Parameter Update
    X = [X, x];

    % Function Plot
    clf
    subplot(121)
    fsurf(F([X1,X2]), [-5 5 -5 5],'ShowContours','on','EdgeColor','none','FaceAlpha',.5),hold on,grid on
    xlabel("x1"),ylabel("x2"),zlabel("f(x1,x2)")
    scatter3(x(1),x(2),f,'filled','r')
    plot(X(1,:),X(2,:),'r')
    title("Gradient Descent")

    subplot(122)
    fcontour(F([X1,X2]), [-5 5 -5 5]),hold on,grid on
    plot(X(1,:),X(2,:),'r')
    scatter(X(1,1),X(2,1),'k','filled')
    scatter(X(1,end),X(2,end),'k','filled')
    title("Number of iteration-> "+num2str(k))

    drawnow
    %     fprintf('k:%4.0f\t s:%4.6f\t x1:%4.6f\t x2:%4.6f\t ||g||:%4.6f\t f(x):%4.6f\n',([k s x(1) x(2) norm(p) f]));
    if [k>= Nmax] | norm(p) < 1e-6
        break
    end

end



