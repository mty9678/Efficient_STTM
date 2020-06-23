function Kernel_value = trial_KTT(X1,X2,Y1,Y2,Order);
% Y1, Y2 are matricized data_TT
% X1 and X2 are data_TT
%%
g = 1;
for k=1:Order
    r =  size(Y1{k}, 2); % r = r1*r2
    q =  size(Y2{k}, 2); % q = q1*q2
    r1 = size(X1{k}, 1);
    r2 = size(X1{k}, 3);
    q1 = size(X2{k}, 1);
    q2 = size(X2{k}, 3);
    for s = 1:r
        for t = 1:q  
            Kcore{k}(s,t)= exp(-norm(Y1{k}(:,s)-Y2{k}(:,t))^2/(2*g^2));
        end
    end
     K_tt{k} = reshape(Kcore{k}, r1,r2,q1,q2);
     K_tt{k} = permute(K_tt{k}, [1, 3, 2, 4]);
     K_tt{k} = reshape(K_tt{k},r1*q1,1,r2*q2);   
end
% this output goes to training of input data set into TrainAvgAcu
  Kernel_value = full(cell2core(tt_tensor, K_tt));
end