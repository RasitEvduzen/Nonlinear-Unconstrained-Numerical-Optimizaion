 function [s] = GoldenSection(x,p)

s_lower = 0;             
s_upper = 1;            

Ds = 1e-6;          
tau = 0.38197;      
eps = Ds/(s_upper-s_lower);     % Tolerance
N = ceil(-2.078*log(eps));  % Step Size


F = @(x) 3 + (x(1) - 1.5 * x(2))^2 + (x(2)-2)^2 ;

s1 = s_lower + tau*(s_upper-s_lower);
f1 =F(x+s1*p);
s2 = s_upper - tau*(s_upper-s_lower);
f2 = F(x+s2*p);
for k = 1:N
    
    if f1 > f2
        s_lower = s1;
        s1 = s2;
        f1 = f2;
        s2 = s_upper - tau*(s_upper-s_lower);
        f2 = F(x+s2*p);
    else
        s_upper = s2;
        s2 = s1;
        f2 = f1;
        s1 = s_lower + tau*(s_upper - s_lower);
        f1 = F(x+s1*p);
    end
end

s = mean([s1,s2]);






