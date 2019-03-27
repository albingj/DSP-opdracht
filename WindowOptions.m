%% Window options
N = input('geef N in: ');
k = menu('Welk window wilt u gebruiken?: ','blackmanharris','hamming','gausswin','kaiser');
switch k
   case 1
   disp('blackmanharris')
   w = window(@blackmanharris, N);
   case 2
   disp('hamming')
   w = window(@hamming, N);
   case 3
   disp('gausswin')
   a = input('geef fcnarg in: ');
   w = window(@gausswin,N,a);
   case 4
   disp('kaiser');
   a = input('geef fcnarg in: ');
   w = kaiser(N,a);
end
  
   wvtool(w);