%Efarmogi sthn perioxi 2

get(0,'Factory')
set(0,'defaultfigurecolor',[1 1 1])

t1=41976988;
t2=42100948-1; %30 sec

[ch1,f1]=audioread('t16-8-4132-1-apnea.wav',[t1 t2]); 
[ch2,f2]=audioread('t16-8-4132-2-apnea.wav',[t1 t2]);
[ch3,f3]=audioread('t16-8-4132-3-apnea.wav',[t1 t2]);
[ch4,f4]=audioread('t16-8-4132-4-apnea.wav',[t1 t2]);
[ch5,f5]=audioread('t16-8-4132-5-apnea.wav',[t1 t2]);
[ch6,f6]=audioread('t16-8-4132-6-apnea.wav',[t1 t2]);
[ch7,f7]=audioread('t16-8-4132-7-apnea.wav',[t1 t2]);
[ch8,f8]=audioread('t16-8-4132-8-apnea.wav',[t1 t2]);
mix=[ch3 ch4 ch5 ch6 ch7];
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

x = pre_sig(:,4); %ch6
Saf = filt_sig_low(4,:);
Skf = filt_sig_band(4,:);
samplesn = 8855;

%%
meth1(x, Saf, Skf, samples);
meth2(x, Saf, Skf, samples,Fs);