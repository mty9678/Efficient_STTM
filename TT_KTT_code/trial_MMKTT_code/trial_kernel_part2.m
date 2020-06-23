function Ker = trial_kernel_part2(U,V)
%% This function defines the second way of computing kernel for fitcsvm
% Input: data_train and data_test, input in fitcsvm
% Output: Kernel, which directly will be used inside the fitcsvm
% global * defines some global variables

%% One way of computing kernel
global pos
global log2g
global R
global dims
global Order
n = size(U,1);
m = size(V,1);
u_tt = cell(3,1);
v_tt = cell(3,1);
Ker = zeros(n,m);
 for i = 1:n
     for j = 1:m
         for k = 1:Order
             f1 = pos(k):(pos(k+1)-1);
             u_tt{k} = reshape(U(i,f1), [R(k),dims(k),R(k+1)]);
             v_tt{k} = reshape(V(j,f1), [R(k),dims(k),R(k+1)]);
         end
             u_tt = cell2core(tt_tensor, u_tt);
             v_tt = cell2core(tt_tensor, v_tt);
             Ker(i,j) = exp(-norm((u_tt-v_tt).^2)/2^log2g);
             % Here we can also write polynomial function at the place of
             % gaussian
     end
 end    
end
