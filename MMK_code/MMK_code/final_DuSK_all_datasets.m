%%%%%%%%%%%%%%%%%%%%%%% DuSK method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datatype = 'adhd';

switch datatype
%% ADNI dataset
    case 'adni'
load('ADNI_first.mat');

n = size(X,1);
% eps = 0; % var1
%trunc = 2; % var2 : while fixing rank 
dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 50; %var3 % #repitition of whole procedure
global l

for l = 1:10 % var4
    
Data_CP  = CP(X,l);

% main results including training and testing
%DuSK
[CVofDuSK_ADNI(l),TrainTimeofDuSK_ADNI,TestTimeofDuSK_ADNI] = Main_DuSK(X,label,l,Data_CP,t);

end
l = 1:1:10;
save('CVofDuSK_ADNI.mat', 'CVofDuSK_ADNI')

idxmax2 = find(CVofDuSK_ADNI == max(CVofDuSK_ADNI));
plot(l,CVofDuSK_ADNI, '-o','MarkerIndices', 1:1:length(l), 'MarkerIndices', [idxmax2],...
    'MarkerFaceColor', 'red',...
    'LineWidth',2,...
    'MarkerSize', 5)

%% ADHD dataset
    case 'adhd'
load('ADHD_mainset.mat')
n = size(X,1);
dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 25; %var3 % #repitition of whole procedure
global l

for l = 3:6 % var4
    
Data_CP  = CP(X,l);

% main results including training and testing
%DuSK
[CVofDuSK_ADHD(l),TrainTimeofDuSK_ADHD,TestTimeofDuSK_ADHD] = Main_DuSK(X,label,l,Data_CP,t);

end
l = 3:1:6
save('CVofDuSK_ADHD.mat', 'CVofDuSK_ADHD')

idxmax2 = find(CVofDuSK_ADHD == max(CVofDuSK_ADHD));
plot(l,CVofDuSK_ADHD, '-o','MarkerIndices', 3:1:length(l), 'MarkerIndices', [idxmax2],...
    'MarkerFaceColor', 'red',...
    'LineWidth',2,...
    'MarkerSize', 5)
end
