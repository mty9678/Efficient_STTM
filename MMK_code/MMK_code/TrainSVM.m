function [Bestcv, Bestc,Bestg,time_tr,time_te]= TrainSVM(X,label,k,choose,c1,c2,g1,g2);
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%UNTITLED Summary of this function goes here

%%   Input

%          X         the input data cell array, n * 1 --- each array represents a three-order tensor
%                    n is the number of training examples
%          label     the output labels associated with the input data, n * 1
%          R :       the rank of tensor decomposition
%          k :       k-fold cross validation
%          data_KCP  CP or KCP decomposition result
%          c1, c2 :  the trade-off parameter range [2^c1, 2^(c1+1),..., 2^(c2-1), 2^c2] in SVM model
%          g1, g2 :  the RBF kernel width parameter range [2^g1, 2^(g1+1),..., 2^(g2-1), 2^g2] in SVM model

%%   Output:

%         Bestcv,Bestc,Bestg:    Test accuracy obtained using k-fold cross validation in the optimal hyper-parameters (Bestc,Bestg)
%         time_tr:               Training time     
%         time_te:               Test time 

%% Initialize
%flagker=1;                                                     % if flagker=0, linear-kernel function is used, otherwise RBF function
n=size(X,1);
c=ones(1,n);  
a=cumsum(c);
Bestcv=0;
Bestc=-100;
Bestg=-100;
Acctemp=zeros(k,c2-c1+1);
timetemp_tr=zeros(k,c2-c1+1);
timetemp_te=zeros(k,c2-c1+1);
time_tr=0;
time_te=0;

%dims = [49,58,47];
%% k-fold cross validation
cvp = cvpartition(label,'KFold',k);
for log2g = g1:g2 
     for cv=1:cvp.NumTestSets
        b=setdiff(a,choose{cv,1});
        Atrain=cell(length(b),1);
        Atest=cell(n-length(b),1);
        tic;
        for p=1:length(b)
                  Atrain{p}= X{b(p),1}(:);
        end
        data_train =  cell2mat(cellfun(@(x)x(:)', Atrain,'UniformOutput', 0)); 
        time_tr1=toc;
        tic;
        for r=1:n-length(b)
                    Atest{r}= X{choose{cv,1}(1,r),1}(:);
        end
        data_test =  cell2mat(cellfun(@(x)x(:)', Atest,'UniformOutput', 0)); 
        time_te1=toc;
        tempc=0;
        for log2c=c1:c2 
            tempc=tempc+1;
            tic;
            model = fitcsvm(data_train,label(b),'KernelFunction','rbf','BoxConstraint', 2^log2c,'KernelScale', 2^log2g); %
            time_tr2=toc;
            timetemp_tr(cv,tempc)=time_tr1+time_tr2;
            tic;
            [pred_label,~] = predict(model,data_test);
            temp = norm(pred_label-label(choose{cv,1}))/ norm(label(choose{cv,1}));
            time_te2=toc;
            timetemp_te(cv,tempc)=time_te1+time_te2;
            Acctemp(cv,tempc)=temp/100;  
         end
         clear b Atrain Atest
     end
    Accvector=sum(Acctemp,1);
    timetrain=sum(timetemp_tr,1);
    timetest=sum(timetemp_te,1);
    [Acc,C]=max(Accvector);
    if Acc/k>Bestcv
        Bestcv=Acc/k;       
        Bestc=(C-(1-c1));
        Bestg=log2g;
        time_tr=timetrain(C)/k;
        time_te=timetest(C)/k;
    end
    fprintf('%g %g curracc=%g (best c=%g, g=%g, bestacc=%g) traintime=%g,testtime=%g\n',log2c, log2g, Acc/k, Bestc, Bestg, Bestcv,time_tr,time_te);
end