function Ker = kernel_TT(U,V, Order, g)
%% This function is for computing kernel for fitcsvm
% Input: data_train and data_test, input in fitcsvm
% Output: Kernel, which directly will be used inside the fitcsvm
% global * defines some global variables

%Ker = U*V';
%return;

%% One way of computing kernel
global pos
%global log2g
global R
%global dims
%global Order
n = size(U,1);
m = size(V,1);
u = cell(3,1);
v = cell(3,1);
Ker = zeros(n,m);
 for i = 1:n
     for j = 1:m
         for k = 1:Order
             f1 = pos(k):(pos(k+1)-1);
             u{k} = reshape(U(i,f1), [R(k),dims(k),R(k+1)]);
             u{k} = permute(u{k},[1,3,2]);
             u{k} = reshape(u{k}, [R(k)*R(k+1),dims(k)]);
             v{k} = reshape(V(j,f1), [R(k),dims(k),R(k+1)]);
             v{k} = permute(v{k},[2,1,3]);
             v{k} = reshape(v{k}, [dims(k),R(k)*R(k+1)]);
             sum = 0;
             for a = 1:dims(k)
             sum = sum+ (u{k}(:,a)-v{k}(a,:)).^2;
             end
             K_tt{k} = exp(-sum/(2*4^log2g));
             K_tt{k} = reshape(K_tt{k}, R(k),R(k+1),R(k),R(k+1));
             K_tt{k} = permute(K_tt{k}, [1, 3, 2, 4]);
             K_tt{k} = reshape(K_tt{k},R(k)*R(k),1,R(k+1)*R(k+1));  
         end
         Ker(i,j) = full(cell2core(tt_tensor, K_tt));
     end
 end    
end