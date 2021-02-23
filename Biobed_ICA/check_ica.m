% Channel:2
% Time: 1h 16min 30sec - 1h 16min 42secs polu komple,den exei thorivo
t1=18965880;  
t2=19015464-1;
samples=49584;
[s,f2] = audioread('t16-8-4132-2-apnea.wav',[t1 t2]);

noise = 0.2*(rand(1,samples)-0.5);

x1 = s + noise';
x2 = 0.9*s + 0.5*noise';
mix = [x1 x2];
mixedsig=mix';

%pow3
[icasig_pow3s] = fastica (mixedsig,'approach','symm','g','pow3','numofIC',2);
[icasigd_pow3d] = fastica (mixedsig,'approach','defl','g','pow3','numofIC',2);
% 
% check_pow3s=figure()
% subplot(2,1,1);plot(icasig_pow3s(1,:),'color',[0.502 0 0]);xlim([0 samples]);title('Independent Components (pow3-symm)','FontSize',8)
% subplot(2,1,2);plot(icasig_pow3s(2,:),'color',[0.502 0.502 1]);xlim([0 samples])
% set(check_pow3s,'Units','Inches');
% pos = get(check_pow3s,'Position');
% set(check_pow3s,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(check_pow3s,'C:\Users\Schnitzel\Desktop\thesis\images\check\check_pow3s','-dpdf','-r0')

% check_pow3d=figure()
% subplot(2,1,1);plot(icasigd_pow3d(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (pow3-defl)','FontSize',8)
% subplot(2,1,2);plot(icasigd_pow3d(2,:),'color',[0.502 0 0]);xlim([0 samples])
% set(check_pow3d,'Units','Inches');
% pos = get(check_pow3d,'Position');
% set(check_pow3d,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(check_pow3d,'C:\Users\Schnitzel\Desktop\thesis\images\check\check_pow3d','-dpdf','-r0')

%tanh
[icasig_tanhs] = fastica (mixedsig,'approach','symm','g','tanh','numofIC',2);
[icasigd_tanhd] = fastica (mixedsig,'approach','defl','g','tanh','numofIC',2);

% check_tanhs=figure()
% subplot(2,1,1);plot(icasig_tanhs(1,:),'color',[0.502 0 0]);xlim([0 samples]);title('Independent Components (tanh-symm)','FontSize',8)
% subplot(2,1,2);plot(icasig_tanhs(2,:),'color',[0.502 0.502 1]);xlim([0 samples])
% set(check_tanhs,'Units','Inches');
% pos = get(check_tanhs,'Position');
% set(check_tanhs,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(check_tanhs,'C:\Users\Schnitzel\Desktop\thesis\images\check\check_tanhs','-dpdf','-r0')
% 
% check_tanhd=figure()
% subplot(2,1,1);plot(icasigd_tanhd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (tanh-defl)','FontSize',8)
% subplot(2,1,2);plot(icasigd_tanhd(2,:),'color',[0.502 0 0]);xlim([0 samples])
% set(check_tanhd,'Units','Inches');
% pos = get(check_tanhd,'Position');
% set(check_tanhd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(check_tanhd,'C:\Users\Schnitzel\Desktop\thesis\images\check\check_tanhd','-dpdf','-r0')

%gauss
[icasig_gausss] = fastica (mixedsig,'approach','symm','g','gauss','numofIC',2);
[icasigd_gaussd] = fastica (mixedsig,'approach','defl','g','gauss','numofIC',2);

% check_gausss=figure()
% subplot(2,1,1);plot(icasig_gausss(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (gauss-symm)','FontSize',8)
% subplot(2,1,2);plot(icasig_gausss(2,:),'color',[0.502 0 0]);xlim([0 samples])
% set(check_gausss,'Units','Inches');
% pos = get(check_gausss,'Position');
% set(check_gausss,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(check_gausss,'C:\Users\Schnitzel\Desktop\thesis\images\check\check_gausss','-dpdf','-r0')
% 
% check_gaussd=figure()
% subplot(2,1,1);plot(icasigd_gaussd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (gauss-defl)','FontSize',8)
% subplot(2,1,2);plot(icasigd_gaussd(2,:),'color',[0.502 0 0]);xlim([0 samples])
% set(check_gaussd,'Units','Inches');
% pos = get(check_gaussd,'Position');
% set(check_gaussd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(check_gaussd,'C:\Users\Schnitzel\Desktop\thesis\images\check\check_gaussd','-dpdf','-r0')

%skew
[icasig_skews] = fastica (mixedsig,'approach','symm','g','skew','numofIC',2);
[icasigd_skewd] = fastica (mixedsig,'approach','defl','g','skew','numofIC',2);

check_skews=figure()
subplot(2,1,1);plot(icasig_skews(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (skew-symm)','FontSize',8)
subplot(2,1,2);plot(icasig_skews(2,:),'color',[0.502 0 0]);xlim([0 samples])
set(check_skews,'Units','Inches');
pos = get(check_skews,'Position');
set(check_skews,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(check_skews,'C:\Users\Schnitzel\Desktop\thesis\images\check\check_skews','-dpdf','-r0')
% 
% check_skewd=figure()
% subplot(2,1,1);plot(icasigd_skewd(1,:),'color',[0.502 0.502 1]);xlim([0 samples]);title('Independent Components (skew-defl)','FontSize',8)
% subplot(2,1,2);plot(icasigd_skewd(2,:),'color',[0.502 0 0]);xlim([0 samples])
% set(check_skewd,'Units','Inches');
% pos = get(check_skewd,'Position');
% set(check_skewd,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(check_skewd,'C:\Users\Schnitzel\Desktop\thesis\images\check\check_skewd','-dpdf','-r0')
