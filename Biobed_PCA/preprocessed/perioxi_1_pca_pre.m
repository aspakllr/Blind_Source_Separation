%Time:13min 43sec - 13min 58sec
t1=3400636;
t2=3462616-1;

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

%% Preprocessing and filtering

down_sig = downsample(mixed_sig',14);
Fs = 295.2;
samples=4428;

pre_sig = bsxfun(@minus,down_sig,mean(down_sig));

%% Lowpass filter    
Wnl = (2/Fs)*3;
lowf = fir1(100,Wnl,'low');
out1 = filtfilt(lowf,1,pre_sig);
filt_sig_low = out1';

coeff_svd_fl=pca(filt_sig_low');
source_svd_fl=coeff_svd_fl'*filt_sig_low;

coeff_eig_fl=pca(filt_sig_low','Algorithm','eig');
source_eig_fl=coeff_eig_fl'*filt_sig_low;

p1low_svd=figure()
subplot(3,2,1);plot(source_svd_fl(1,:),'color',[0.502 0.502 1]);title('PC1 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(source_svd_fl(2,:),'color',[0.502 0 0]);title('PC2 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(source_svd_fl(3,:),'color',[0.85 0.7 1]);title('PC3 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(source_svd_fl(4,:),'color',[0.204 0 0]);title('PC4 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(source_svd_fl(5,:),'color',[0.4 0.4 0.4]);title('PC5 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(source_svd_fl(6,:),'color',[0.4 0 0.2]);title('PC6 (svd)','FontSize',8);xlim([0 samples])
set(p1low_svd,'Units','Inches');
pos = get(p1low_svd,'Position');
set(p1low_svd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1low_svd,'C:\Users\Schnitzel\Desktop\thesis\images\pca\filters\per1_filters_pca\p1low_svd','-dpdf','-r0')

p1low_eig=figure()
subplot(3,2,1);plot(source_eig_fl(1,:),'color',[0.502 0.502 1]);title('PC1 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(source_eig_fl(2,:),'color',[0.502 0 0]);title('PC2 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(source_eig_fl(3,:),'color',[0.85 0.7 1]);title('PC3 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(source_eig_fl(4,:),'color',[0.204 0 0]);title('PC4 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(source_eig_fl(5,:),'color',[0.4 0.4 0.4]);title('PC5 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(source_eig_fl(6,:),'color',[0.4 0 0.2]);title('PC6 (eig)','FontSize',8);xlim([0 samples])
set(p1low_eig,'Units','Inches');
pos = get(p1low_eig,'Position');
set(p1low_eig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1low_eig,'C:\Users\Schnitzel\Desktop\thesis\images\pca\filters\per1_filters_pca\p1low_eig','-dpdf','-r0')

%% Bandpass filter
Wnb1 = (2/Fs)*5;
Wnb2 = (2/Fs)*26;
bandf = fir1(100,[Wnb1 Wnb2],'bandpass');
out2 = filtfilt(bandf,1,pre_sig);
filt_sig_band = out2';

coeff_svd_fb=pca(filt_sig_band');
source_svd_fb=coeff_svd_fb'*filt_sig_band;

coeff_eig_fb=pca(filt_sig_band','Algorithm','eig');
source_eig_fb=coeff_eig_fb'*filt_sig_band;

p1band_svd=figure()
subplot(3,2,1);plot(source_svd_fb(1,:),'color',[0.502 0.502 1]);title('PC1 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(source_svd_fb(2,:),'color',[0.502 0 0]);title('PC2 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(source_svd_fb(3,:),'color',[0.85 0.7 1]);title('PC3 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(source_svd_fb(4,:),'color',[0.204 0 0]);title('PC4 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(source_svd_fb(5,:),'color',[0.4 0.4 0.4]);title('PC5 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(source_svd_fb(6,:),'color',[0.4 0 0.2]);title('PC6 (svd)','FontSize',8);xlim([0 samples])
set(p1band_svd,'Units','Inches');
pos = get(p1band_svd,'Position');
set(p1band_svd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1band_svd,'C:\Users\Schnitzel\Desktop\thesis\images\pca\filters\per1_filters_pca\p1band_svd','-dpdf','-r0')

p1band_eig=figure()
subplot(3,2,1);plot(source_eig_fb(1,:),'color',[0.502 0.502 1]);title('PC1 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(source_eig_fb(2,:),'color',[0.502 0 0]);title('PC2 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(source_eig_fb(3,:),'color',[0.85 0.7 1]);title('PC3 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(source_eig_fb(4,:),'color',[0.204 0 0]);title('PC4 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(source_eig_fb(5,:),'color',[0.4 0.4 0.4]);title('PC5 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(source_eig_fb(6,:),'color',[0.4 0 0.2]);title('PC6 (eig)','FontSize',8);xlim([0 samples])
set(p1band_eig,'Units','Inches');
pos = get(p1band_eig,'Position');
set(p1band_eig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1band_eig,'C:\Users\Schnitzel\Desktop\thesis\images\pca\filters\per1_filters_pca\p1band_eig','-dpdf','-r0')


% Highpass filter
Wnh = (2/Fs)*60;
highf = fir1(100,Wnh,'high');
out3 = filtfilt(highf,1,pre_sig);
filt_sig_high = out3';

coeff_svd_fh=pca(filt_sig_high');
source_svd_fh=coeff_svd_fh'*filt_sig_high;

coeff_eig_fh=pca(filt_sig_high','Algorithm','eig');
source_eig_fh=coeff_eig_fh'*filt_sig_high;

p1high_svd=figure()
subplot(3,2,1);plot(source_svd_fh(1,:),'color',[0.502 0.502 1]);title('PC1 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(source_svd_fh(2,:),'color',[0.502 0 0]);title('PC2 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(source_svd_fh(3,:),'color',[0.85 0.7 1]);title('PC3 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(source_svd_fh(4,:),'color',[0.204 0 0]);title('PC4 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(source_svd_fh(5,:),'color',[0.4 0.4 0.4]);title('PC5 (svd)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(source_svd_fh(6,:),'color',[0.4 0 0.2]);title('PC6 (svd)','FontSize',8);xlim([0 samples])
set(p1high_svd,'Units','Inches');
pos = get(p1high_svd,'Position');
set(p1high_svd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1high_svd,'C:\Users\Schnitzel\Desktop\thesis\images\pca\filters\per1_filters_pca\p1high_svd','-dpdf','-r0')

p1high_eig=figure()
subplot(3,2,1);plot(source_eig_fh(1,:),'color',[0.502 0.502 1]);title('PC1 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(source_eig_fh(2,:),'color',[0.502 0 0]);title('PC2 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(source_eig_fh(3,:),'color',[0.85 0.7 1]);title('PC3 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(source_eig_fh(4,:),'color',[0.204 0 0]);title('PC4 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(source_eig_fh(5,:),'color',[0.4 0.4 0.4]);title('PC5 (eig)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(source_eig_fh(6,:),'color',[0.4 0 0.2]);title('PC6 (eig)','FontSize',8);xlim([0 samples])
set(p1high_eig,'Units','Inches');
pos = get(p1high_eig,'Position');
set(p1high_eig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1high_eig,'C:\Users\Schnitzel\Desktop\thesis\images\pca\filters\per1_filters_pca\p1high_eig','-dpdf','-r0')


% 
% %% Sxolia
% % mixed == 3xsamples
% % coeff == pca(mixed') kathe stili antistoixei se mia principal component
% % source == coeff' x mixed  (3xsamples)
% 
