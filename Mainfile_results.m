%%%% This is the main file for producing all the results %%%%
% This work is submitted to ICML 2020 for review. The codes are 
% for the
% "Efficient Structure-preserving Support Tensor Train Machine"

% Step 1. Setup the TT toolbox
% Step 2. run make file in matlab folder in libsvm-master
% Add complete folder and subfolders into path
%%%%%%%%%%%%%%%%%%%%%% DATA1: ADNI %%%%%%%%%%%%%%%%%%%%%%%%%%
 datatype = 'adni';
% datatype = 'adhd';

switch datatype
%% ADNI dataset
    case 'adni'
% loading ADNi data file
load('ADNI_first.mat')
n = size(X,1);

% Computing TT decomposition
eps = 0; 
trunc = 2; % while fixing rank 
dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 1; % number of repitition of whole procedure
global l % the rank has been defined as a global variable
for l = 1:10 
[data_TT,~] = TT_dec(X,l,eps); %TT factorization of input 


% merging index r1 and r2 into r = r1+(r2-1)*R1
R1 =  l;
R2 = l;
[TT_CP_data] = ttcptensor(data_TT,R1,R2,dimn,trunc);

% switching kernel filtering over tensor factorization
% kerfilter = 'random'; 
% kerfilter = 'gauss';
% kerfilter = 'covariance';
 kerfilter = 'identity';
 
% computing KTT of input tensor
[data_KTTCP] = KTTCP(X, TT_CP_data, kerfilter);

% main results including training and testing
[CVofTTCP_ADNI(l),trainTIMEofTTCP_ADNI,testTIMEofTTCP_ADNI] = KTTCPMain_lib(X,label,l,data_KTTCP,t);

end

l = 1:1:10;
save('CVofTTCP_ADNI.mat','CVofTTCP_ADNI') % mat file for accuracy output
idxmax1 = find(CVofTTCP_ADNI == max(CVofTTCP_ADNI)); % maximum accuracy
% plotting accuracy vs TT rank
plot(l,CVofTTCP_ADNI, '--s',...
    'MarkerIndices',1:1:length(l),...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerFaceColor',[0.5,0.5,0.5],...
    'MarkerEdgeColor','b',...
    'MarkerIndices',[idxmax1],...
    'MarkerFaceColor','red',...
    'MarkerSize', 5)

%%
%%%%%%%%%%%%%%%%%%%%%% DATA2: ADHD %%%%%%%%%%%%%%%%%%%%%%%%%%

%% ADHD dataset
    case 'adhd'
load('ADHD_mainset.mat');
n = size(X,1);

% Computing TT decomposition
eps = 0; 
trunc = 2; % while fixing rank 
dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 1; % number of repitition of whole procedure
global l % the rank has been defined as a global variable
for l = 1:10
[data_TT,~] = TT_dec(X,l,eps); %TT factorization of input 


% merging index r1 and r2 into r = r1+(r2-1)*R1
R1 =  l;
R2 = l;
[TT_CP_data] = ttcptensor(data_TT,R1,R2,dimn,trunc);

% switching kernel filtering over tensor factorization
% kerfilter = 'random'; 
% kerfilter = 'gauss';
% kerfilter = 'covariance';
 kerfilter = 'identity';
 
% computing KTT of input tensor
[data_KTTCP] = KTTCP(X, TT_CP_data, kerfilter);


% main results including training and testing
[CVofTTCP_ADHD(l),trainTIMEofTTCP_ADHD,testTIMEofTTCP_ADHD] = KTTCPMain_lib(X,label,l,data_KTTCP,t);

end

l = 1:1:10;
save('CVofTTCP_ADHD.mat','CVofTTCP_ADHD') % saving accuracy mat file
idxmax1 = find(CVofTTCP_ADHD == max(CVofTTCP_ADHD)); % maximum accuracy
% plotting accuracy vs TT rank
plot(l,CVofTTCP_ADHD, '--s',...
    'MarkerIndices',1:1:length(l),...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerFaceColor',[0.5,0.5,0.5],...
    'MarkerEdgeColor','b',...
    'MarkerIndices',[idxmax1],...
    'MarkerFaceColor','red',...
    'MarkerSize', 5)
%%
end % end for switch function




