%%%%% this file if using full tensor to compute kernel and classification
%%%%% by SVM is performed  %%%%%%%%%%%

%load('/my_MMK_folder/LIBVSM_MMKTT/ADNI.mat') % dataset
load('ADNI.mat')
addpath('libsvm-3.17')
%addpath('/my_MMK_folder/LIBVSM_MMKTT/libsvm-3.17') % svm library

n = 33;
k = 5; % 5-fold cross validation
g = 10;
s = 1;
c=ones(1,n);  
a=cumsum(c);
%rng(0)
t = 50; % repiting the code to get an avg 
accvector = zeros(t,1);

for p = 1:t
randseed = round(rand(1)*20);
%randseed = round(rand(1)*5489);
elimin_test=Divide(label,k,randseed); 
b=setdiff(a,elimin_test{k,1});
Y=X(b,:);
Y_label=label(b);
for i=1:length(b)
    for j=1:length(b)
        Ktrain(i,j)=exp(-norm(tensor(Y{i,1})-tensor(Y{j,1}))^2/g^2);
    end
end
for l=1:n-length(b)
    for i=1:length(b)
          Ktest(l,i) = exp(-norm(tensor(X{elimin_test{k,1}(1,l)})-tensor(X{i,1}))^2/g^2);
     end
end
Ktrain1 = [(1:length(b))',Ktrain];
Ktest1 = [(1:n-length(b))', Ktest];
cmd=['-c ', num2str(s), ' -t ', num2str(4),' -q'];
model= svmtrain(label(b), Ktrain1, cmd);
%pred_label = svmpredict(label(elimin_test{k,1}), Ktest1, model,'-q');
[~, temp, ~] = svmpredict(label(elimin_test{k,1}), Ktest1, model);
accvector(p) = temp(1);
end
max_acc = max(accvector)
avg_acc = sum(accvector)/t


% [Acc,C]=max(Accvector);












% The kernel matrix 
% n = 33;
% sigma = 10;
% for i=1:n
%     for j=1:n
%         K(i,j)=exp(-norm(tensor(X{i,1})-tensor(X{j,1}))/sigma^2);
%     end
% end
% training 
% g1 = -8;
% g2 = +8;
% k = 5;
% c1 = -8;
% c2 = +8;
% c=ones(1,n);  
% a=cumsum(c);
% Bestcv=0;
% Bestc=-100;
% Bestg=-100;
% Acctemp=zeros(k,c2-c1+1);
% 
% % Repeatation t times, can be added 
% randseed = round(rand(1)*5489);
% elimin_test=Divide(label,k,randseed);                                        % Randomly sample 80% of the whole data as the training set
% b1=setdiff(a,elimin_test{k,1});
% Y=X(b1,:);
% Y_label=label(b1);
% randseed = round(rand(1)*5489);
% Div=Divide(Y_label,k,randseed);    % k-fold cross validation
% % TrainAverAcc(Y,Y_label,R,k,data_KCP(b,1),Div,c1,c2,g1,g2,kertype);
% % TrainAverAcc(X,label,R,k,data_KCP,choose,c1,c2,g1,g2);
% % Ker_DuSK(data_KCP{b(p),1},data_KCP{b(q),1},Order,2^log2g,R,flagker);
%     for sigma = g1:g2 
%         for cv=1:k
%             b=setdiff(a,Div{cv,1});
%             Ktrain=zeros(length(b),length(b));
%             Ktest=zeros(n-length(b),length(b));
%             for p=1:length(b)
%                 for q=1:p
%                    Ktrain(p,q) = exp(-norm(tensor(X{b(p),1})-tensor(X{b(q),1}))/sigma^2);
%                     if p~=q
%                        Ktrain(q,p)=Ktrain(p,q);
%                     end
%                 end
%             end
%             for r=1:n-length(b)
%                 for p=1:length(b)
%                     Ktest(r,p) = exp(-norm(tensor(X{Div{cv,1}(1,r)})-tensor(X{b(p),1}))/sigma^2);
%                 end
%             end
%             Ktrain1 = [(1:length(b))',Ktrain];
%             Ktest1 = [(1:n-length(b))', Ktest];
%             tempc=0;
%             for log2c=c1:c2 
%                 tempc=tempc+1;
%                 cmd=['-c ', num2str(2^log2c), ' -t ', num2str(4),' -q'];
%                 model= svmtrain(label(b), Ktrain1, cmd);
%                 [~,temp,~] = svmpredict(label(Div{cv,1}), Ktest1, model,'-q');
%                 Acctemp(cv,tempc)=temp(1)/100;  
%         end
%         clear b Ktrain Ktest
%     end
%     Accvector=sum(Acctemp,1);
%     [Acc,C]=max(Accvector);
%     if Acc/k>Bestcv
%         Bestcv=Acc/k;       
%         Bestc=(C-(1-c1));
%         Bestg=sigma;
%     end
%     fprintf('%g %g (best c=%g, g=%g, bestacc=%g)\n',c, sigma, Bestc, Bestg, Bestcv);
%     end
%    [Bestc, Bestg];
%   for j=1:5                                                                    % Extra repeat 5 times to get more stable result
%         randseed = round(rand(1)*5489);
%         DivOpti=Divide(label,k,randseed);
%     %    [cv, ~,~,timetr,timete]=TrainAverAcc(X,label,R,k,data_KCP,DivOpti,bestc,bestc,bestg,bestg,kertype);  
%         
%     for cv=1:k
%         b=setdiff(a,DivOpti{cv,1});
%         Ktrain=zeros(length(b),length(b));
%         Ktest=zeros(n-length(b),length(b));
%         tic;
%         for p=1:length(b)
%             for q=1:p
%                 Ktrain(p,q) = exp(-norm(tensor(X{b(p),1})-tensor(X{b(q),1}))/Bestg^2);
%                 if p~=q
%                     Ktrain(q,p)=Ktrain(p,q);
%                 end
%             end
%         end
%         for r=1:n-length(b)
%             for p=1:length(b)
%                Ktest(r,p) = exp(-norm(tensor(X{DivOpt{cv,1}(1,r)})-tensor(X{b(q),1}))/Bestg^2);
%             end
%         end
%         Ktrain1 = [(1:length(b))',Ktrain];
%         Ktest1 = [(1:n-length(b))', Ktest];
%         model= svmtrain(label(b), Ktrain1, '-c  Bestc -t  4 -q');
%         [~,temp,~] = svmpredict(label(DivOpt{cv,1}), Ktest1, model,'-q');
%         Acctemp(cv)=temp(1)/100;  
%         clear b Ktrain Ktest
%     end
%     Accvector=sum(Acctemp,1);
%     [Acc,C]=max(Accvector);
%     if Acc/k>Bestcv
%         Bestcv=Acc/k;       
%         Bestc=(C-(1-c1));
%         Bestg=g;
%     end
%     fprintf(' (bestacc=%g)\n', Bestcv);
%     acc=acc+Bestcv;
% end    
%     fprintf('The accuracy is %g corresponding to the %g th repeat, bestc is %g, bestg is %g\n',acc/(i*j),i, bestc,bestg);
%     clear elimin_test b Y Y_label Div bestc bestg
% 
% Bestcv = acc/(i*j);
% Besttimetr=counttimetr/(i*j);
% Besttimete=counttimete/(i*j);
% 


% Ker = [(1:n)' K];
% model = svmtrain(label, Ker, '-t 4');
% rng(0);
% data = rand(61,73,61);
% pred =  predict(model,data);