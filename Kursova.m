%1.3.
clc; clear;
b=[1.44 0.576];
a=[1 -0.7 0.04 0.102];
H=filt(b,a)
polus=roots(a)
nol=roots(b)

%1.4.
figure(1)
knp=zplane(nol,polus)
title('Карта нулів і полюсів')
xlabel('Дійсна частина'), ylabel('Уявна частина')

%1.5.
if abs(polus)<1
disp('Система стійка')
end

%1.6.
n=1:30;
[h,t]=impz(b,a,n);
y=filter(b,a,n)
figure(2)
stem(n,h),grid on
title('Імпульсна характеристика')
xlabel('Номер відліків'), ylabel('Амплітуда')

%1.7.
n=1:30;
[h,t]=stepz(b,a,n);
y1=filter(b,a,n)
figure(3)
stem(n,h), grid on
title('Перехідна характеристика')
xlabel('Номер відліків'), ylabel('Амплітуда')

%1.8.
% [h,w] = freqz(b,a,30); 
% mag = abs(h);
% phase = angle(h)*180/pi;
% figure(4)
% subplot(2,1,1), plot(w,mag), grid on
% title('АЧХ фільтра'),
% xlabel('Частота'), ylabel('Амплітуда')
% subplot(2,1,2), plot(w,phase), grid on
% title('ФЧХ фільтра'),
% xlabel('Частота'), ylabel('Фаза')

fs=100;
[h,w] = freqz(b,a,n,fs); 
mag = abs(h);
phase = angle(h)*180/pi;
figure(4)
subplot(2,1,1), plot(w/(2*pi)*fs,mag), grid on
title('АЧХ фільтра'),
xlabel('Частота'), ylabel('Амплітуда')
subplot(2,1,2), plot(w/(2*pi)*fs,unwrap(phase)), grid on



%1.9
[sos,g]=tf2sos(b,a)

b1=[1 0.4 0];
a1=[1 0.3 0];
disp('Перший каскад, Н1(z)')
H1=filt(b1,a1)

b2=[1 0 0];
a2=[1 -1 0.34];
disp('Другий каскад, Н2(z)')
H2=filt(b2,a2)

disp('Передатна функці фільтра у формі послідовного з"єднання елементарних ланок')
H=H1*H2

%1.10.
[r,p,k]= residuez(b,a)

[b1,a1]=residuez([r(1),r(2)],[p(1),p(2)],[])

[b2,a2]=residuez([r(3)],[p(3)],[])

a11=[1  -1  0.34]
b11=[1.4992  0.0671]
disp('Перший каскад, Н1(z)')
H1=filt(b11,a11)

a22=[1 0.3]
b22=[-0.0592 0]
disp('Другий каскад, Н2(z)')
H2=filt(b22,a22)

disp('Передатна функці фільтра у формі паралельного з"єднання елементаних ланок')
H=H1+H2



%2.1.
fs=200;
fc=40;
r=0.97;
fi=2*pi*fc/fs;
a1=(-2)*r*cos(fi);
a2=r^2;

a1=filt(a1)
a2=filt(a2)

%2.3.
b=[1 2 1];
a=[1 -0.5995 0.9409];
H=filt(b,a)
polus=roots(a)
nol=roots(b)

%2.4.
figure(5)
knp=zplane(nol,polus)
title('Карта нулів і полюсів')
xlabel('Дійсна частина'), ylabel('Уявна частина')

%2.5.
if abs(polus)<1
disp('Система стійка')
end

%2.6.
n=1:20;
[h,t]=impz(b,a,n);
y=filter(b,a,n)
figure(6)
stem(n,h),grid on
title('Імпульсна характеристика')
xlabel('Номер відліків'), ylabel('Амплітуда')

%2.7.
n=1:20;
[h,t]=stepz(b,a,n);
y1=filter(b,a,n)
figure(7)
stem(n,h), grid on
title('Перехідна характеристика')
xlabel('Номер відліків'), ylabel('Амплітуда')

%2.8.
[h,w] = freqz(b,a,n,fs); 
mag = abs(h);
phase = angle(h)*180/pi;
figure(8)
subplot(2,1,1), plot(w/(2*pi)*fs,mag), grid on
title('АЧХ фільтра'),
xlabel('Частота'), ylabel('Амплітуда')
subplot(2,1,2), plot(w/(2*pi)*fs,unwrap(phase)), grid on
title('ФЧХ фільтра'),
xlabel('Частота'), ylabel('Фаза')

% %2.9
% j=sqrt(-1);
% f01=0;
% f02=100;
% H11=(1+2*exp^(-j*2*pi*f01)+exp^(-2*j*2*pi*f01));
% H12(1-0.5995*exp^(-j*2*pi*f01)+0.9409*exp^(-2*j*2*pi*f01));
% H21=(1+2*exp^(-j*2*pi*f02)+exp^(-2*j*2*pi*f02));
% H22=(1-0.5995*exp^(-j*2*pi*f02)+0.9409*exp^(-2*j*2*pi*f02));
% H1=H11/H12;
% H2=H21/H22;
% H1=filt(H1);
% H2=filt(H2);
% 
% return




%3.1.
mu=0.4;     D=0.4;
n=100;
t=(0:(n-1))/fs;  	
A1=0.4;     f1=2;
A2=0.6;     f2=25;
A3=0.5;     f3=100;
s = A1*sin(2*pi*f1*t)+A2*sin(2*pi*f2*t)+A3*sin(2*pi*f3*t);
v = randn(size(t))*sqrt(D);          
x=s+v;

% %3.2.
b=[1 2 1];
a=[1 -0.5995 0.9409];

xf=filter(b,a,x);
%xf=detrend(xf);

%3.3.
figure(9)
subplot(2,1,1), plot(t,x), grid on
title('Графік вхідного сигналу')
xlabel('Амплітуда'), ylabel('Частота')
subplot(2,1,2), plot(t,xf), grid on
title('Графік вихідного (відфільтованого) сигналу')
xlabel('Амплітуда'), ylabel('Частота')


%3.4.
%Уелча
[pxx1,f1]=pwelch(x);
figure(10)
subplot(2,1,1), plot(f1,pxx1), grid on
title('Графік cпектральної щільністі вхідного  сигналу (метод Уелча)')
xlabel('Амплітуда'), ylabel('Частота')

[pxx2,f2]=pwelch(xf);
subplot(2,1,2), plot(f2,pxx2), grid on
title('Графік cпектральної щільністі вихідного  сигналу (метод Уелча)')
xlabel('Амплітуда'), ylabel('Частота')

%Томсона
[pxx1,w1]=pmtm(x,[]);
figure(11)
subplot(2,1,1), plot(w1,pxx1), grid on
title('Графік cпектральної щільністі вхідного  сигналу (метод Томсона)')
xlabel('Частота'), ylabel('Потужність')

[pxx2,w2]=pmtm(xf,[]);
subplot(2,1,2), plot(w2,pxx2), grid on
title('Графік cпектральної щільністі вихідного  сигналу(метод Томсона)')
xlabel('Частота'), ylabel('Потужність')

% x = detrend(x);
% xf = detrend(xf);
% nfft =30 ;
% win = bartlett(length(x));
% noverlap = length(win)/2;
% noverlap1 = 1;
% [Pxx,f] = pwelch(x,win,noverlap,nfft,fs);
% [Pxx1,f1] = pwelch(x,win,noverlap1,nfft,fs);
% [Pxx1,f2] = periodogram(x,win,nfft,fs);
% 
% figure(15)
% subplot(3,1,1), plot(f, Pxx),grid on
% title ('Оцінки СЩП методом Уелча (vag1.dat)');
% subplot(3,1,2), plot(f1, Pxx1), grid on
% title('Оцінки СЩП методом Бартлетта (vag1.dat)');
% subplot(3,1,3), plot(f2, Pxx1), grid on
% title('Оцінки СЩП методом періодограм (vag1.dat)');

