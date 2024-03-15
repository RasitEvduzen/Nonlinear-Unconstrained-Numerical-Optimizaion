clc,clear all,close all;
%% Conjuge Gradient Descent ile fonk minimum noktasý bulma
Nmax = 500;
x = [-4.5; -3.5];
k = 0;
syms X1 X2

F = @(x) 3 + (x(1) - 1.5 * x(2))^2 + (x(2)-2)^2;
G = @(x) [2*(x(1)-1.5*x(2))
    -3*(x(1)-1.5*x(2))+2*(x(2)-2)];


g = 0;
X = [];
figure('units','normalized','outerposition',[0 0 1 1],'color','w')
while 1
    k = k + 1;
    f = F(x);
    g = G(x);

    if k == 1
        p = -g;
    else
        beta = (g'*g) / (gp'*gp);
        p = -g + beta *p;
    end

    s = GoldenSection(x,p);
    x = x + s*p;
    X = [X, x];
    gp = g;

    % Function Plot
    clf
    subplot(121)
    fsurf(F([X1,X2]), [-5 5 -5 5],'ShowContours','on','EdgeColor','none','FaceAlpha',.5),hold on,grid on
    xlabel("x1"),ylabel("x2"),zlabel("f(x1,x2)")
    scatter3(x(1),x(2),f,'filled','r')
    plot(X(1,:),X(2,:),'r')
    title("Conjugate-Gradient Descent")

    subplot(122)
    fcontour(F([X1,X2]), [-5 5 -5 5]),hold on,grid on
    plot(X(1,:),X(2,:),'r')
    scatter(X(1,1),X(2,1),'k','filled')
    scatter(X(1,end),X(2,end),'k','filled')
    title("Number of iteration-> "+num2str(k))

    drawnow
    %     fprintf('k:%4.0f\t s:%4.6f\t x1:%4.6f\t x2:%4.6f\t ||g||:%4.6f\t f(x):%4.6f\n',([k s x(1) x(2) norm(g) f]));
    if [k>= Nmax] | norm(g) < 1e-4;
        break
    end

end


