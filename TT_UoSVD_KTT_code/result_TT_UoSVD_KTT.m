%%%% This is the file which produce KTT results (TT decomposiiton + kernel approximation)%%%%
%%%% along with the uniqueness of SVD constraint in the TT-toolbox %%%%

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
t = 10; % number of repitition of whole procedure
global l % the rank has been defined as a global variable
for l = 1:10 
[data_TT,~] = TT_dec(X,l,eps); %TT factorization of input 


% merging index r1 and r2 into r = r1+(r2-1)*R1
R1 =  l;
R2 = l;

% switching kernel filtering over tensor factorization
% kerfilter = 'random'; 
% kerfilter = 'gauss';
% kerfilter = 'covariance';
 kerfilter = 'identity';
 
% computing KTT of input tensor
[ data_KTT2 ] = KTT2( X, data_TT, kerfilter);

% main results including training and testing
[CVofKTT_UoSVD_ADNI_eye(l),trainTIMEofKTT_UoSVD_ADNI_eye,testTIMEofKTT_UoSVD_ADNI_eye] = KTTMain_lib(X,label,data_KTT2,data_TT,t);

end

l = 1:1:10;
save('CVofKTT_UoSVD_ADNI_rnd.mat','CVofKTT_UoSVD_ADNI_rnd') % mat file for accuracy output
idxmax1 = find(CVofKTT_UoSVD_ADNI_eye == max(CVofKTT_UoSVD_ADNI_eye)); % maximum accuracy
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
% plotting accuracy vs TT rank
plot(l,CVofKTT_UoSVD_ADNI_eye, '--s',...
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

% switching kernel filtering over tensor factorization
% kerfilter = 'random'; 
% kerfilter = 'gauss';
% kerfilter = 'covariance';
 kerfilter = 'identity';
 
% computing KTT of input tensor
[ data_KTT2 ] = KTT2( X, data_TT, kerfilter);

% main results including training and testing
[CVofKTT_UoSVD_ADHD(l),trainTIMEofKTT_UoSVD_ADHD,testTIMEofKTT_UoSVD_ADHD] = KTTMain_lib(X,label,l,data_KTT2,data_TT,t);

end

l = 1:1:10;
save('CVofKTT_UoSVD_ADHD.mat','CVofKTT_UoSVD_ADHD') % saving accuracy mat file
idxmax1 = find(CVofKTT_UoSVD_ADHD == max(CVofKTT_UoSVD_ADHD)); % maximum accuracy
% plotting accuracy vs TT rank
plot(l,CVofKTT_UoSVD_ADHD, '--s',...
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




