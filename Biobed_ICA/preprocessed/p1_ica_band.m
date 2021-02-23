% Time:13min 43sec - 13min 58sec
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

mixed_sig=[ch2 ch3 ch4 ch5 ch6 ch8];

down_sig = downsample(mixed_sig,14);
Fs = 295.2;
samples=4428;
pre_sig = bsxfun(@minus,down_sig,mean(down_sig));

% Bandpass filter
Wnb1 = (2/Fs)*5;
Wnb2 = (2/Fs)*26;
bandf = fir1(100,[Wnb1 Wnb2],'bandpass'); 
out2 = filtfilt(bandf,1,pre_sig);
filt_sig_band = out2';

%pow3
[icasig_pow3s] = fastica (filt_sig_band,'approach','symm','g','pow3','numofIC',2);
[icasigd_pow3d] = fastica (filt_sig_band,'approach','defl','g','pow3','numofIC',2);

p1_pow3s=figure()
subplot(2,1,1);plot(icasig_pow3s(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (pow3-symm)','FontSize',8)
subplot(2,1,2);plot(icasig_pow3s(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p1_pow3s,'Units','Inches');
pos = get(p1_pow3s,'Position');
set(p1_pow3s,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_pow3s,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\band\per1\p1_pow3s','-dpdf','-r0')

p1_pow3d=figure()
subplot(2,1,1);plot(icasigd_pow3d(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (pow3-defl)','FontSize',8)
subplot(2,1,2);plot(icasigd_pow3d(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p1_pow3d,'Units','Inches');
pos = get(p1_pow3d,'Position');
set(p1_pow3d,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_pow3d,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\band\per1\p1_pow3d','-dpdf','-r0')

%tanh
[icasig_tanhs] = fastica (filt_sig_band,'approach','symm','g','tanh','numofIC',2);
[icasigd_tanhd] = fastica (filt_sig_band,'approach','defl','g','tanh','numofIC',2);

p1_tanhs=figure()
subplot(2,1,1);plot(icasig_tanhs(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (tanh-symm)','FontSize',8)
subplot(2,1,2);plot(icasig_tanhs(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p1_tanhs,'Units','Inches');
pos = get(p1_tanhs,'Position');
set(p1_tanhs,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_tanhs,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\band\per1\p1_tanhs','-dpdf','-r0')

p1_tanhd=figure()
subplot(2,1,1);plot(icasigd_tanhd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (tanh-defl)','FontSize',8)
subplot(2,1,2);plot(icasigd_tanhd(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p1_tanhd,'Units','Inches');
pos = get(p1_tanhd,'Position');
set(p1_tanhd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_tanhd,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\band\per1\p1_tanhd','-dpdf','-r0')

%gauss
[icasig_gausss] = fastica (filt_sig_band,'approach','symm','g','gauss','numofIC',2);
[icasigd_gaussd] = fastica (filt_sig_band,'approach','defl','g','gauss','numofIC',2);

p1_gausss=figure()
subplot(2,1,1);plot(icasig_gausss(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (gauss-symm)','FontSize',8)
subplot(2,1,2);plot(icasig_gausss(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p1_gausss,'Units','Inches');
pos = get(p1_gausss,'Position');
set(p1_gausss,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_gausss,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\band\per1\p1_gausss','-dpdf','-r0')

p1_gaussd=figure()
subplot(2,1,1);plot(icasigd_gaussd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (gauss-defl)','FontSize',8)
subplot(2,1,2);plot(icasigd_gaussd(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p1_gaussd,'Units','Inches');
pos = get(p1_gaussd,'Position');
set(p1_gaussd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_gaussd,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\band\per1\p1_gaussd','-dpdf','-r0')

%skew
[icasig_skews] = fastica (filt_sig_band,'approach','symm','g','skew','numofIC',2);
[icasigd_skewd] = fastica (filt_sig_band,'approach','defl','g','skew','numofIC',2);

p1_skews=figure()
subplot(2,1,1);plot(icasig_skews(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (skew-symm)','FontSize',8)
subplot(2,1,2);plot(icasig_skews(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p1_skews,'Units','Inches');
pos = get(p1_skews,'Position');
set(p1_skews,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_skews,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\band\per1\p1_skews','-dpdf','-r0')

p1_skewd=figure()
subplot(2,1,1);plot(icasigd_skewd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (skew-defl)','FontSize',8)
subplot(2,1,2);plot(icasigd_skewd(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p1_skewd,'Units','Inches');
pos = get(p1_skewd,'Position');
set(p1_skewd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_skewd,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\band\per1\p1_skewd','-dpdf','-r0')

