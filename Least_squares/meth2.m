function [Sa_out2, Sk_out2]= meth2(x,Saf,Skf,samples,Fs)

%Determine period
[autocork,lagsk] = xcorr(Skf,'coeff');
[autocora,lagsa] = xcorr(Saf,'coeff');
%[autocorx,lagsx] = xcorr(Saf,Skf);

[pksha,lcsha] = findpeaks(autocora);
shorta = mean(diff(lcsha))/Fs;
Ta = round(shorta*Fs)

[pkshk,lcshk] = findpeaks(autocork);
shortk = mean(diff(lcshk))/Fs;
[pklgk,lclgk] = findpeaks(autocork,'MinPeakDistance',ceil(shortk)*Fs);
longk = mean(diff(lclgk))/Fs;
Tk = round(shortk * Fs)

% autocorb=figure
% plot(lagsa/Fs,autocora);title('Autocorrelation of breath signal');axis([0 15 -1 1]);xlabel('Lag(seconds)');
% hold on;pks = plot(lagsa(lcsha)/Fs,pksha,'or');
% set(autocorb,'Units','Inches');
% pos = get(autocorb,'Position');
% set(autocorb,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(autocorb,'C:\Users\Schnitzel\Desktop\thesis\images\methods\autocorr_br','-dpdf','-r0')
% 
% autocorh=figure
% plot(lagsk/Fs,autocork);title('Autocorrelation of heart signal');axis([0 15 -1 1]);xlabel('Lag(seconds)')
% hold on;pks = plot(lagsk(lcshk)/Fs,pkshk,'or');
% set(autocorh,'Units','Inches');
% pos = get(autocorh,'Position');
% set(autocorh,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(autocorh,'C:\Users\Schnitzel\Desktop\thesis\images\methods\autocorr_h','-dpdf','-r0')

Aa2 = [3 1;1 3];
A2 = inv(Aa2);

for n=1:samples
Sk_out2(1,n) = A2(1,1)*(x(n)+Skf(n)+Skf(n+Tk))+A2(1,2)*(x(n)+Saf(n)+Saf(n+Ta));
Sa_out2(1,n) = A2(2,1)*(x(n)+Skf(n)+Skf(n+Tk))+A2(2,2)*(x(n)+Saf(n)+Saf(n+Ta));
end

figure()
subplot(2,1,1);plot(Sa_out2,'color',[0.502 0.502 1]);title('Second method');xlim([0 samples]);
subplot(2,1,2);plot(Sk_out2,'color',[0.502 0 0]);xlim([0 samples]);

end