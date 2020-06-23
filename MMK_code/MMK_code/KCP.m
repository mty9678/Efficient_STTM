function [ data_KCP ] = KCP( X, data_CP, kerfilter);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% Input
% X: a n*1 cell array for storing tensor data
% data_CP: the CP decomposed data, here we use cp3_alsls to get it.

N = length(X);
stdev = 1;
dims=size(X{1});
M = length(dims);
K =cell(M,1);
invK = cell(M,1);
data_KCP = cell(N,1);

%% Three methods for defining the common matrices
switch kerfilter
    case 'normalized'
% Random normalized method
for i = 1:M
    K_temp = randn(dims(i),dims(i)) * stdev;
    K_temp = K_temp * diag(sqrt(1 ./ (sum(K_temp.^2) + 1e-6)));
    K{i,1} = K_temp * K_temp';
invK{i,1} = inv(K{i,1});
 for j=1:N
      data_KCP{j,1}{i,1} = invK{i,1} * data_CP{j,1}{i,1};  
    end
end
    case 'covariance'
% Covariance method 
for i = 1:M
    K_temp = randn(dims(i),dims(i));
    for j = 1:N
         K_temp =  K_temp + cov(data_CP{j,1}{i,1}');
    end
    K{i,1} = K_temp./N;
     invK{i,1} = inv(K{i,1});
    for j=1:N
      data_KCP{j,1}{i,1} = invK{i,1} * data_CP{j,1}{i,1};  
    end
end
    case 'random'
% Inverse CP approximation
for i = 1:M
    K{i,1} = randn(dims(i),dims(i))*randn(dims(i),dims(i))' * stdev;
    invK{i,1} = inv(K{i,1});
    for j=1:N
      data_KCP{j,1}{i,1} = invK{i,1} * data_CP{j,1}{i,1};  
    end
end
    case 'identity'
% Identity
for i = 1:M
    invK{i,1} = eye(dims(i));
    for j=1:N
      data_KCP{j,1}{i,1} = invK{i,1} * data_CP{j,1}{i,1};  
    end
end
end