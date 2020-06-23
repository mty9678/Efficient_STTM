%%%%%%%%%%%%%%%%%%%%%%%%%% SVM results with cross validation %%%%%%%%%%%%%%
datatype = 'adhd';
switch  datatype
%% ADNI dataset
    case 'adni'
load('ADNI_first.mat')

n = size(X,1);
% eps = 0; % var1
%trunc = 2; % var2 : while fixing rank 
dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 1; %var3 % #repitition of whole procedure
global l 
for l = 1:10 % var4

% main results including training and testing
% SVM
[CVofSVM_ADNI(l),TrainTimeofSVM_ADNI,TestTimeofSVM_ADNI] = SVMmain(X,label,t);

end

l = 1:1:10;
save('CVofSVM_ADNI.mat','CVofSVM_ADNI')
idxmax1 = find(CVofSVM_ADNI == max(CVofSVM_ADNI));
plot(l,CVofSVM_ADNI, '--s',...
    'MarkerIndices',1:1:length(l),...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerFaceColor',[0.5,0.5,0.5],...
    'MarkerEdgeColor','b',...
    'MarkerIndices',[idxmax1],...
    'MarkerFaceColor','red',...
    'MarkerSize', 5)

%% ADHD dataset
    case 'adhd'
load('ADHD200.mat')
X = X_adhd;
label = label_adhd;
n = size(X,1);

% eps = 0; % var1
%trunc = 2; % var2 : while fixing rank 
dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 1; %var3 % #repitition of whole procedure
global l 
for l = 1:10 % var4

% main results including training and testing
% SVM
[CVofSVM_ADHD(l),TrainTimeofSVM_ADHD,TestTimeofSVM_ADHD] = SVMmain(X,label,t);

end

l = 1:1:10;
save('CVofSVM_ADHD.mat','CVofSVM_ADHD')
idxmax1 = find(CVofSVM_ADHD == max(CVofSVM_ADHD));
plot(l,CVofSVM_ADHD, '--s',...
    'MarkerIndices',1:1:length(l),...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerFaceColor',[0.5,0.5,0.5],...
    'MarkerEdgeColor','b',...
    'MarkerIndices',[idxmax1],...
    'MarkerFaceColor','red',...
    'MarkerSize', 5)
end