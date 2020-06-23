function [ data_CP ] = CP( X, R);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% Input
% X: a n*1 cell array for storing third-order tensor data
% R: the rank of CP decomposition

n = length(X);
%% Decompose the input data with CP factorization
addpath('.\cp3_alsls');
data_CP=cell(n,1);                                                            % Save CP factorization results
fprintf('Decomposing the input data with CP factorization, please wait!\n');
for i=1:n
    [A,B,C,~,~]=cp3_alsls(X{i,1},R);
    data_CP{i,1}=cell(3,1);
    data_CP{i,1}{1,1}=A;
    data_CP{i,1}{2,1}=B;
    data_CP{i,1}{3,1}=C;
end
clear A B C