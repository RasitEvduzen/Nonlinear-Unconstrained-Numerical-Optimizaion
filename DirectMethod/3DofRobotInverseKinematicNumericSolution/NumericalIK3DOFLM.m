clc,clear all,close all,warning off;
% 3DOF Robotic Arm Inverse Kinematics via Levenberg Marquardt
% 18-Mar-2024
% Written By Rasit.
%%  Numerical Inverse Kinematic Simulation
%---------------------- Robot DH Parameters ----------------------%
a2 = 100; a3 = 100; d1 = 100;   % Robot Link Lenght
a     = [0,0,a2,a3];
alpha = [0,90,0,90];
d     = [d1,0,0,0];

theta  = [0 90 90]';    % Home Pose [0 90 90] ->  XYZ [-100 0 200]
s = 10;  % Step Size
% TargetPoint = [100 150 200]';  % External Singularity
TargetPoint = [100 50 100]';



% 3Dof Robotic Arm Forward Kinematics
f = @(q,a2,a3,d1) [cosd(q(1))*(a3*cosd(q(2)+q(3))+a2*cosd(q(2)))
    sind(q(1))*(a3*cosd(q(2)+q(3))+a2*cosd(q(2)))
    d1 + a3*sind(q(2)+q(3))+a2*sind(q(2))];

initial_point = f(theta,a2,a3,d1);           % Calculate FK value

%  Jacobian Matrix
J = @(q,a2,a3,d1) [-sind(q(1))*(a3*cosd(q(2)+q(3))+a2*cosd(q(2))), -cosd(q(1))*(a3*sind(q(2)+q(3))+a2*sind(q(2))), -a3*sind(q(2)+q(3))*cosd(q(1))
    cosd(q(1))*(a3*cosd(q(2)+q(3))+a2*cosd(q(2))), -sind(q(1))*(a3*sind(q(2)+q(3))+a2*sind(q(2))), -a3*sind(q(2)+q(3))*sind(q(1))
    0,            a3*cosd(q(2)+q(3))+a2*cosd(q(2)),          a3*cosd(q(2)+q(3))];

X = [];   % Robot angle trajectory
Y = [];   % Robot end effector trajectory
EEPose = [];
figure('units','normalized','outerposition',[0 0 1 1],'color','w')
LC1 = 1;  % Loop Condition
nu = 1;

while LC1
    clf
    trplot(eye(4),'frame','Base','thick',1,'rgb','length',30), hold on, grid on
    axis equal,axis([-350 350 -350 350 0 350])
    view(10,20)  % First arguman is azimuth angle, second is elevation angle
    Tee = eye(4,4);
    theta_plot = [theta' 0];
    for i=1:size(theta_plot,2)
        temp = Tee;
        T(:,:,i) = DHMatrixModify(alpha(i),a(i),d(i),theta_plot(i));
        Tee = Tee * T(:,:,i);
        plot3([temp(1,4) Tee(1,4)],[temp(2,4) Tee(2,4)],[temp(3,4) Tee(3,4)],'k','LineWidth',1);
        xlabel('X-axis'),ylabel('Y-axis'),zlabel('Z-axis'),title('3DOF RRR Type Robot IK Solution Via Levenberg Marquardt')
        if i == 4
            trplot(Tee,'frame','EE',num2str(i),'thick',1,'rgb','length',30)
        else
            trplot(Tee,'frame',num2str(i),'thick',1,'rgb','length',30)
        end
    end

    % Optimization Algorithm Levenberg Marquardt
    y = f(theta,a2,a3,d1);             % Calculate FK value
    Jr = J(theta,a2,a3,d1);            % Calculate Jacobian
    e = [TargetPoint - y];             % Calculate Error
    f1 = e'*e;
    LC2 = 1;
    while LC2
        p = -inv(Jr'*Jr+nu*eye(size(theta,1)))*Jr'*e;
        f2 = (f(theta+p,a2,a3,d1) - f(theta,a2,a3,d1))'*(f(theta+p,a2,a3,d1) - f(theta,a2,a3,d1));
        if  f2 < f1
            theta = theta - s * p;
            nu = 0.1 * nu;
            LC2 = 0;
        else
            nu = 10 * nu;
            if nu > 1e+20
               LC1 = 0;
               LC2 = 0;
            end
        end
    end
    X = [X, theta];
    Y = [Y, y];
    plot3(Y(1,:),Y(2,:),Y(3,:),'r',LineWidth=3)
    scatter3(TargetPoint(1),TargetPoint(2),TargetPoint(3),"filled","k")
    scatter3(initial_point(1),initial_point(2),initial_point(3),"filled","k")
    drawnow
    if norm(e) < 1e-3
        break
    end

end
