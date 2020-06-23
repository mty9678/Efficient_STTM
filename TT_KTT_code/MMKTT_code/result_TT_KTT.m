%%%% This is the file which produce KTT results (TT decomposiiton + kernel approximation)%%%%

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
[ data_KTT2_eye ] = KTT2( X, data_TT, kerfilter);

% main results including training and testing
[CVofKeyeTT_ADNI(l),trainTIMEofKeyeTT_ADNI,testTIMEofKeyeTT_ADNI] = KTTMain_lib(X,label,data_KTT2_eye,data_TT,t);

clear kerfilter

kerfilter = 'random';

% computing KTT of input tensor
[ data_KTT2_rnd ] = KTT2( X, data_TT, kerfilter);

% main results including training and testing
[CVofKrndTT_ADNI(l),trainTIMEofKrndTT_ADNI,testTIMEofKrndTT_ADNI] = KTTMain_lib(X,label,data_KTT2_rnd,data_TT,t);



end

l = 1:1:10;
save('CVofKeyeTT_ADNI.mat','CVofKeyeTT_ADNI') % mat file for accuracy output for identity kernel
idxmax1 = find(CVofKeyeTT_ADNI == max(CVofKeyeTT_ADNI)); % maximum accuracy for identity kernel

save('CVofKrndTT_ADNI.mat','CVofKrndTT_ADNI') % mat file for accuracy output for random kernel
idxmax2 = find(CVofKrndTT_ADNI == max(CVofKrndTT_ADNI)); % maximum accuracy for random kernel

% plotting accuracy vs TT rank
plot(l,CVofKeyeTT_ADNI, '--s',...
    'MarkerIndices',1:1:length(l),...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerFaceColor',[0.5,0.5,0.5],...
    'MarkerEdgeColor','b',...
    'MarkerIndices',[idxmax1],...
    'MarkerFaceColor','red',...
    'MarkerSize', 5)

hold on

% plotting accuracy vs TT rank
plot(l,CVofKrndTT_ADNI, '-*','MarkerIndices', 1:1:length(l), 'MarkerIndices', [idxmax2],...
      'MarkerFaceColor', 'green',...
       'LineWidth',2,...
      'MarkerSize', 5)

hold off 
legend({ 'TT_KTT_identity','TT_KTT_random'},'Location','southeast')
savefig('TT_STM_eyeVSrnd.fig')

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
[ data_KTT2_eye ] = KTT2( X, data_TT, kerfilter);

% main results including training and testing
[CVofKTT_ADHD(l),trainTIMEofKTT_ADHD,testTIMEofKTT_ADHD] = KTTMain_lib(X,label,l,data_KTT2_eye,data_TT,t);

end

l = 1:1:10;
save('CVofKTT_ADHD.mat','CVofKTT_ADHD') % saving accuracy mat file
idxmax1 = find(CVofKTT_ADHD == max(CVofKTT_ADHD)); % maximum accuracy
% plotting accuracy vs TT rank
plot(l,CVofKTT_ADHD, '--s',...
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




