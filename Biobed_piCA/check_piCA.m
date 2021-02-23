% Channel:2
% Time: 1h 16min 30sec - 1h 16min 42secs polu komple,den exei thorivo
t1=18965880;  
t2=19015464-1;
samples=49584;
[s,f2] = audioread('t16-8-4132-2-apnea.wav',[t1 t2]);
fs=4132;

noise = 0.2*(rand(1,samples)-0.5);

x1 = s + noise';
x2 = 0.9*s + 0.5*noise';
mix = [x1 x2];
mixed_sig=mix';

%periodicity error
lag=[1,2.5*fs+1];
te=0:1/fs:2.5;
[er]=piCA(mix,lag,'pre',[1,1,1]);
minerr= min(er(:,2));

figure()
plot(te,er(:,1),'color',[0.32 0.19 0.19]);title('Periodicity Error');

[E,W]=piCA(mix,260);

checkpica=figure()
set(gcf,'name','Periodic Components','numbertitle','off')
subplot(2,1,1);plot(mix*W(:,1),'color',[0.502 0.502 1])
title('Periodic Components','FontSize',8)
axis([0 samples -4 4])
subplot(2,1,2);plot(mix*W(:,2),'color',[0.502 0 0])
axis([0 samples -2 2])
set(checkpica,'Units','Inches');
pos = get(checkpica,'Position');
set(checkpica,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(checkpica,'C:\Users\Schnitzel\Desktop\thesis\images\check\checkpica','-dpdf','-r0')