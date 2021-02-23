%% Check signals

get(0,'Factory')
set(0,'defaultfigurecolor',[1 1 1])

% Channel:2
% Time: 1h 16min 30sec - 1h 16min 42secs polu komple,den exei thorivo
t1=18965880;  
t2=19015464-1;
samples=49584;
[s,f2] = audioread('t16-8-4132-2-apnea.wav',[t1 t2]);

noise = 0.2*(rand(1,samples)-0.5);

% checksig=figure()
% subplot(2,1,1);plot(s,'color',[0.502 0.502 1] );title('Channel 2')
% axis([0 samples -1 1])
% subplot(2,1,2);plot(noise,'color',[0.502 0 0]);title('Noise')
% axis([0 samples -0.5 0.5])
% set(checksig,'Units','Inches');
% pos = get(checksig,'Position');
% set(checksig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(checksig,'C:\Users\Schnitzel\Desktop\thesis\images\check\checksig','-dpdf','-r0')

x1 = s + noise';
x2 = 0.9*s + 0.5*noise';
mix = [x1 x2];
mixed_sig=mix';

% checkmix=figure()
% subplot(2,1,1); plot(x1,'k');title('Mixed Signals')
% axis([0 samples -1 1])
% subplot(2,1,2); plot(x2,'k');
% axis([0 samples -1 1])
% set(checkmix,'Units','Inches');
% pos = get(checkmix,'Position');
% set(checkmix,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(checkmix,'C:\Users\Schnitzel\Desktop\thesis\images\check\checkmix','-dpdf','-r0')

%% PCA 

%SVD approach
[coeff_svd,score,~,~,expl]=pca(mixed_sig');
source_svd=coeff_svd'*mixed_sig;

%eig approach
coeff_eig=pca(mixed_sig','Algorithm','eig');
source_eig=coeff_eig'*mixed_sig;

checkpcasvd=figure()
subplot(2,1,1);plot(source_svd(1,:),'color',[0.502 0.502 1])
axis([0 samples -1.2 1.2]);
title('Principal Components-SVD','FontSize',8);
subplot(2,1,2);plot(source_svd(2,:),'color',[0.502 0 0]) 
axis([0 samples -0.5 0.5])
set(checkpcasvd,'Units','Inches');
pos = get(checkpcasvd,'Position');
set(checkpcasvd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(checkpcasvd,'C:\Users\Schnitzel\Desktop\thesis\images\check\checkpcasvd','-dpdf','-r0')

checkpcaeig=figure()
subplot(2,1,1);plot(source_eig(1,:),'color',[0.502 0.502 1]);title('Principal Components-EIG','FontSize',8);
axis([0 samples -1.2 1.2])
subplot(2,1,2);plot(source_eig(2,:),'color',[0.502 0 0]) 
axis([0 samples -0.5 0.5])
set(checkpcaeig,'Units','Inches');
pos = get(checkpcaeig,'Position');
set(checkpcaeig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(checkpcaeig,'C:\Users\Schnitzel\Desktop\thesis\images\check\checkpcaeig','-dpdf','-r0')


