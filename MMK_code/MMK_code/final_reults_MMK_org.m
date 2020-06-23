%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MMK Method results %%%%%%%%%%%%%%%%%%%%%%%%%%
datatype = 'adhd';

switch datatype
%% ADNI Dataset   
    case 'adni'
load('ADNI_first.mat')
n = size(X,1);
% eps = 0; % var1
%trunc = 2; % var2 : while fixing rank 
dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 25; %var3 % #repitition of whole procedure
global l

for l = 1:10 % var4
    
Data_CP  = CP(X,l);
% computing KCP of input tensor
% kerfilter = 'random'; %var4
% kerfilter = 'gauss';
% kerfilter = 'covariance';
 kerfilter = 'identity';
[data_KCP] = KCP(X, Data_CP, kerfilter);

% main results including training and testing
% MMK method
[CVofMMK_ADNI(l),TrainTimeofMMK_ADNI,TestTimeofMMK_ADNI] = Main_MMK(X,label,l,data_KCP,t);

end

 l = 1:1:10;
 save('CVofMMK_ADNI.mat', 'CVofMMK_ADNI')

idxmax2 = find(CVofMMK_ADNI == max(CVofMMK_ADNI));
plot(l,CVofMMK_ADNI, '-o','MarkerIndices', 1:1:length(l), 'MarkerIndices', [idxmax2],...
    'MarkerFaceColor', 'red',...
    'LineWidth',2,...
    'MarkerSize', 5)

%% ADHD dataset
    case 'adhd'
load('ADHD_mainset.mat');
% n = size(X,1);
% eps = 0; % var1
%trunc = 2; % var2 : while fixing rank 
dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 25; %var3 % #repitition of whole procedure
global l

for l = 1:10 % var4
    
Data_CP  = CP(X,l);
% computing KCP of input tensor
% kerfilter = 'random'; %var4
% kerfilter = 'gauss';
% kerfilter = 'covariance';
 kerfilter = 'identity';
[data_KCP] = KCP(X, Data_CP, kerfilter);
% main results including training and testing
% MMK method
[CVofMMK_ADHD(l),TrainTimeofMMK_ADHD,TestTimeofMMK_ADHD] = Main_MMK(X,label,l,data_KCP,t);

end
return
 l = 1:1:10;
 save('CVofMMK_ADHD.mat', 'CVofMMK_ADHD')

idxmax2 = find(CVofMMK_ADHD == max(CVofMMK_ADHD));
plot(l,CVofMMK_ADHD, '-o','MarkerIndices', 1:1:length(l), 'MarkerIndices', [idxmax2],...
    'MarkerFaceColor', 'red',...
    'LineWidth',2,...
    'MarkerSize', 5)
end