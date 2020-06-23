function [ data_KerProTT ] = KerProTT( X, data_TT);
%Detailed explanation goes here
%% Input
% X: a N*1 cell array for storing tensor data
% data_TT: the TT decomposed data, here we use TT-Toolbox to get it
% Output: 2-mode matricized form of KTT
% This code is first part of algorithm in which we take either random or
% covariance kernel to project TT-cores.
N = length(X);
stdev = 1;
dims=size(X{1});
M = length(dims);
K =cell(M,1);
data_KerProTT = cell(N,1);

%% Matricization of data_TT to get Kernel form
for i = 1:M
  for j = 1:N
    data_TT2{j,1}{i,1} = my_matricization(data_TT{j,1}{i,1},2);
    end
end
%% Four methods for defining common matrices
%% Random normalized method
% for i = 1:M
%     K_temp = randn(dims(i),dims(i)) * stdev;
%     K_temp = K_temp * diag(sqrt(1 ./ (sum(K_temp.^2) + 1e-6)));
%     K{i,1} = K_temp * K_temp';
% end
%% Gaussian kernel method 
% for i = 1:M
%     K_temp = zeros(randn(dims(i),dims(i)));
%     for j = 1:N
%          K_temp =  K_temp + gauss(data_TT2{j,1}{i,1}.');
%     end
%     K{i,1} = K_temp./N;
% end
%% Covariance method
for i = 1:M
    K_temp = zeros(dims(i),dims(i));
    for j = 1:N
         K_temp =  K_temp + cov(data_TT2{j,1}{i,1}');
    end
    K{i,1} = K_temp./N;
end
%% Inverse TT approximation
for i = 1:M
     % K{i,1} = randn(dims(i),dims(i))*randn(dims(i),dims(i))' * stdev;
     K{i,1} = eye(dims(i)); % identity kernel
     for j=1:N
      data_KerProTT{j,1}{i,1} = pinv(K{i,1})* data_TT2{j,1}{i,1};  
     end
end

end

function flatten_matrix = my_matricization(X,md)
dims = size(X);
n_dim = length(dims);
[dimseq_without_i,dimseq_first_i] = dimseq(n_dim,md);
flatten_matrix = permute(X,dimseq_first_i);
flatten_matrix = reshape(flatten_matrix, dims(md),prod(dims(dimseq_without_i)));
end

function [dimseq_without_i,dimseq_first_i] = dimseq(n_dim,i)
if i == 1
    dimseq_without_i = [i+1:n_dim];
    dimseq_first_i = [1:n_dim];
else if i == n_dim
        dimseq_without_i = [1:i-1];
        dimseq_first_i = [i,1:i-1];
    else
        
        dimseq_without_i = [1:i-1,i+1:n_dim];
        dimseq_first_i = [i,1:i-1,i+1:n_dim];
    end
end
end
