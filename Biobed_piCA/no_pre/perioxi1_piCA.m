clear all;
close all;

%Time:13min 43sec - 13min 58sec
t1=3400636;
t2=3462616-1;
samples=61980;
fs=4132;

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

% %periodicity error
% lag=[1,5*fs+1];
% te=0:1/fs:5;
% [er,we]=piCA(mixed_sig,lag,'pre',[1,1,1]);
% 
% err1 = figure()
% plot(te,er(:,1),'color',[0.85 0.7 1]);title('Minimum Periodicity Error','FontSize',8);xlabel('Time lag (sec)')
% set(err1,'Units','Inches');
% pos = get(err1,'Position');
% set(err1,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(err1,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\xwris_epekserg\err1','-dpdf','-r0')

%periodic components
[E,W]=piCA(mixed_sig,15800); %3,824sec

p1pica = figure()
subplot(3,2,1);plot(mixed_sig*W(:,1),'color',[0.502 0.502 1]);title('pC1 (k=15.800)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(mixed_sig*W(:,2),'color',[0.502 0 0]);title('pC2 (k=15.800)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(mixed_sig*W(:,3),'color',[0.85 0.7 1]);title('pC3 (k=15.800)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(mixed_sig*W(:,4),'color',[0.204 0 0]);title('pC4 (k=15.800)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(mixed_sig*W(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=15.800)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(mixed_sig*W(:,6),'color',[0.4 0 0.2]);title('pC6 (k=15.800)','FontSize',8);xlim([0 samples])
set(p1pica,'Units','Inches');
pos = get(p1pica,'Position');
set(p1pica,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1pica,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\xwris_epekserg\p1pica','-dpdf','-r0')

[E2,W2]=piCA(mixed_sig,3324);%0.8045sec

p1pica2=figure()
subplot(3,2,1);plot(mixed_sig*W2(:,1),'color',[0.502 0.502 1]);title('pC1 (k=3.324)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(mixed_sig*W2(:,2),'color',[0.502 0 0]);title('pC2 (k=3.324)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(mixed_sig*W2(:,3),'color',[0.85 0.7 1]);title('pC3 (k=3.324)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(mixed_sig*W2(:,4),'color',[0.204 0 0]);title('pC4 (k=3.324)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(mixed_sig*W2(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=3.324)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(mixed_sig*W2(:,6),'color',[0.4 0 0.2]);title('pC6 (k=3.324)','FontSize',8);xlim([0 samples])
set(p1pica2,'Units','Inches');
pos = get(p1pica2,'Position');
set(p1pica2,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1pica2,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\xwris_epekserg\p1pica2','-dpdf','-r0')

[E3,W3]=piCA(mixed_sig,1);

p1pica3=figure()
subplot(3,2,1);plot(mixed_sig*W3(:,1),'color',[0.502 0.502 1]);title('pC1 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,2);plot(mixed_sig*W3(:,2),'color',[0.502 0 0]);title('pC2 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,3);plot(mixed_sig*W3(:,3),'color',[0.85 0.7 1]);title('pC3 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,4);plot(mixed_sig*W3(:,4),'color',[0.204 0 0]);title('pC4 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,5);plot(mixed_sig*W3(:,5),'color',[0.4 0.4 0.4]);title('pC5 (k=1)','FontSize',8);xlim([0 samples])
subplot(3,2,6);plot(mixed_sig*W3(:,6),'color',[0.4 0 0.2]);title('pC6 (k=1)','FontSize',8);xlim([0 samples])
set(p1pica3,'Units','Inches');
pos = get(p1pica3,'Position');
set(p1pica3,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1pica3,'C:\Users\Schnitzel\Desktop\thesis\images\piCA\xwris_epekserg\p1pica3','-dpdf','-r0')


