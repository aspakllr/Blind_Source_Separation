clear all;
close all;

%Time:13min 43sec - 13min 53sec  
% t1=3400636;
% t2=3441956-1;
% samples=41320;
% t=1/4132:1/4132:10;

%Time:13min 43sec - 13min 58sec
t1=3400636;
t2=3462616-1;
samples=61980;

get(0,'Factory')
set(0,'defaultfigurecolor',[1 1 1])

[ch1,f1]=audioread('t16-8-4132-1-apnea.wav',[t1 t2]); 
[ch2,f2]=audioread('t16-8-4132-2-apnea.wav',[t1 t2]);
[ch3,f3]=audioread('t16-8-4132-3-apnea.wav',[t1 t2]);
[ch4,f4]=audioread('t16-8-4132-4-apnea.wav',[t1 t2]);
[ch5,f5]=audioread('t16-8-4132-5-apnea.wav',[t1 t2]);
[ch6,f6]=audioread('t16-8-4132-6-apnea.wav',[t1 t2]);
[ch7,f7]=audioread('t16-8-4132-7-apnea.wav',[t1 t2]);
[ch8,f8]=audioread('t16-8-4132-8-apnea.wav',[t1 t2]);

mix=[ch2 ch3 ch4 ch5 ch6 ch8]; %kathe stili einai ena sima
mixed_sig=mix'; %kathe grammi einai ena sima

% PCA using the SVD approach
[coeff_svd,~,latent,~,explvar]=pca(mixed_sig');
source_svd=coeff_svd'*mixed_sig;

v=[1 2 3 4 5 6];
figure(1)
subplot(1,2,1);gscatter(v,latent);
set(gca,'xtick',1:6)
xlabel('')
ylabel('Eigenvalues')
title('Graph of eigenvalues-SVD')
subplot(1,2,2);bar(explvar);
title('Percentage of the total variance explained by each principal component-SVD');

% PCA using the eig approach
[coeff_eig,~,latent2,~,explvar2]=pca(mixed_sig','Algorithm','eig');
source_eig=coeff_eig'*mixed_sig;

figure(2)
v2=[1 2 3 4 5 6];
subplot(1,2,1);gscatter(v2,latent2);
set(gca,'xtick',1:6)
xlabel('')
ylabel('Eigenvalues')
title('Graph of eigenvalues-EIG')
subplot(1,2,2);bar(explvar2);
title('Percentage of the total variance explained by each principal component-EIG');

% Plotting
p1pcasvd=figure()
subplot(3,2,1);plot(source_svd(1,:),'color',[0.502 0.502 1]);title('PC1 (svd)','FontSize',8);
axis([0 samples -1.5 1.5])
subplot(3,2,2);plot(source_svd(2,:),'color',[0.502 0 0]);title('PC2 (svd)','FontSize',8);
axis([0 samples -0.5 0.5])
subplot(3,2,3);plot(source_svd(3,:),'color',[0.85 0.7 1]);title('PC3 (svd)','FontSize',8);
axis([0 samples -0.5 0.5])
subplot(3,2,4);plot(source_svd(4,:),'color',[0.204 0 0]);title('PC4 (svd)','FontSize',8);
axis([0 samples -0.2 0.2])
subplot(3,2,5);plot(source_svd(5,:),'color',[0.4 0.4 0.4]);title('PC5 (svd)','FontSize',8);
axis([0 samples -0.05 0.05])
subplot(3,2,6);plot(source_svd(6,:),'color',[0.4 0 0.2]);title('PC6 (svd)','FontSize',8);
axis([0 samples -0 0.1])
set(p1pcasvd,'Units','Inches');
pos = get(p1pcasvd,'Position');
set(p1pcasvd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1pcasvd,'C:\Users\Schnitzel\Desktop\thesis\images\pca\xwris_epekserg\p1pcasvd','-dpdf','-r0')

p1pcaeig=figure()
subplot(3,2,1);plot(source_eig(1,:),'color',[0.502 0.502 1]);title('PC1 (eig)','FontSize',8);
axis([0 samples -1.5 1.5])
subplot(3,2,2);plot(source_eig(2,:),'color',[0.502 0 0]);title('PC2 (eig)','FontSize',8);
axis([0 samples -0.5 0.5])
subplot(3,2,3);plot(source_eig(3,:),'color',[0.85 0.7 1]);title('PC3 (eig)','FontSize',8);
axis([0 samples -0.5 0.5])
subplot(3,2,4);plot(source_eig(4,:),'color',[0.204 0 0]);title('PC4 (eig)','FontSize',8);
axis([0 samples -0.2 0.2])
subplot(3,2,5);plot(source_eig(5,:),'color',[0.4 0.4 0.4]);title('PC5 (eig)','FontSize',8);
axis([0 samples -0.05 0.05])
subplot(3,2,6);plot(source_eig(6,:),'color',[0.4 0 0.2]);title('PC6 (eig)','FontSize',8);
axis([0 samples -0 0.1])
set(p1pcaeig,'Units','Inches');
pos = get(p1pcaeig,'Position');
set(p1pcaeig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1pcaeig,'C:\Users\Schnitzel\Desktop\thesis\images\pca\xwris_epekserg\p1pcaeig','-dpdf','-r0')

