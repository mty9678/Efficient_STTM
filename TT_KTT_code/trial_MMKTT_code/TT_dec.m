function [ data_TT , Rank, pos] = TT_dec(X,l)
%% Input
% X: a N*1 cell array for storing third-order tensor data
% output: TT decomposition of data
%         Rank corresponds to TT-decomposition
%         position of each TT-core (edit ps for more info)
%         Each TT-core
%% Task 1 : Getting compact representation of input data in TT form
N = length(X);
% l is rank truncation 
% eps = 1e-14;
%% Decompose the input data with TT decomposition
addpath('..\..\TT-Toolbox-master');
data_TT=cell(N,1);                                                % Save TT decomposition results
R = cell(1,N);
core = cell(N,1);
posi = cell(1,N);
fprintf('Decomposing the input data with TT decomposition, please wait!\n');
for i=1:N
    tt = tt_tensor(X{i},0); % tt- decomposition of each cell tensor
    tt_round = round(tt,0,l); % rounding of rank to l
    G = core2cell(tt_round); 
    data_TT{i}=cell(3,1);
    data_TT{i}{1}=G{1};
    data_TT{i}{2}=G{2};
    data_TT{i}{3}=G{3}; % G are the tt-cores  
end
Rank = tt_round.r;
pos = tt_round.ps; % pos is a matrix with position of tt-core(each row is for each tensor)
clear G
end