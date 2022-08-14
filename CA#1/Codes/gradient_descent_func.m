function [Target_xvalue,yvalue_optimal,iterations_Num,gnorm] = gradient_descent_func(x0,Epsilon,alpha)
gnorm = inf;
x = x0; 
f = @(x,y) x.^4 + (y-1).^2;
figure(2); 
clf; 
fcontour(f,[-15 15 -15 15]); 
axis equal; 
hold on
f2 = @(x) f(x(1),x(2));
iterations_Num=0;
while (gnorm>=Epsilon)
g = [4*(x(1)^3) ; 2*(x(2)-1)];
gnorm = norm(g)
direction=-g;
xnew = x + alpha*direction;  
plot([x(1) xnew(1)],[x(2) xnew(2)],'ko-')
refresh
iterations_Num = iterations_Num + 1;
dx = norm(xnew-x);
x = xnew; 
iterations_Num=iterations_Num+1;
end
Target_xvalue = x;
yvalue_optimal = f2(Target_xvalue);
end










