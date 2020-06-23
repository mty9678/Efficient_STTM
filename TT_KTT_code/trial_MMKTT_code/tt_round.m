clear all;
clc;

eps = 0;
X = rand(3,4,5);
tt = tt_tensor(X);
tr = round(tt,eps);
