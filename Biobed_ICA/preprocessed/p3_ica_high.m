%Time:3h 45min 30sec - 3h 45min 45sec
t1=55905960;
t2=55967940-1;
samples=61980;

[ch1,f1]=audioread('t16-8-4132-1-apnea.wav',[t1 t2]); 
[ch2,f2]=audioread('t16-8-4132-2-apnea.wav',[t1 t2]);
[ch3,f3]=audioread('t16-8-4132-3-apnea.wav',[t1 t2]);
[ch4,f4]=audioread('t16-8-4132-4-apnea.wav',[t1 t2]);
[ch5,f5]=audioread('t16-8-4132-5-apnea.wav',[t1 t2]);
[ch6,f6]=audioread('t16-8-4132-6-apnea.wav',[t1 t2]);
[ch7,f7]=audioread('t16-8-4132-7-apnea.wav',[t1 t2]);
[ch8,f8]=audioread('t16-8-4132-8-apnea.wav',[t1 t2]);

mixed_sig=[ch1 ch2 ch3 ch4 ch5 ch6];

down_sig = downsample(mixed_sig,14);
Fs = 295.2;
samples=4428;

pre_sig = bsxfun(@minus,down_sig,mean(down_sig));

% Highpass filter
Wnh = (2/Fs)*60;
highf = fir1(100,Wnh,'high');
out3 = filtfilt(highf,1,pre_sig);
filt_sig_high = out3';

%pow3
[icasig_pow3s] = fastica (filt_sig_high,'approach','symm','g','pow3','numofIC',2);
[icasigd_pow3d] = fastica (filt_sig_high,'approach','defl','g','pow3','numofIC',2);

p3_pow3s=figure()
subplot(2,1,1);plot(icasig_pow3s(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (pow3-symm)','FontSize',8)
subplot(2,1,2);plot(icasig_pow3s(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p3_pow3s,'Units','Inches');
pos = get(p3_pow3s,'Position');
set(p3_pow3s,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p3_pow3s,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\high\per3\p3_pow3s','-dpdf','-r0')

p3_pow3d=figure()
subplot(2,1,1);plot(icasigd_pow3d(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (pow3-defl)','FontSize',8)
subplot(2,1,2);plot(icasigd_pow3d(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p3_pow3d,'Units','Inches');
pos = get(p3_pow3d,'Position');
set(p3_pow3d,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p3_pow3d,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\high\per3\p3_pow3d','-dpdf','-r0')

%tanh
[icasig_tanhs] = fastica (filt_sig_high,'approach','symm','g','tanh','numofIC',2);
[icasigd_tanhd] = fastica (filt_sig_high,'approach','defl','g','tanh','numofIC',2);

p3_tanhs=figure()
subplot(2,1,1);plot(icasig_tanhs(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (tanh-symm)','FontSize',8)
subplot(2,1,2);plot(icasig_tanhs(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p3_tanhs,'Units','Inches');
pos = get(p3_tanhs,'Position');
set(p3_tanhs,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p3_tanhs,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\high\per3\p3_tanhs','-dpdf','-r0')

p3_tanhd=figure()
subplot(2,1,1);plot(icasigd_tanhd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (tanh-defl)','FontSize',8)
subplot(2,1,2);plot(icasigd_tanhd(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p3_tanhd,'Units','Inches');
pos = get(p3_tanhd,'Position');
set(p3_tanhd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p3_tanhd,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\high\per3\p3_tanhd','-dpdf','-r0')

%gauss
[icasig_gausss] = fastica (filt_sig_high,'approach','symm','g','gauss','numofIC',2);
[icasigd_gaussd] = fastica (filt_sig_high,'approach','defl','g','gauss','numofIC',2);

p3_gausss=figure()
subplot(2,1,1);plot(icasig_gausss(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (gauss-symm)','FontSize',8)
subplot(2,1,2);plot(icasig_gausss(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p3_gausss,'Units','Inches');
pos = get(p3_gausss,'Position');
set(p3_gausss,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p3_gausss,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\high\per3\p3_gausss','-dpdf','-r0')

p3_gaussd=figure()
subplot(2,1,1);plot(icasigd_gaussd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (gauss-defl)','FontSize',8)
subplot(2,1,2);plot(icasigd_gaussd(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p3_gaussd,'Units','Inches');
pos = get(p3_gaussd,'Position');
set(p3_gaussd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p3_gaussd,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\high\per3\p3_gaussd','-dpdf','-r0')

%skew
[icasig_skews] = fastica (filt_sig_high,'approach','symm','g','skew','numofIC',2);
[icasigd_skewd] = fastica (filt_sig_high,'approach','defl','g','skew','numofIC',2);

p3_skews=figure()
subplot(2,1,1);plot(icasig_skews(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (skew-symm)','FontSize',8)
subplot(2,1,2);plot(icasig_skews(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p3_skews,'Units','Inches');
pos = get(p3_skews,'Position');
set(p3_skews,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p3_skews,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\high\per3\p3_skews','-dpdf','-r0')

p3_skewd=figure()
subplot(2,1,1);plot(icasigd_skewd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (skew-defl)','FontSize',8)
subplot(2,1,2);plot(icasigd_skewd(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(p3_skewd,'Units','Inches');
pos = get(p3_skewd,'Position');
set(p3_skewd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p3_skewd,'C:\Users\Schnitzel\Desktop\thesis\images\ica\filtra\high\per3\p3_skewd','-dpdf','-r0')
