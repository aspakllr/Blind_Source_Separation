%% Biobed data trials

[ch1,f1]=audioread('t16-8-4132-1-apnea.wav',[4111000 4193000-1]); 
[ch2,f2]=audioread('t16-8-4132-2-apnea.wav',[4111000 4193000-1]);
[ch3,f3]=audioread('t16-8-4132-3-apnea.wav',[4111000 4193000-1]);
[ch4,f4]=audioread('t16-8-4132-4-apnea.wav',[4111000 4193000-1]);
[ch5,f5]=audioread('t16-8-4132-5-apnea.wav',[4111000 4193000-1]);
[ch6,f6]=audioread('t16-8-4132-6-apnea.wav',[4111000 4193000-1]);
[ch7,f7]=audioread('t16-8-4132-7-apnea.wav',[4111000 4193000-1]);
[ch8,f8]=audioread('t16-8-4132-8-apnea.wav',[4111000 4193000-1]);

mixed_sig=[ch1';ch2';ch3';ch4';ch5';ch6';ch7';ch8'];
% mixed_sig2=[ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8]; kathe stili einai ena sima

figure
set(gcf,'name','Biobed mixed signals','numbertitle','off') 
subplot(3,1,1);plot(mixed_sig(1,:));title('Channel 1')
subplot(3,1,2);plot(mixed_sig(2,:));title('Channel 2')
subplot(3,1,3);plot(mixed_sig(3,:));title('Channel 3')
subplot(4,1,4);plot(mixed_sig(4,:));title('Channel 4')

figure
set(gcf,'name','Biobed mixed signals','numbertitle','off') 
subplot(4,1,1);plot(mixed_sig(5,:));title('Channel 5')
subplot(4,1,2);plot(mixed_sig(6,:));title('Channel 6')
subplot(4,1,3);plot(mixed_sig(7,:));title('Channel 7')
subplot(4,1,4);plot(mixed_sig(8,:));title('Channel 8')


%% PCA using the SVD approach
coeff_svd=pca(mixed_sig');
source_svd=coeff_svd'*mixed_sig;

% coeff_svd=pca(mixed_sig2);
% source_svd=coeff_svd*mixed_sig2';

figure
set(gcf,'name','Signals after PCA','numbertitle','off')
subplot(3,1,1);plot(source_svd(1,:),'k')  
subplot(3,1,2);plot(source_svd(2,:),'r')
subplot(3,1,3);plot(source_svd(3,:),'m')


%% PCA using the eig approach
% 
% coeff_eig=pca(mixed_sig','Algorithm','eig');
% source_eig=coeff_eig'*mixed_sig;
% 
% figure
% set(gcf,'name','Signals after PCA using eig approach','numbertitle','off')
% subplot(3,1,1);plot(source_eig(1,:))  %% exw valei na emfanizontai mono oi prwtes 4 principal components
% subplot(3,1,2);plot(source_eig(2,:))
% subplot(3,1,3);plot(source_eig(3,:))

%% Checking results

% sound(source_svd(2,:))


