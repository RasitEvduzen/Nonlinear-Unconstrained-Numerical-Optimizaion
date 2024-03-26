% Golden Section Algorithm Optimization
% 07-Feb-2024
% Written By: Rasit
%%
clc,clear all,close all;

x_l = 1;              % Initial Condition
x_u = 5;              % Initial Condition
dx = 1e-10;           % Accuracy Value
tau = 0.38197;        % 2- golden ratio
eps = dx/(x_u-x_l);               % Tolerance Value
N = floor(-2.078*log(eps));       % Number Of Step

f = @(x) x .* exp(-x) + cos(x);   % Objective Function
t_span = -(abs(x_l)+.5):1e-2:(abs(x_u)+.5);
figure('units','normalized','outerposition',[0 0 1 1],'color','w')
for k = 1:N
    clf
    plot(t_span,f(t_span),"b"),grid on, hold on
    scatter(x_l,f(x_l),"filled","r")
    scatter(x_u,f(x_u),"filled","r")
    xline(x_l,"k")
    xline(x_u,"k")
    title(["Lower Point: " + num2str(x_l) "Upper Point: " + num2str(x_u) "Difference: " num2str(abs(x_l - x_u))]);

    x1 = x_l + tau*(x_u-x_l);
    f1 = f(x1);
    x2 = x_u - tau*(x_u-x_l);
    f2 = f(x2);

    if f1 > f2
        x_l = x1;
        x1 = x2;
        f1 = f2;
    else
        x_u = x2;
        x2 = x1;
        f2 = f1;
        x1 = x_l + tau*(x_u - x_l);
        f1 = f(x1);
    end
    drawnow
end








