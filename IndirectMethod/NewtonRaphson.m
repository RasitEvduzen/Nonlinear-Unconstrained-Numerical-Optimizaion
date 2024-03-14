% Newton Raphson 1D Optimization Problem
% 02-Feb-2024
% Written By: Rasit Evduzen
clc,clear all,close all;
%%

x_ini = -5;
x = -abs(x_ini)-2:1e-2:abs(x_ini)+2;

% y = @(x) x.^2;
% ydot = @(x) 2*x;
% yddot = @(x) 2;

y = @(x) x.^3 + 4*x.^2 - 7*x+6;
ydot = @(x) 3*x.^2 + 8*x - 7;
yddot = @(x) 6*x + 8;

figure('units','normalized','color','w')
gif('Newton.gif')
for i = 1: 1e6
    clf
    plot(x,y(x)),grid on, hold on
    plot(x,ydot(x),"b--")
    title(["Number of Iteration: "+num2str(i-1); "Funtion Value: "+num2str(y(x_ini))])
    scatter(x_ini,y(x_ini),"r","filled");
    scatter(x_ini,ydot(x_ini),"r","filled");
    xline(x_ini,"k")
    drawnow
    gif
    deltaX = - (ydot(x_ini)) / (yddot(x_ini));
    x_ini = x_ini + deltaX;

    if abs(ydot(x_ini + deltaX)) <= eps
        break
    end
end


