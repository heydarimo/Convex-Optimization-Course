function [xnew,f,alpha_armijo,Num_iteration] = back_tracking_func(alpha,Beta,Epsilon,x)
t=1;
f_z = @(x,y) x.^4 + (y-1).^2;
f0 = @(x) f_z(x(1),x(2));
g = [4*(x(1)^3) ; 2*(x(2)-1)];
d=-g;
loop= 1;
Num_iteration=0;
while (loop>0)
Num_iteration=Num_iteration+1;
x_new = x+alpha.*d;
if (f0(x_new)<=f0(x)+Epsilon*alpha*g'*d)
loop = 0;
alpha_armijo = alpha;
else
alpha = alpha*Beta;
end 
end
f=f0(x_new);
xnew=x_new;
end







