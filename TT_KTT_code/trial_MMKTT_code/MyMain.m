% MyMain file goes here
%clear all;
%clc;
global pos
global R
load('ADNI.mat');
global dims
dims = size(X{1});
%% TT-rounded decomposition for same ranks
l = 5;
eps = 0;
%for l = 3:6; % rank for all TT
[ data_TT ,R, pos] = TT_dec(X,l,eps); % pos is telling length of each tt_core ;

% Kernelised TT decomposition
[ data_KTT2 ] = KTT2( X, data_TT);
[Bestcv,Besttimetr,Besttimete] = KTTMain_lib(X,label,data_KTT2,data_TT);
%end




% for l = 1:10
% [ data_TT ,R, pos] = TT_dec(X,l); % pos is telling length of each tt_core ;
% [ data_KTT2 ] = KTT2( X, data_TT);
% [Bestcv(l),Besttimetr,Besttimete] = KTTMain(X,label,data_KTT2);
% end
% l = 1:1:10;
% save('Bestcv.mat','Bestcv')
% idxmax = find(Bestcv == max(Bestcv));
% plot(l, Bestcv, '-s','MarkerIndices',[idxmax],...
%     'MarkerFaceColor','red',...
%     'MarkerSize',5)
% toc;
% print('toc');