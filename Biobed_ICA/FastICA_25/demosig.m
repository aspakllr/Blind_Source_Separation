function [mixedsig]=demosig();
%
% function [sig,mixedsig]=demosig();
% 
% Returns artificially generated test signals, sig, and mixed
% signals, mixedsig. Signals are row vectors of
% matrices. Input mixedsig to FastICA to see how it works.

% @(#)$Id: demosig.m,v 1.2 2003/04/05 14:23:57 jarmo Exp $

get(0,'Factory')
set(0,'defaultfigurecolor',[1 1 1])

%create source signals (independent components)
% N=500; %data size
% 
% v=[0:N-1];
% sig=[];
% sig(1,:)=sin(v/2); %sinusoid
% sig(2,:)=((rem(v,23)-11)/9).^5; %funny curve
% sig(3,:)=((rem(v,27)-13)/9); %saw-tooth
% sig(4,:)=((rand(1,N)<.5)*2-1).*log(rand(1,N)); %impulsive noise
% 
% for t=1:4
% sig(t,:)=sig(t,:)/std(sig(t,:));
% end
% 
% %remove mean (not really necessary)
% 
% [sig mean]=remmean(sig);
% 
% %create mixtures
% 
% Aorig=rand(size(sig,1));
% mixedsig=(Aorig*sig);

%% Texnita simata Makrugiwrgou

% % dokimes_1
% t=1:0.01:30;
% 
% s1=3+square(2*t);  %row vectors
% s2=1+4*sin(t);
% s3 = 0.5 + 0.1 * randn(size(t, 2), 1);
% s3=s3';
% sig=[s1;s2;s3];
% w=[0.1 0.9 0.1;0.7 0.2 0.3 ; 0.4 0.4 0.6];
% mixedsig=w*sig; %mixed signals


%% Dokimes_Katsios
% 
% T1=0.2;
% T2=0.46;
% T3=1.03;
% 
% fs=1000;
% t=0:1/fs:5;
% 
% %Source signals
% s1=square(2*pi*t/T1);
% s2=abs(sin(pi*t/T2));
% s3=sawtooth(2*pi*t/T3);
% 
% %Mixed signals
% A=[-0.5831 -1.4147 -0.6466;-0.0932 1.1792 -1.9842;0.3168 -0.2056 0.3704];
% sig=[s1;s2;s3];
% mixedsig=A*sig;

%% Biobed signals

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

%% mallon den douleuei epeidi den exw orisei ti variable sig poy tin pairnei ws eksodo 
% mporw na svinw to sig apo tin eksodo tis sunartisis
%% Check signals

% Channel:2
% Time: 1h 16min 30sec - 1h 16min 42secs
% t1=18965880;  
% t2=19015464-1;
% samples=49584;
% [s,f2] = audioread('t16-8-4132-2-apnea.wav',[t1 t2]);
% 
% noise = 0.2*(rand(1,samples)-0.5);
% 
% x1 = s + noise';
% x2 = 0.9*s + 0.5*noise';
% mixedsig = [x1'; x2'];

%% Preprocessed and filtered signals
% 
% t1=77888200;
% t2=77950180-1;
% 
% [ch1,f1]=audioread('t16-8-4132-1-apnea.wav',[t1 t2]); 
% [ch2,f2]=audioread('t16-8-4132-2-apnea.wav',[t1 t2]);
% [ch3,f3]=audioread('t16-8-4132-3-apnea.wav',[t1 t2]);
% [ch4,f4]=audioread('t16-8-4132-4-apnea.wav',[t1 t2]);
% [ch5,f5]=audioread('t16-8-4132-5-apnea.wav',[t1 t2]);
% [ch6,f6]=audioread('t16-8-4132-6-apnea.wav',[t1 t2]);
% [ch7,f7]=audioread('t16-8-4132-7-apnea.wav',[t1 t2]);
% [ch8,f8]=audioread('t16-8-4132-8-apnea.wav',[t1 t2]);
% 
% mixed_sig=[ch2';ch3';ch4';ch5';ch6']; %kathe grammi einai ena sima
% 
% doub_sig=2*mixed_sig;
% down_sig = downsample(doub_sig',14);
% 
% % down_sig = downsample(mixed_sig',14);
% 
% pre_sig = bsxfun(@minus,down_sig,mean(down_sig));
% Fs = 295.2;

% % Lowpass filter 
% Wnl = (2/Fs)*3;
% lowf = fir1(100,Wnl,'low');
% out1 = filtfilt(lowf,1,pre_sig);
% filt_sig_low = out1';
% 
% mixedsig = filt_sig_low;

% % Bandpass filter
% Wnb1 = (2/Fs)*5;
% Wnb2 = (2/Fs)*26;
% bandf = fir1(100,[Wnb1 Wnb2],'bandpass'); 
% out2 = filtfilt(bandf,1,pre_sig);
% filt_sig_band = out2';
% 
% mixedsig = filt_sig_band;
% 
% % Highpass filter
% Wnh = (2/Fs)*60;
% highf = fir1(100,Wnh,'high');
% 
% out3 = filtfilt(highf,1,pre_sig);
% filt_sig_high = out3';
% 
% mixedsig = filt_sig_high;

