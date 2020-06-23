%%%% This is the main file for producing all the results %%%%
%%%%%%%%%%%%%%%%%%%%%% DATA1: ADNI %%%%%%%%%%%%%%%%%%%%%%%%%%
load('ADNI_first.mat')

n = size(X,1);
% eps = 0; % var1
%trunc = 2; % var2 : while fixing rank 
dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 50; %var3 % #repitition of whole procedure
global l 
% for l = 1:10 % var4
% 
% % main results including training and testing
% % SVM
% [CVofSVM_ADNI(l),TrainTimeofSVM_ADNI,TestTimeofSVM_ADNI] = SVMmain(X,label,t);
% 
% end
% 
% l = 1:1:10;
% save('CVofSVM_ADNI.mat','CVofSVM_ADNI')
% idxmax1 = find(CVofSVM_ADNI == max(CVofSVM_ADNI));
% plot(l,CVofSVM_ADNI, '--s',...
%     'MarkerIndices',1:1:length(l),...
%     'LineWidth',2,...
%     'MarkerSize',10,...
%     'MarkerFaceColor',[0.5,0.5,0.5],...
%     'MarkerEdgeColor','b',...
%     'MarkerIndices',[idxmax1],...
%     'MarkerFaceColor','red',...
%     'MarkerSize', 5)
% 
% hold on 

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

hold on

for l = 1:10 % var4
    
Data_CP  = CP(X,l);
% computing KCP of input tensor
[data_KCP] = KCP(X, Data_CP);


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
hold off 
legend({'DuSK','MMK'},'Location','northeast')
savefig('DuSK_MMK_ADNI_l10_t50_org.fig')

return
%%%%%%%%%%%%%%%%%%%%%% DATA2: ADHD %%%%%%%%%%%%%%%%%%%%%%%%%%
%load('ADHD200.mat')
X = X_adhd;
label = label_adhd;
n = size(X,1);

dimn = size(X{1});
% Repeat t times with k-fold cross validation 
t = 50; %var3 % #repitition of whole procedure
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
hold on 

for l = 1:10 % var4
    
data_CP  = CP(X,l);

% main results including training and testing
%DuSK
[CVofDuSK_ADNI(l),TrainTimeofDuSK_ADNI,TestTimeofDuSK_ADNI] = Main_DuSK(X,label,l,Data_CP,t);

end
l = 1:1:10;
save('CVofDuSK_ADNI.mat', 'CVofDuSK_ADNI')

idxmax2 = find(CVofDuSK_ADNI == max(CVofDuSK_ADNI));
plot(l,CVofCP_ADNI, '-o','MarkerIndices', 1:1:length(l), 'MarkerIndices', [idxmax2],...
    'MarkerFaceColor', 'red',...
    'LineWidth',2,...
    'MarkerSize', 5)

hold on

for l = 1:10 % var4
    
data_CP  = CP(X,l);
% computing KCP of input tensor
[data_KCP] = KCP(X, data_CP);


% main results including training and testing
% MMK method
[CVofMMK_ADNI(l),TrainTimeofMMK_ADNI,TestTimeofMMK_ADNI] = Main_MMK(X,label,l,data_KCP,kertype,t);

end
hold off 
legend({'SVM','DuSK','MMK'},'Location','southwest')
savefig('SVM_DuSK_MMK_ADNI_l10_t1_org.fig')
