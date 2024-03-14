% Bisection Method 1D Optimization Problem
% 05-Feb-2024
% Written By: Rasit Evduzen
clc,clear all,close all;
%%
x_lower = -5;
x_upper = -1;
x = -abs(max(abs(x_lower),abs(x_upper)))-2:1e-2:abs(max(abs(x_lower),abs(x_upper)))+2;


y = @(x) x.^3 + 4*x.^2 - 7*x+6;
ydot = @(x) 3*x.^2 + 8*x - 7;
yddot = @(x) 6*x + 8;
if ydot(x_lower) * ydot(x_upper) > 0
    return
end

figure('units','normalized','color','w')
for i = 1: 1e6
    xk = x_lower + ((x_upper - x_lower) / 2);
    if (x_upper - x_lower) <= 1e-4
        break
    else
        if ydot(xk) * ydot(x_lower) > 0
            x_lower = xk;
        else
            x_upper = xk;
        end
    end
    clf
    plot(x,y(x)),grid on, hold on
    title(["Number of Iteration: "+num2str(i-1); "Funtion Value: "+num2str(y(xk))])
    scatter(x_lower,y(x_lower),"r","filled");
    scatter(x_upper,y(x_upper),"r","filled");
    xline(x_lower,"k")
    xline(x_upper,"k")
    drawnow
end


