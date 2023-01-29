% Read signal 1 and pre-process it
[s1, fs1] = audioread("signal1.wav");
s1 = s1(:,1) + s1(:,2);
[len1, BW1, t1, f1, ffts1]=preprocessing(s1,fs1);
% Read signal 2 and pre-process it
[s2, fs2] = audioread("signal2.wav");
s2 = s2(:,1) + s2(:,2);
[len2, BW2, t2, f2, ffts2]=preprocessing(s2,fs2);
% Read signal 3 and pre-process it
[s3, fs3] = audioread("signal3.wav");
s3 = s3(:,1) + s3(:,2);
[len3, BW3, t3, f3, ffts3]=preprocessing(s3,fs3);
% Plot original signals in time domain
plotSignal(t1,s1,'Original signal 1 in time domain', 'Time(s)', 'Amplitude');
plotSignal(t2,s2,'Original signal 2 in time domain', 'Time(s)', 'Amplitude');
plotSignal(t3,s3,'Original signal 3 in time domain', 'Time(s)', 'Amplitude');
% Plot original signals in freq domain
plotSignal(f1,fftshift(ffts1),'Original signal 1 in freq domain', 'Frequency(Hz)', 'Magnitude');
plotSignal(f2,fftshift(ffts2),'Original signal 2 in freq domain', 'Frequency(Hz)', 'Magnitude');
plotSignal(f3,fftshift(ffts3),'Original signal 3 in freq domain', 'Frequency(Hz)', 'Magnitude');
% Resample original signals
fs_new=650000;
[s1_resampled,len_res1,t_res1]=resampleSignal(s1,fs_new,fs1);
[s2_resampled,len_res2,t_res2]=resampleSignal(s2,fs_new,fs2);
[s3_resampled,len_res3,t_res3]=resampleSignal(s3,fs_new,fs3);
% Modulate signals
fc1=160000;
fc2=350000;
carrier1 = cos(2*pi*fc1* t_res1);
[s1_modulated, len_ms1,fm1,fftms1]=Modulation(carrier1,s1_resampled,fs_new);
carrier2 = cos(2*pi*fc2* t_res2);
[s2_modulated, len_ms2,fm2,fftms2]=Modulation(carrier2,s2_resampled,fs_new);
carrier3 = sin(2*pi*fc2* t_res3);
[s3_modulated, len_ms3,fm3,fftms3]=Modulation(carrier3,s3_resampled,fs_new);
% Plot modulated signals in freq domain
plotSignal(fm1,fftshift(fftms1),'Modulated signal 1 in freq domain', 'Frequency(Hz)', 'Magnitude');
plotSignal(fm2,fftshift(fftms2),'Modulated signal 2 in freq domain', 'Frequency(Hz)', 'Magnitude');
plotSignal(fm3,fftshift(fftms3),'Modulated signal 3 in freq domain', 'Frequency(Hz)', 'Magnitude');
% Sum modulated signals
max_len = max(len_ms1, max(len_ms2, len_ms3));
ss1 = [s1_modulated;zeros(max_len-len_ms1, 1)];
ss2 = [s2_modulated;zeros(max_len-len_ms2, 1)];
ss3 = [s3_modulated;zeros(max_len-len_ms3, 1)];
modulated_signal_sum = ss1 + ss2 + ss3;
t_sum = (0: max_len - 1) * (1 / fs_new);
f_sum = (-max_len/2 : max_len/2 - 1) * (fs_new / max_len);
fft_sum = abs(fft(modulated_signal_sum));
% plot the final signal
plotSignal(t_sum,modulated_signal_sum,'Modulated final signal in time domain', 'Time(s)', 'Amplitude');
plotSignal(f_sum,fftshift(fft_sum),'Modulated final signal in freq domain', 'Frequency(Hz)', 'Magnitude');
% Demodulate final signal to restore the 3 signals
sync_carrier1 = cos(2*pi*fc1 * t_sum);
[fftds1]=Demodulation(modulated_signal_sum, sync_carrier1, len1, fs1, fs_new ,100000, 'Demodulated signal 1',t_sum,f1,'1');
sync_carrier2 = cos(2*pi*fc2 * t_sum);
[fftds2]=Demodulation(modulated_signal_sum, sync_carrier2, len2, fs2, fs_new ,7000, 'Demodulated signal 2',t_sum,f2,'2');
sync_carrier3 = sin(2*pi*fc2 * t_sum);
[fftds3]=Demodulation(modulated_signal_sum, sync_carrier3, len3, fs3, fs_new ,25000, 'Demodulated signal 3',t_sum,f3,'3');
% Demodulate the final signal with phase shift 10
phase10_carrier1 = cos(2*pi*fc1*t_sum + (10 * pi) / 180);
[fftds1_10]=Demodulation(modulated_signal_sum, phase10_carrier1, len1, fs1, fs_new ,100000, 'Demodulated 10 signal 1',t_sum,f1,'1 (phase shift 10)');
phase10_carrier2 = cos(2*pi*fc2*t_sum + (10 * pi) / 180);
[fftds2_10]=Demodulation(modulated_signal_sum, phase10_carrier2, len2, fs2, fs_new ,7000, 'Demodulated 10 signal 2',t_sum,f2,'2 (phase shift 10)');
phase10_carrier3 = sin(2*pi*fc2*t_sum + (10 * pi) / 180);
[fftds3_10]=Demodulation(modulated_signal_sum, phase10_carrier3, len3, fs3, fs_new ,25000, 'Demodulated 10 signal 3',t_sum,f3,'3 (phase shift 10)');
% Demodulate the final signal with phase shift 30
phase30_carrier1 = cos(2*pi*fc1*t_sum + (30 * pi) / 180);
[fftds1_30]=Demodulation(modulated_signal_sum, phase30_carrier1, len1, fs1, fs_new ,100000, 'Demodulated 30 signal 1',t_sum,f1,'1 (phase shift 30)');
phase30_carrier2 = cos(2*pi*fc2*t_sum + (30 * pi) / 180);
[fftds2_30]=Demodulation(modulated_signal_sum, phase30_carrier2, len2, fs2, fs_new ,7000, 'Demodulated 30 signal 2',t_sum,f2,'2 (phase shift 30)');
phase30_carrier3 = sin(2*pi*fc2*t_sum + (30 * pi) / 180);
[fftds3_30]=Demodulation(modulated_signal_sum, phase30_carrier3, len3, fs3, fs_new ,25000, 'Demodulated 30 signal 3',t_sum,f3,'3 (phase shift 30)');
% Demodulate the final signal with phase shift 90
phase90_carrier1 = cos(2*pi*fc1*t_sum + (90 * pi) / 180);
[fftds1_90]=Demodulation(modulated_signal_sum, phase90_carrier1, len1, fs1, fs_new ,100000, 'Demodulated 90 signal 1',t_sum,f1,'1 (phase shift 90)');
phase90_carrier2 = cos(2*pi*fc2*t_sum + (90 * pi) / 180);
[fftds2_90]=Demodulation(modulated_signal_sum, phase90_carrier2, len2, fs2, fs_new ,7000, 'Demodulated 90 signal 2',t_sum,f2,'2 (phase shift 90)');
phase90_carrier3 = sin(2*pi*fc2*t_sum + (90 * pi) / 180);
[fftds3_90]=Demodulation(modulated_signal_sum, phase90_carrier3, len3, fs3, fs_new ,25000, 'Demodulated 90 signal 3',t_sum,f3,'3 (phase shift 90)');
% Demodulate the final signal with fc+difference
Local2_carrier1 = cos(2*pi*(fc1+2)*t_sum);
[fftds1_diff2]=Demodulation(modulated_signal_sum, Local2_carrier1, len1, fs1, fs_new , 100000, 'Demodulated +2 signal 1',t_sum,f1,'1 (+2HZ)');
Local10_carrier1 = cos(2*pi*(fc1+10)*t_sum);
[fftds1_diff10]=Demodulation(modulated_signal_sum, Local10_carrier1, len1, fs1, fs_new , 100000, 'Demodulated +10 signal 1',t_sum,f1,'1 (+10HZ)');
function [len, BW, t, f,ffts] = preprocessing (s,fs)
   % get the signal length
   len = length(s);
   % get its bandwidth
   BW=bandwidth(s)./(2.*pi);
   % get its time range
   t = (0:len - 1)*20/len;
   % get its freq range
   f=(-fs/2:fs/len:fs/2-fs/len);
   % get its fft
   ffts = abs(fft(s));
end
function plotSignal (range, signal, label, x, y)
 fig=figure();
 plot(range,signal)
 title(strcat(label, ""))
 xlabel(strcat(x, ""))
 ylabel(strcat(y, ""))
 saveas(fig,label,'png')
end
function [re_s,len,t] = resampleSignal (signal,fs_all,fs_signal)
% resample the signal
[x, y] = rat(fs_all/fs_signal);
re_s = resample(signal, x, y);
% get its new length
len = length(re_s);
% get its time range
t = (0:len - 1) * (1/fs_all);
end
function [mod_s, len_ms,fms,fftms] = Modulation (c,s,fs)
% multiply the signal by the carrier
mod_s = s .* c';
% get its length
len_ms = length(mod_s);
% get its freq range
fms = (fs/len_ms)  * (-len_ms/2: len_ms/2 - 1);
% get its fft
fftms = abs(fft(mod_s));
end
function [fftds] = Demodulation(s, c, old_len, fs_old, fs_new, f_pass,filename,t,f,index)
   % multiply the signal by the carrier
   s1 = s .* c';
   % use a low pass filter
   s2 = lowpass(s1, f_pass , fs_new); 
   % raise it to its original magnitude
   s2=s2*2;
   % plot it in time domain
   plotSignal(t,s2,strcat('Demodulated signal',index,' in time domain'), 'Time(s)', 'Amplitude');
   % get its fft
   fftds = abs(fft(s2));
   % resampling
   [x, y] = rat(fs_old/fs_new);
   s3 = resample(s2, x, y);
   % return it to original length
   s3 = s3(1: old_len);   
   %plot it in freq domain
   plotSignal(f,fftshift(abs(fft(s3))),strcat('Demodulated signal',index,' in freq domain'), 'Frequency(Hz)', 'Magnitude');
   % write the sound in a file
   audiowrite(strcat(filename, '.wav'), s3,fs_old)
end
