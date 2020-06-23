function [ data_KTT2 ] = KTT2( X, data_TT, kerfilter);
%Detailed explanation goes here
%% Input
% X: a N*1 cell array for storing tensor data
% data_TT: the TT decomposed data, here we use TT-Toolbox to get it
% Output: 2-mode matricized form of KTT
% This code is first part of algorithm in which we take either random or
% covariance kernel to project TT-cores.
N = length(X);
stdev = 1;
dims=cellfun(@(t)size(t, 2), data_TT{1});
M = length(dims);
K =cell(M,1);
data_KTT2 = cell(N,1);

%% Matricization of data_TT to get Kernel form
for i = 1:M
  for j = 1:N
    data_KTT2{j,1}{i,1} = my_matricization(data_TT{j,1}{i,1},2);
  end
end
%%
switch kerfilter
% Four methods for defining common matrices
% Random normalized method
    case 'random'
for i = 1:M
    K_temp = randn(dims(i),dims(i)) * stdev;
    K_temp = K_temp * diag(sqrt(1 ./ (sum(K_temp.^2) + 1e-6)));
    K{i,1} = K_temp * K_temp';
end
% Gaussian kernel method 
    case 'gauss'
for i = 1:M
    K_temp = zeros(randn(dims(i),dims(i)));
    for j = 1:N
         K_temp =  K_temp + gauss(data_TT2{j,1}{i,1}.');
    end
    K{i,1} = K_temp./N;
end
% Covariance method
    case 'covariance'
for i = 1:M
    K_temp = zeros(dims(i),dims(i));
    for j = 1:N
         K_temp =  K_temp + cov(data_TT2{j,1}{i,1}');
    end
    K{i,1} = K_temp./N;
end
% Inverse TT approximation
    case 'identity'
for i = 1:M
     % K{i,1} = randn(dims(i),dims(i))*randn(dims(i),dims(i))' * stdev;
     K{i,1} = eye(dims(i));
     for j=1:N
      data_KTT2{j,1}{i,1} = pinv(K{i,1})* data_KTT2{j,1}{i,1};  
     end
end

end

