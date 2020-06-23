function [data_gaussTT] = KTT(data_KerProTT, data_TT)
% It gives tensor form of KTT
% the dimensions are same as TT-core of input tensor
N = length(data_TT);
data_gaussTT = cell(N,1);
data_gaussTT = my_tensorisation(data_KerProTT,data_TT,2);
end

function [tensor_form] = my_tensorisation(Y,data_TT,mode)
% dims should be size of original tensor train core
N = length(Y);
M = 3;
for i = 1:N
    for j = 1:M
%       dmns{i}{j} = size(data_TT{i}{j});
        r1 = size(data_TT{i}{j}, 1);
        n = size(data_TT{i}{j}, 2);
        r2 = size(data_TT{i}{j}, 3);
        n_dim = 3; %length of a size of a TT-core
        tensor_form{i}{j} = reshape(Y{i}{j}, n, r1, r2);
        tensor_form{i}{j} = permute(tensor_form{i}{j}, [2,1,3]);
    end
end
end

