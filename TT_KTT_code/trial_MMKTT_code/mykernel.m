function G = mykernel(U,V)
% global rankofx
% r{1} = rankofx{1};

 %G = U*V'; linear kernel
 n = size(U,1);
 m = size(V,1);
 for i = 1:n
     for j = 1:m
      G(i,j) = exp (-norm(U(i,:)-V(j,:))^.2/2);
     end
 end
 end