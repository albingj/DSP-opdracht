Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 473;             % Length of signal
t = (0:L-1)*T;        % Time vector
S = cell2mat(selected(:,1));
n = 2^nextpow2(L);
pad = zeros( n-L,1);
S = [S;pad];
X = S.';
Y = fft(X,n);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
