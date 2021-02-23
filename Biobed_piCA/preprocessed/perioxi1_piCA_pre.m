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

mixed_sig=[ch2 ch3 ch4 ch5 ch6 ch8];

% Preprocessing and filtering
down_sig = downsample(mixed_sig,14);
samples=4428;
Fs = 295.2;
pre_sig = bsxfun(@minus,down_sig,mean(down_sig));

% %% Lowpass filter 
% Wnl = (2/Fs)*3;
% lowf = fir1(100,Wnl,'low');
% out1 = filtfilt(lowf,1,pre_sig);
% filt_sig_low = out1;
% 
% %periodicity error
% lag_low=[1,5*Fs+1];
% te=0:1/Fs:5;
% [erlow,welow]=piCA(filt_sig_low,lag_low,'pre',[1,1,1]);
% 
% err1_low = figure()
% plot(te,erlow(:,1),'color',[0.85 0.7 1]);title('Minimum Periodicity Error','FontSize',8);xlabel('Time lag (sec)')
% set(err1_low,'Units','Inches');
% pos = get(err1_low,'Position');
% set(err1_low,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(err1_low,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\err1_low','-dpdf','-r0')
% 
% %periodic components
% [El,Wl]=piCA(filt_sig_low,1129); %3,824sec
% 
% p1pica_low = figure()
% subplot(3,2,1);plot(filt_sig_low*Wl(:,1),'color',[0.502 0.502 1]);title('pC1 (k=1.129)','FontSize',8);xlim([0 samples])
% subplot(3,2,2);plot(filt_sig_low*Wl(:,2),'color',[0.502 0 0]);title('pC2 (k=1.129)','FontSize',8);xlim([0 samples])
% subplot(3,2,3);plot(filt_sig_low*Wl(:,3),'color',[0.85 0.7 1]);title('pC3 (k=1.129)','FontSize',8);xlim([0 samples])
% subplot(3,2,4);plot(filt_sig_low*Wl(:,4),'color',[0.204 0 0]);title('pC4 (k=1.129)','FontSize',8);xlim([0 samples])
% subplot(3,2,5);plot(filt_sig_low*Wl(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=1.129)','FontSize',8);xlim([0 samples])
% subplot(3,2,6);plot(filt_sig_low*Wl(:,6),'color',[0.4 0 0.2]);title('pC6 (k=1.129)','FontSize',8);xlim([0 samples])
% set(p1pica_low,'Units','Inches');
% pos = get(p1pica_low,'Position');
% set(p1pica_low,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(p1pica_low,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\p1pica_low','-dpdf','-r0')
% 
% [El2,Wl2]=piCA(filt_sig_low,298); %1,009sec
% 
% p1pica_low2 = figure()
% subplot(3,2,1);plot(filt_sig_low*Wl2(:,1),'color',[0.502 0.502 1]);title('pC1 (k=298)','FontSize',8);xlim([0 samples])
% subplot(3,2,2);plot(filt_sig_low*Wl2(:,2),'color',[0.502 0 0]);title('pC2 (k=298)','FontSize',8);xlim([0 samples])
% subplot(3,2,3);plot(filt_sig_low*Wl2(:,3),'color',[0.85 0.7 1]);title('pC3 (k=298)','FontSize',8);xlim([0 samples])
% subplot(3,2,4);plot(filt_sig_low*Wl2(:,4),'color',[0.204 0 0]);title('pC4 (k=298)','FontSize',8);xlim([0 samples])
% subplot(3,2,5);plot(filt_sig_low*Wl2(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=298)','FontSize',8);xlim([0 samples])
% subplot(3,2,6);plot(filt_sig_low*Wl2(:,6),'color',[0.4 0 0.2]);title('pC6 (k=298)','FontSize',8);xlim([0 samples])
% set(p1pica_low2,'Units','Inches');
% pos = get(p1pica_low2,'Position');
% set(p1pica_low2,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(p1pica_low2,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\p1pica_low2','-dpdf','-r0')
% 
% 
% [El3,Wl3]=piCA(filt_sig_low,1);
% 
% p1pica_low3 = figure()
% subplot(3,2,1);plot(filt_sig_low*Wl3(:,1),'color',[0.502 0.502 1]);title('pC1 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,2);plot(filt_sig_low*Wl3(:,2),'color',[0.502 0 0]);title('pC2 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,3);plot(filt_sig_low*Wl3(:,3),'color',[0.85 0.7 1]);title('pC3 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,4);plot(filt_sig_low*Wl3(:,4),'color',[0.204 0 0]);title('pC4 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,5);plot(filt_sig_low*Wl3(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,6);plot(filt_sig_low*Wl3(:,6),'color',[0.4 0 0.2]);title('pC6 (k=1)','FontSize',8);xlim([0 samples])
% set(p1pica_low3,'Units','Inches');
% pos = get(p1pica_low3,'Position');
% set(p1pica_low3,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(p1pica_low3,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\p1pica_low3','-dpdf','-r0')
% 
% %% Bandpass filter
% Wnb1 = (2/Fs)*5;
% Wnb2 = (2/Fs)*26;
% bandf = fir1(100,[Wnb1 Wnb2],'bandpass'); 
% out2 = filtfilt(bandf,1,pre_sig);
% filt_sig_band = out2;
% 
% %periodicity error
% lag_band=[1,2.5*Fs+1];
% te=0:1/Fs:2.5;
% [erband,weband]=piCA(filt_sig_band,lag_band,'pre',[1,1,1]);
% 
% err1_band = figure()
% plot(te,erband(:,1),'color',[0.85 0.7 1]);title('Minimum Periodicity Error','FontSize',8);xlabel('Time lag (sec)')
% set(err1_band,'Units','Inches');
% pos = get(err1_band,'Position');
% set(err1_band,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(err1_band,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\err1_band','-dpdf','-r0')
% 
% %periodic components
% [Eb,Wb]=piCA(filt_sig_band,297); %1,006sec
% 
% p1pica_band = figure()
% subplot(3,2,1);plot(filt_sig_band*Wb(:,1),'color',[0.502 0.502 1]);title('pC1 (k=297)','FontSize',8);xlim([0 samples])
% subplot(3,2,2);plot(filt_sig_band*Wb(:,2),'color',[0.502 0 0]);title('pC2 (k=297)','FontSize',8);xlim([0 samples])
% subplot(3,2,3);plot(filt_sig_band*Wb(:,3),'color',[0.85 0.7 1]);title('pC3 (k=297)','FontSize',8);xlim([0 samples])
% subplot(3,2,4);plot(filt_sig_band*Wb(:,4),'color',[0.204 0 0]);title('pC4 (k=297)','FontSize',8);xlim([0 samples])
% subplot(3,2,5);plot(filt_sig_band*Wb(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=297)','FontSize',8);xlim([0 samples])
% subplot(3,2,6);plot(filt_sig_band*Wb(:,6),'color',[0.4 0 0.2]);title('pC6 (k=297)','FontSize',8);xlim([0 samples])
% set(p1pica_band,'Units','Inches');
% pos = get(p1pica_band,'Position');
% set(p1pica_band,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(p1pica_band,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\p1pica_band','-dpdf','-r0')
% 
% [Eb2,Wb2]=piCA(filt_sig_band,595); %2,016sec
% 
% p1pica_band2 = figure()
% subplot(3,2,1);plot(filt_sig_band*Wb2(:,1),'color',[0.502 0.502 1]);title('pC1 (k=595)','FontSize',8);xlim([0 samples])
% subplot(3,2,2);plot(filt_sig_band*Wb2(:,2),'color',[0.502 0 0]);title('pC2 (k=595)','FontSize',8);xlim([0 samples])
% subplot(3,2,3);plot(filt_sig_band*Wb2(:,3),'color',[0.85 0.7 1]);title('pC3 (k=595)','FontSize',8);xlim([0 samples])
% subplot(3,2,4);plot(filt_sig_band*Wb2(:,4),'color',[0.204 0 0]);title('pC4 (k=595)','FontSize',8);xlim([0 samples])
% subplot(3,2,5);plot(filt_sig_band*Wb2(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=595)','FontSize',8);xlim([0 samples])
% subplot(3,2,6);plot(filt_sig_band*Wb2(:,6),'color',[0.4 0 0.2]);title('pC6 (k=595)','FontSize',8);xlim([0 samples])
% set(p1pica_band2,'Units','Inches');
% pos = get(p1pica_band2,'Position');
% set(p1pica_band2,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(p1pica_band2,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\p1pica_band2','-dpdf','-r0')
% 
% [Eb3,Wb3]=piCA(filt_sig_band,1);
% 
% p1pica_band3 = figure()
% subplot(3,2,1);plot(filt_sig_band*Wb3(:,1),'color',[0.502 0.502 1]);title('pC1 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,2);plot(filt_sig_band*Wb3(:,2),'color',[0.502 0 0]);title('pC2 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,3);plot(filt_sig_band*Wb3(:,3),'color',[0.85 0.7 1]);title('pC3 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,4);plot(filt_sig_band*Wb3(:,4),'color',[0.204 0 0]);title('pC4 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,5);plot(filt_sig_band*Wb3(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=1)','FontSize',8);xlim([0 samples])
% subplot(3,2,6);plot(filt_sig_band*Wb3(:,6),'color',[0.4 0 0.2]);title('pC6 (k=1)','FontSize',8);xlim([0 samples])
% set(p1pica_band3,'Units','Inches');
% pos = get(p1pica_band3,'Position');
% set(p1pica_band3,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(p1pica_band3,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\p1pica_band3','-dpdf','-r0')
% 

%% Highpass filter
Wnh = (2/Fs)*60;
highf = fir1(100,Wnh,'high');
out3 = filtfilt(highf,1,pre_sig);
filt_sig_high = out3;

%periodicity error
lag_high=[1,2.5*Fs+1];
te=0:1/Fs:2.5;
[erhigh,wehigh]=piCA(filt_sig_high,lag_high,'pre',[1,1,1]);

err1_high = figure()
plot(te,erhigh(:,1),'color',[0.85 0.7 1]);title('Minimum Periodicity Error','FontSize',8);xlabel('Time lag (sec)')
set(err1_high,'Units','Inches');
pos = get(err1_high,'Position');
set(err1_high,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(err1_high,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\err1_high','-dpdf','-r0')

%periodic components
[Eh,Wh]=piCA(filt_sig_high,64); %0,2168sec

p1pica_high = figure()
subplot(3,2,1);plot(filt_sig_high*Wh(:,1),'color',[0.502 0.502 1]);title('pC1 (k=64)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(filt_sig_high*Wh(:,2),'color',[0.502 0 0]);title('pC2 (k=64)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(filt_sig_high*Wh(:,3),'color',[0.85 0.7 1]);title('pC3 (k=64)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(filt_sig_high*Wh(:,4),'color',[0.204 0 0]);title('pC4 (k=64)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(filt_sig_high*Wh(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=64)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(filt_sig_high*Wh(:,6),'color',[0.4 0 0.2]);title('pC6 (k=64)','FontSize',8);xlim([0 samples])
set(p1pica_high,'Units','Inches');
pos = get(p1pica_high,'Position');
set(p1pica_high,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1pica_high,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\p1pica_high','-dpdf','-r0')

[Eh2,Wh2]=piCA(filt_sig_high,76); %0,2575sec

p1pica_high2 = figure()
subplot(3,2,1);plot(filt_sig_high*Wh2(:,1),'color',[0.502 0.502 1]);title('pC1 (k=76)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(filt_sig_high*Wh2(:,2),'color',[0.502 0 0]);title('pC2 (k=76)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(filt_sig_high*Wh2(:,3),'color',[0.85 0.7 1]);title('pC3 (k=76)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(filt_sig_high*Wh2(:,4),'color',[0.204 0 0]);title('pC4 (k=76)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(filt_sig_high*Wh2(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=76)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(filt_sig_high*Wh2(:,6),'color',[0.4 0 0.2]);title('pC6 (k=76)','FontSize',8);xlim([0 samples])
set(p1pica_high2,'Units','Inches');
pos = get(p1pica_high2,'Position');
set(p1pica_high2,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1pica_high2,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\p1pica_high2','-dpdf','-r0')

[Eh3,Wh3]=piCA(filt_sig_high,1);

p1pica_high3 = figure()
subplot(3,2,1);plot(filt_sig_high*Wh3(:,1),'color',[0.502 0.502 1]);title('pC1 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(filt_sig_high*Wh3(:,2),'color',[0.502 0 0]);title('pC2 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(filt_sig_high*Wh3(:,3),'color',[0.85 0.7 1]);title('pC3 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(filt_sig_high*Wh3(:,4),'color',[0.204 0 0]);title('pC4 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(filt_sig_high*Wh3(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(filt_sig_high*Wh3(:,6),'color',[0.4 0 0.2]);title('pC6 (k=1)','FontSize',8);xlim([0 samples])
set(p1pica_high3,'Units','Inches');
pos = get(p1pica_high3,'Position');
set(p1pica_high3,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1pica_high3,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\filters\per1_pica_filters\p1pica_high3','-dpdf','-r0')



