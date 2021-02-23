% SIGNALS
samples=61980;
t1=3400636;
t2=3462616-1;

[ch1,f1]=audioread('t16-8-4132-1-apnea.wav',[t1 t2]); 
[ch2,f2]=audioread('t16-8-4132-2-apnea.wav',[t1 t2]);
[ch3,f3]=audioread('t16-8-4132-3-apnea.wav',[t1 t2]);
[ch4,f4]=audioread('t16-8-4132-4-apnea.wav',[t1 t2]);
[ch5,f5]=audioread('t16-8-4132-5-apnea.wav',[t1 t2]);
[ch6,f6]=audioread('t16-8-4132-6-apnea.wav',[t1 t2]);
[ch7,f7]=audioread('t16-8-4132-7-apnea.wav',[t1 t2]);
[ch8,f8]=audioread('t16-8-4132-8-apnea.wav',[t1 t2]);

mixedsig=[ch2';ch3';ch4';ch5';ch6';ch8'];

% ICA

%pow3
[icasig_pow3s] = fastica (mixedsig,'approach','symm','g','pow3');
[icasigd_pow3d] = fastica (mixedsig,'approach','defl','g','pow3');

p1_pow3s=figure()
subplot(3,2,1);plot(icasig_pow3s(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('IC1 (pow3-symm)','FontSize',8)
subplot(3,2,2);plot(icasig_pow3s(2,:),'color',[0.502 0 0]);xlim([0 samples]);title('IC2 (pow3-symm)','FontSize',8)
subplot(3,2,3);plot(icasig_pow3s(3,:),'color',[0.85 0.7 1]);xlim([0 samples]);title('IC3 (pow3-symm)','FontSize',8)
subplot(3,2,4);plot(icasig_pow3s(4,:),'color',[0.204 0 0]);xlim([0 samples]);title('IC4 (pow3-symm)','FontSize',8)
subplot(3,2,5);plot(icasig_pow3s(5,:),'color',[0.4 0.4 0.4]);xlim([0 samples]);title('IC5 (pow3-symm)','FontSize',8)
subplot(3,2,6);plot(icasig_pow3s(6,:),'color',[0.4 0 0.2]);xlim([0 samples]);title('IC6 (pow3-symm)','FontSize',8)
set(p1_pow3s,'Units','Inches');
pos = get(p1_pow3s,'Position');
set(p1_pow3s,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_pow3s,'C:\Users\Schnitzel\Desktop\thesis\images\ica\xwris_epekserg\per1\p1_pow3s','-dpdf','-r0')

p1_pow3d=figure()
subplot(3,2,1);plot(icasigd_pow3d(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('IC1 (pow3-defl)','FontSize',8)
subplot(3,2,2);plot(icasigd_pow3d(2,:),'color',[0.502 0 0]);xlim([0 samples]);title('IC2 (pow3-defl)','FontSize',8)
subplot(3,2,3);plot(icasigd_pow3d(3,:),'color',[0.85 0.7 1]);xlim([0 samples]);title('IC3 (pow3-defl)','FontSize',8)
subplot(3,2,4);plot(icasigd_pow3d(4,:),'color',[0.204 0 0]);xlim([0 samples]);title('IC4 (pow3-defl)','FontSize',8)
subplot(3,2,5);plot(icasigd_pow3d(5,:),'color',[0.4 0.4 0.4]);xlim([0 samples]);title('IC5 (pow3-defl)','FontSize',8)
subplot(3,2,6);plot(icasigd_pow3d(6,:),'color',[0.4 0 0.2]);xlim([0 samples]);title('IC6 (pow3-defl)','FontSize',8)
set(p1_pow3d,'Units','Inches');
pos = get(p1_pow3d,'Position');
set(p1_pow3d,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_pow3d,'C:\Users\Schnitzel\Desktop\thesis\images\ica\xwris_epekserg\per1\p1_pow3d','-dpdf','-r0')

%tanh
[icasig_tanhs] = fastica (mixedsig,'approach','symm','g','tanh');
[icasigd_tanhd] = fastica (mixedsig,'approach','defl','g','tanh');

p1_tanhs=figure()
subplot(3,2,1);plot(icasig_tanhs(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('IC1 (tanh-symm)','FontSize',8)
subplot(3,2,2);plot(icasig_tanhs(2,:),'color',[0.502 0 0]);xlim([0 samples]);title('IC2 (tanh-symm)','FontSize',8)
subplot(3,2,3);plot(icasig_tanhs(3,:),'color',[0.85 0.7 1]);xlim([0 samples]);title('IC3 (tanh-symm)','FontSize',8)
subplot(3,2,4);plot(icasig_tanhs(4,:),'color',[0.204 0 0]);xlim([0 samples]);title('IC4 (tanh-symm)','FontSize',8)
subplot(3,2,5);plot(icasig_tanhs(5,:),'color',[0.4 0.4 0.4]);xlim([0 samples]);title('IC5 (tanh-symm)','FontSize',8)
subplot(3,2,6);plot(icasig_tanhs(6,:),'color',[0.4 0 0.2]);xlim([0 samples]);title('IC6 (tanh-symm)','FontSize',8)
set(p1_tanhs,'Units','Inches');
pos = get(p1_tanhs,'Position');
set(p1_tanhs,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_tanhs,'C:\Users\Schnitzel\Desktop\thesis\images\ica\xwris_epekserg\per1\p1_tanhs','-dpdf','-r0')

p1_tanhd=figure()
subplot(3,2,1);plot(icasigd_tanhd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('IC1 (tanh-defl)','FontSize',8)
subplot(3,2,2);plot(icasigd_tanhd(2,:),'color',[0.502 0 0]);xlim([0 samples]);title('IC2 (tanh-defl)','FontSize',8)
subplot(3,2,3);plot(icasigd_tanhd(3,:),'color',[0.85 0.7 1]);xlim([0 samples]);title('IC3 (tanh-defl)','FontSize',8)
subplot(3,2,4);plot(icasigd_tanhd(4,:),'color',[0.204 0 0]);xlim([0 samples]);title('IC4 (tanh-defl)','FontSize',8)
subplot(3,2,5);plot(icasigd_tanhd(5,:),'color',[0.4 0.4 0.4]);xlim([0 samples]);title('IC5 (tanh-defl)','FontSize',8)
subplot(3,2,6);plot(icasigd_tanhd(6,:),'color',[0.4 0 0.2]);xlim([0 samples]);title('IC6 (tanh-defl)','FontSize',8)
set(p1_tanhd,'Units','Inches');
pos = get(p1_tanhd,'Position');
set(p1_tanhd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_tanhd,'C:\Users\Schnitzel\Desktop\thesis\images\ica\xwris_epekserg\per1\p1_tanhd','-dpdf','-r0')

%gauss
[icasig_gausss] = fastica (mixedsig,'approach','symm','g','gauss');
[icasigd_gaussd] = fastica (mixedsig,'approach','defl','g','gauss');

p1_gausss=figure()
subplot(3,2,1);plot(icasig_gausss(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('IC1 (gauss-symm)','FontSize',8)
subplot(3,2,2);plot(icasig_gausss(2,:),'color',[0.502 0 0]);xlim([0 samples]);title('IC2 (gauss-symm)','FontSize',8)
subplot(3,2,3);plot(icasig_gausss(3,:),'color',[0.85 0.7 1]);xlim([0 samples]);title('IC3 (gauss-symm)','FontSize',8)
subplot(3,2,4);plot(icasig_gausss(4,:),'color',[0.204 0 0]);xlim([0 samples]);title('IC4 (gauss-symm)','FontSize',8)
subplot(3,2,5);plot(icasig_gausss(5,:),'color',[0.4 0.4 0.4]);xlim([0 samples]);title('IC5 (gauss-symm)','FontSize',8)
subplot(3,2,6);plot(icasig_gausss(6,:),'color',[0.4 0 0.2]);xlim([0 samples]);title('IC6 (gauss-symm)','FontSize',8)
set(p1_gausss,'Units','Inches');
pos = get(p1_gausss,'Position');
set(p1_gausss,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_gausss,'C:\Users\Schnitzel\Desktop\thesis\images\ica\xwris_epekserg\per1\p1_gausss','-dpdf','-r0')

p1_gaussd=figure()
subplot(3,2,1);plot(icasigd_gaussd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('IC1 (gauss-defl)','FontSize',8)
subplot(3,2,2);plot(icasigd_gaussd(2,:),'color',[0.502 0 0]);xlim([0 samples]);title('IC2 (gauss-defl)','FontSize',8)
subplot(3,2,3);plot(icasigd_gaussd(3,:),'color',[0.85 0.7 1]);xlim([0 samples]);title('IC3 (gauss-defl)','FontSize',8)
subplot(3,2,4);plot(icasigd_gaussd(4,:),'color',[0.204 0 0]);xlim([0 samples]);title('IC4 (gauss-defl)','FontSize',8)
subplot(3,2,5);plot(icasigd_gaussd(5,:),'color',[0.4 0.4 0.4]);xlim([0 samples]);title('IC5 (gauss-defl)','FontSize',8)
subplot(3,2,6);plot(icasigd_gaussd(6,:),'color',[0.4 0 0.2]);xlim([0 samples]);title('IC6 (gauss-defl)','FontSize',8)
set(p1_gaussd,'Units','Inches');
pos = get(p1_gaussd,'Position');
set(p1_gaussd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_gaussd,'C:\Users\Schnitzel\Desktop\thesis\images\ica\xwris_epekserg\per1\p1_gaussd','-dpdf','-r0')

skew
[icasig_skews] = fastica (mixedsig,'approach','symm','g','skew');
[icasigd_skewd] = fastica (mixedsig,'approach','defl','g','skew');

p1_skews=figure()
subplot(3,2,1);plot(icasig_skews(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('IC1 (skew-symm)','FontSize',8)
subplot(3,2,2);plot(icasig_skews(2,:),'color',[0.502 0 0]);xlim([0 samples]);title('IC2 (skew-symm)','FontSize',8)
subplot(3,2,3);plot(icasig_skews(3,:),'color',[0.85 0.7 1]);xlim([0 samples]);title('IC3 (skew-symm)','FontSize',8)
subplot(3,2,4);plot(icasig_skews(4,:),'color',[0.204 0 0]);xlim([0 samples]);title('IC4 (skew-symm)','FontSize',8)
subplot(3,2,5);plot(icasig_skews(5,:),'color',[0.4 0.4 0.4]);xlim([0 samples]);title('IC5 (skew-symm)','FontSize',8)
subplot(3,2,6);plot(icasig_skews(6,:),'color',[0.4 0 0.2]);xlim([0 samples]);title('IC6 (skew-symm)','FontSize',8)
set(p1_skews,'Units','Inches');
pos = get(p1_skews,'Position');
set(p1_skews,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_skews,'C:\Users\Schnitzel\Desktop\thesis\images\ica\xwris_epekserg\per1\p1_skews','-dpdf','-r0')

p1_skewd=figure()
subplot(3,2,1);plot(icasigd_skewd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('IC1 (skew-defl)','FontSize',8)
subplot(3,2,2);plot(icasigd_skewd(2,:),'color',[0.502 0 0]);xlim([0 samples]);title('IC2 (skew-defl)','FontSize',8)
subplot(3,2,3);plot(icasigd_skewd(3,:),'color',[0.85 0.7 1]);xlim([0 samples]);title('IC3 (skew-defl)','FontSize',8)
subplot(3,2,4);plot(icasigd_skewd(4,:),'color',[0.204 0 0]);xlim([0 samples]);title('IC4 (skew-defl)','FontSize',8)
subplot(3,2,5);plot(icasigd_skewd(5,:),'color',[0.4 0.4 0.4]);xlim([0 samples]);title('IC5 (skew-defl)','FontSize',8)
subplot(3,2,6);plot(icasigd_skewd(6,:),'color',[0.4 0 0.2]);xlim([0 samples]);title('IC6 (skew-defl)','FontSize',8)
set(p1_skewd,'Units','Inches');
pos = get(p1_skewd,'Position');
set(p1_skewd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p1_skewd,'C:\Users\Schnitzel\Desktop\thesis\images\ica\xwris_epekserg\per1\p1_skewd','-dpdf','-r0')
