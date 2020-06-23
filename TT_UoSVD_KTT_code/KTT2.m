function [ data_KTT2 ] = KTT2( X, data_TT,kerfilter);
%Detailed explanation goes here
%% Input
% X: a n*1 cell array for storing tensor data
% data_TT: the TT decomposed data, here we use TT-Toolbox to get it.
% 2-mode matricized form of KTT
% This code is first part of algorithm in which we take either random or
% covariance kernel to project TT-cores.
n = length(X);
stdev = 1;
dimn=size(X{1});
m = length(dimn);
K =cell(m,1);
data_KTT2 = cell(n,1);

%% Matricization of data_TT to get Kernel form
for i = 1:m
    for j = 1:n
        data_TT2{j,1}{i,1} = my_matricization(data_TT{j,1}{i,1},2);
    end
end
%% Four methods for defining common matrices
switch kerfilter

% Random normalized method
    case 'normalize'
 for i = 1:m
     K_temp = randn(dimn(i),dimn(i)) * stdev;
     K_temp = K_temp * diag(sqrt(1 ./ (sum(K_temp.^2) + 1e-6)));
     K{i,1} = K_temp * K_temp';
   % invK{i,1} = inv(K{i,1});
         for j=1:n
             data_KTT2{j,1}{i,1} = K{i,1}\data_TT2{j,1}{i,1};  
         end
 end
 
% Gaussian kernel method 
    case 'gauss'
 for i = 1:m
 K_temp = zeros(randn(dimn(i),dimn(i)));
    for j = 1:n
         K_temp =  K_temp + gauss(data_TT2{j,1}{i,1}.');
    end
    K{i,1} = K_temp./n;
    %invK{i,1} = inv(K{i,1});
    for j=1:N
        data_KTT2{j,1}{i,1} = K{i,1}\data_TT2{j,1}{i,1};  
    end
 end

 
 % Covariance method
    case 'covariance'
for i = 1:m
    K_temp = zeros(dimn(i),dimn(i));
    for j = 1:n
         K_temp =  K_temp + cov(data_TT2{j,1}{i,1}');
    end
    K{i,1} = K_temp./n;
    for j=1:n
        data_KTT2{j,1}{i,1} = K{i,1}\data_TT2{j,1}{i,1};  
    end
end


% Inverse TT approximation
    case 'identity'
for i = 1:m
     K{i,1} = eye(dimn(i));
     for j=1:n
      data_KTT2{j,1}{i,1} = pinv(K{i,1})* data_TT2{j,1}{i,1};  
     end
end

% random kernel filtering 
    case 'random'
for i = 1:m
    K{i,1} = randn(dimn(i),dimn(i))*randn(dimn(i),dimn(i))' * stdev;
%     invK{i,1} = inv(K{i,1});
    for j=1:n
        data_KTT2{j,1}{i,1} = K{i,1}\data_TT2{j,1}{i,1};  
    end
end 

end %end for switch function
end