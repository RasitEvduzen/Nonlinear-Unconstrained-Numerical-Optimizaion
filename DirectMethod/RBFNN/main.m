clc,close,clear all;
% RBF Model Fitting via Nonlinear Optimization 
% Single Input Single Output 1 Neuron RBF Neural Network
% Written By: Rasit Evduzen
% 08-Apr-2024
%% Generate Data
Ts = 1e-2;
tspan = (-3:Ts:3)';  % Input Data
weight = 2*rand-1; % Trainable Parameter
center = 2*rand-1; % Trainable Parameter
sigma = rand-.5; % Trainable Parameter

func = @(w1,w2,w3,x) w1*exp(-(x + w2).^2/(w3^2));  % Rbf Function!
y = func(weight,center,sigma,tspan);  % Output Data

Jacobian = @(w1,w2,w3,x) [ -exp(-(w2 + x).^2/w3^2),...
                           (w1*exp(-(w2 + x).^2/w3^2).*(2*w2 + 2*x))/w3^2,...
                          -(2*w1*exp(-(w2 + x).^2/w3^2).*(w2 + x).^2)/w3^3];  % Function Jacobian!

% GO GO GO Optimization!!!

x = .5*rand(3,1);  % Start Random Parameter
Xparam = [];    % Param Vector
Error = [];
s = 5e-4;       % Step Size
LoopCount = 1;
while 1
    LoopCount = LoopCount + 1;
    
    f = func(x(1),x(2),x(3),tspan);
    e = y - f; % Error 
    p = -Jacobian(x(1),x(2),x(3),tspan); % Negative Gradient Direction
    x = x + s*p'*e;   % Parameter Update
    Xparam = [Xparam, x];
    Error = [Error, norm(e)];
    display("||error||: "+num2str(norm(e)))
    if norm(e) < 1e-2
        break
    end
end

%% Plot Result
figure('units','normalized','outerposition',[0 0 1 1],'color','w')
for i =1:10:LoopCount-1
    clf
    subplot(211)
    scatter(tspan,y,"ro"),hold on,grid on
    plot(tspan,func(Xparam(1,i),Xparam(2,i),Xparam(3,i),tspan),'k',LineWidth=2)
    title(["RBF Function Nonlinear Optimization via Gradient Descent"; "||Error|| -> "+num2str(Error(i))])

    subplot(212)
    yline(weight,"r",LineWidth=2),hold on,grid on
    yline(center,"r",LineWidth=2)
    yline(sigma,"r",LineWidth=2)
    plot(Xparam(1,1:i),'k--',LineWidth=2)
    plot(Xparam(2,1:i),'k--',LineWidth=2)
    plot(Xparam(3,1:i),'k--',LineWidth=2)
    title(["Parameters"; "Number of iteration-> "+num2str(i)])
    
    drawnow
end