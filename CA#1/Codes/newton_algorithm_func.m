function [xnew,f,Num_iteration] = newton_algorithm_func(Epsilon,x)
f_z = @(x,y) x.^4 + (y-1).^2;
f0 = @(x) f_z(x(1),x(2));
loop= 1;
xx=[0;1];
Num_iteration=0;
while (loop>0)
Num_iteration=Num_iteration+1;
g = [4*(x(1)^3) ; 2*(x(2)-1)]
d=-g;
H_matrix=[12*(x(1)^2) 0 ; 0  2]
x_new = x+inv(H_matrix)*d
if (norm(f0(x_new)-f0(xx))<Epsilon)
loop = 0;
else
x = x_new;
end 
end
f=f0(x_new);
xnew=x_new;
end







