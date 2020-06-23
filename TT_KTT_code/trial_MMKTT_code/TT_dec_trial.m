function [ data_TT , Rank] = TT_dec_trial(X,l,eps)

%% Input
% X: a N*1 cell array for storing third-order tensor data
% l: rank truncation 
% output: TT decomposition of data,
%         Rank corresponds to TT-decomposition.
%% Task : Getting compact representation of input data in TT form
N = length(X);

%% Decompose the input data with TT decomposition
addpath('TT-Toolbox-master');
data_TT=cell(N,1);                                                % Save TT decomposition results
Rank = cell(N,1);
%core = cell(N,1);
%posi = cell(1,N);
% Y_tt_trunc = cell(N,1);
% Y_tt = cell(N,1);
fprintf('Decomposing the input data with TT decomposition, please wait!\n');
for i=1:N
    %Xi = X{i};
    %Xi = Xi(:,1:72,:);
    %Xi = reshape(Xi, size(Xi,1)*8, []);
    %tt = tt_tensor(Xi,0); % tt- decomposition of each cell tensor
    tt = tt_tensor(X{i},eps); % tt- decomposition of each cell tensor
%    tt_round = round(tt,eps);
    tt_round = round(tt,eps,l); % rounding of rank to l
%     Y_tt_trunc{i,1} = full(tt_round,size(X{i}));
%     Y_tt{i,1} = full(tt,size(X{i}));
    G = core2cell(tt_round); 
    data_TT{i}=cell(3,1);
    data_TT{i}{1}=G{1};
    data_TT{i}{2}=G{2};
    data_TT{i}{3}=G{3}; % G are the tt-cores 
    Rank{i} = tt_round.r;
end
%pos = tt_round.ps; % pos is a matrix with position of tt-core(each row is for each tensor)
clear G
end