get(0,'Factory')
set(0,'defaultfigurecolor',[1 1 1])

% Efarmogi stin perioxi 1
t1=3400636;
% t2=3462616-1; %15 sec
t2 = 3524596-1; %30 sec

[ch1,~]=audioread('t16-8-4132-1-apnea.wav',[t1 t2]); 
[ch2,~]=audioread('t16-8-4132-2-apnea.wav',[t1 t2]);
[ch3,~]=audioread('t16-8-4132-3-apnea.wav',[t1 t2]);
[ch4,~]=audioread('t16-8-4132-4-apnea.wav',[t1 t2]);
[ch5,~]=audioread('t16-8-4132-5-apnea.wav',[t1 t2]);
[ch6,~]=audioread('t16-8-4132-6-apnea.wav',[t1 t2]);
[ch7,~]=audioread('t16-8-4132-7-apnea.wav',[t1 t2]);
[ch8,~]=audioread('t16-8-4132-8-apnea.wav',[t1 t2]);
mix=[ch2 ch3 ch4 ch5 ch6 ch8]; 
mixed_sig=mix'; 

% Preprocessing and filtering
down_sig = downsample(mixed_sig',14);
Fs = 295.2;
samples=4428;
pre_sig = bsxfun(@minus,down_sig,mean(down_sig));
% Lowpass filter    
Wnl = (2/Fs)*3;
lowf = fir1(100,Wnl,'low');
out1 = filtfilt(lowf,1,pre_sig);
filt_sig_low = out1';
% Bandpass filter
Wnb1 = (2/Fs)*5;
Wnb2 = (2/Fs)*26;
bandf = fir1(100,[Wnb1 Wnb2],'bandpass');
out2 = filtfilt(bandf,1,pre_sig);
filt_sig_band = out2';
%*****************
x = pre_sig(:,1);
Saf = filt_sig_low(1,:);
Skf = filt_sig_band(1,:);
samplesn = 8855;

%%
meth1(x, Saf, Skf, samples);
meth2(x, Saf, Skf, samples,Fs);