
lamp_data = data_func();    % Loading our data

% method 1: equal lamp powers

[n,m]=size(lamp_data);
point_Num=1000;
p = logspace(-3,0,point_Num);
f = zeros(size(p));
for k=1:point_Num
f(k) = max(abs(log(lamp_data*p(k)*ones(m,1))));
end
[value_method1,idx] = min(f);
p_state1 = p(idx)*ones(m,1);


% method 2: least-squares with rounding


p_state2 = lamp_data\ones(n,1);
p_state2 = max(p_state2,0);                          % rounding negative p_i to 0
p_state2 = min(p_state2,1);                          % rounding p_i > 1 to 1
value_method2 = max(abs(log(lamp_data*p_state2)));


% method 3: Weighted least-squares:



p_state3 = [lamp_data; eye(m)]\[ones(n,1); 0.5*ones(m,1)];
p_state3 = max(p_state3,0);                          % rounding negative p_i to 0
p_state3 = min(p_state3,1);                          % rounding p_i > 1 to 1              
value_method3 = max(abs(log(lamp_data*p_state3)));


% method 4: chebyshev approximation


cvx_begin
variable p_state4(m)
minimize(norm(lamp_data*p_state4-1, inf))
subject to
p_state4 >= 0
p_state4 <= 1
cvx_end
value_method4 = max(abs(log(lamp_data*p_state4)));

% method 5: Piecewise-linear approximation

H_new=@(u) max([ u , 2/0.5 - u/(0.5)^2 , 2/0.8-u/(0.8)^2 , 2-u]);   

cvx_begin
variable p_state5(m)
minimize(max(H_new(lamp_data*p_state5)))
subject to
p_state5 >= 0
p_state5 <= 1
cvx_end

value_method5 = max(abs(log(lamp_data*p_state5)));


% exact solution:


cvx_begin
variable p_exact(m)
minimize(max([lamp_data*p_exact; inv_pos(lamp_data*p_exact)]))
subject to
p_exact >= 0
p_exact <= 1
cvx_end
value_exact = max(abs(log(lamp_data*p_exact)));

% Results

[p_state1 p_state2 p_state3 p_state4 p_state5 p_exact]
[value_method1 value_method2 value_method3 value_method4 value_method5 value_exact]
