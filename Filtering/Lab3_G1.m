%% Laborat�rio 3 de PDS - 2020/21 - 2� Semestre
%Grupo 1
%Bernardo Rocha n�89867
%Ricarte Ribeiro n�89998

clear all
c = 1;
%% R1.a)
[x,Fs] = audioread('fugee.wav');
%soundsc(x,Fs);

%� poss�vel ouvir diversos 'cliques' caracter�sticos da distor��o muitas
%vezes presente em discos de vinil antigos.

%% R1.b)
figure(c)
c=c+1;
plot(x(1:250000));
xlabel('Sample');
ylabel('Sinal');
title('Primeiras 250 mil samples');
grid on;

figure(c)
c=c+1;
plot(x(250000:500000));
xlabel('Sample');
ylabel('Sinal');
title('Segundas 250 mil samples');
grid on;

figure(c)
c=c+1;
plot(x(500000:750000));
xlabel('Sample');
ylabel('Sinal');
title('Terceiras 250 mil samples');
grid on;

figure(c)
c=c+1;
plot(x(750000:1000000));
xlabel('Sample');
ylabel('Sinal');
title('Quartas 250 mil samples');
grid on;

figure(c)
c=c+1;
plot(x);
xlabel('Sample');
ylabel('Sinal');
title('Sinal inteiro');
grid on;

%Observa-se, como seria de esperar ap�s a audi��o do sinal, v�rios picos
%n�o caracter�sticos. Estes pontos de maior amplitude ser�o
%respons�veis pela distor��o ouvida. S�o observados ao longo do sinal
%inteiro com amplitudes vari�veis (devido � natureza aleat�ria do ru�do)
%mas consistentemente de amplitude superior ao sinal de voz/instrumental.

%% R1.c)

N = length(x);

y=fft(x);
y(2:end-1) = 2*y(2:end-1);
y = fftshift(y);
Y = abs(y/N);
f = (-N/2:1:(N/2)-1)/N;

figure(c)
c= c+1;
semilogy(f,Y);
xlim([0 0.5])
xlabel('Frequ�ncia normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequ�ncia do sinal');
grid on;

%Observa-se que as frequ�ncias de maior amplitude s�o as menores. Isto
%deve-se � natureza mais infrequente do tipo de ru�do observado, que
%ocorrendo de forma espor�dica tem uma menor frequ�ncia que a maioria das
%componentes do sinal de voz e instrumental. A soma da amplitude do sinal
%natural e do ru�do leva assim a uma amplitude significativamente maior no
%in�cio do espetro.

%% R2.a)

[b,a] = butter(10,0.5);

[h,w] = freqz(b,a);

figure(c)
c= c+1;
freqz(b,a);
ax=get(gcf,'Children'); 
li=get(ax(1),'Children'); 
r=get(ax(1),'YLabel'); 
set(r,'String','Magnitude') 
ydata=get(li,'Ydata'); 
d=10.^(ydata/20); 
set(li,'Ydata',d); 
title('Espectro do filtro  - 0.5*pi');

%Observa-se, como seria de esperar, que em 0.5*pi rad/sample existe uma
%atenua��o na magnitude do filtro, sendo neste caso equivalente a 0.7071
%ou, mais exatamente, 0.7071^2=0.5 em pot�ncia que � equivalente � esperada
%atenua��o na frequ�ncia de corte de -3dB.

%% R2.b)
y = filter(b,a,x);

%freq corte real=(freq corte normalizada*Fs)/(2*pi) =(pi/2*8000)/(2*pi) =
%2000 Hz

%% R2.c)
figure(c)
c= c+1;
plot(x(1:length(x)))
hold on
plot(y(1:length(x)))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Sinal inteiro');
grid on;

figure(c)
c= c+1;
plot(x(619500:633500))
hold on
plot(y(619500:633500))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Por��o do sinal de pequena amplitude');
grid on;

%Observa-se imediatamente uma atenua��o geral do sinal, no gr�fico do sinal
%completo, efeito �bvio da aplica��o do filtro passa-baixo. Ao ampliar o
%gr�fico, observando uma por��o do sinal de reduzida amplitude, verifica-se
%que as por��es pertencentes ao pr�prio sinal foram ligeiramente atenuadas
%no geral mas mant�m-se maioritariamente parecidas com o sinal original. Os
%picos de ru�do no entanto, sendo equipar�veis a deltas de dirac e assim
%tendo elevada frequ�ncia, s�o fortemente atenuados.

%% R2.d)

N = length(x);

Y2=fft(y);
Y2(2:end-1) = 2*Y2(2:end-1);
Y2 = fftshift(Y2);
Y2 = abs(Y2/N);
f = (-N/2:1:(N/2)-1)/N;

figure(c)
c= c+1;
semilogy(f,Y);
hold on
semilogy(f,Y2);
xlim([0 0.5])
legend('Sinal original','Sinal filtrado');
xlabel('Frequ�ncia normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequ�ncia dos sinais');
grid on;

%Corrobora-se facilmente o que foi anteriormente verificado. Devido ao
%efeito do filtro as menores frequ�ncias, abaixo de 2kHz, mant�m-se quase
%inalteradas enquanto que as frequ�ncias acima destas apresentam uma
%crescente atenua��o.

%% R2.e)

%soundsc(y, Fs);

%Os 'cliques' existentes anteriormente no sinal s�o menos not�veis, n�o
%sendo no entanto n�o existentes devido a n�o terem sido atenuados o
%suficiente para desaparecerem. Nota-se tamb�m que, devido � elimina��o das
%maiores frequ�ncias, s� s�o aud�veis os sons mais graves da m�sica
%perdendo-se assim alguma da qualidade de som.

%% R2.f)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0.25
[b,a] = butter(10,0.25);

%[h,w] = freqz(b,a);

figure(c)
c= c+1;
freqz(b,a);
ax=get(gcf,'Children'); 
li=get(ax(1),'Children'); 
r=get(ax(1),'YLabel'); 
set(r,'String','Magnitude') 
ydata=get(li,'Ydata'); 
d=10.^(ydata/20); 
set(li,'Ydata',d);
title('Espectro do filtro  - 0.25*pi');

y = filter(b,a,x);

figure(c)
c= c+1;
plot(x(1:length(x)))
hold on
plot(y(1:length(x)))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Sinal inteiro - 0.25*pi');
grid on;

figure(c)
c= c+1;
plot(x(619500:633500))
hold on
plot(y(619500:633500))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Por��o do sinal de pequena amplitude - 0.25*pi');
grid on;

N = length(x);

Y2=fft(y);
Y2(2:end-1) = 2*Y2(2:end-1);
Y2 = fftshift(Y2);
Y2 = abs(Y2/N);
f = (-N/2:1:(N/2)-1)/N;

figure(c)
c= c+1;
semilogy(f,Y);
hold on
semilogy(f,Y2);
xlim([0 0.5])
legend('Sinal original','Sinal filtrado');
xlabel('Frequ�ncia normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequ�ncia dos sinais - 0.25*pi');
grid on;

%soundsc(y, Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0.125
[b,a] = butter(10,0.125);

%[h,w] = freqz(b,a);

figure(c)
c= c+1;
freqz(b,a);
ax=get(gcf,'Children'); 
li=get(ax(1),'Children'); 
r=get(ax(1),'YLabel'); 
set(r,'String','Magnitude') 
ydata=get(li,'Ydata'); 
d=10.^(ydata/20); 
set(li,'Ydata',d);
title('Espectro do filtro  - 0.125*pi');

y = filter(b,a,x);

figure(c)
c= c+1;
plot(x(1:length(x)))
hold on
plot(y(1:length(x)))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Sinal inteiro - 0.125*pi');
grid on;

figure(c)
c= c+1;
plot(x(619500:633500))
hold on
plot(y(619500:633500))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Por��o do sinal de pequena amplitude - 0.125*pi');
grid on;

N = length(x);

Y2=fft(y);
Y2(2:end-1) = 2*Y2(2:end-1);
Y2 = fftshift(Y2);
Y2 = abs(Y2/N);
f = (-N/2:1:(N/2)-1)/N;

figure(c)
c= c+1;
semilogy(f,Y);
hold on
semilogy(f,Y2);
xlim([0 0.5])
legend('Sinal original','Sinal filtrado');
xlabel('Frequ�ncia normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequ�ncia dos sinais - 0.125*pi');
grid on;

%soundsc(y, Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0.75
[b,a] = butter(10,0.75);

%[h,w] = freqz(b,a);

figure(c)
c= c+1;
freqz(b,a);
ax=get(gcf,'Children'); 
li=get(ax(1),'Children'); 
r=get(ax(1),'YLabel'); 
set(r,'String','Magnitude') 
ydata=get(li,'Ydata'); 
d=10.^(ydata/20); 
set(li,'Ydata',d);
title('Espectro do filtro  - 0.75*pi');

y = filter(b,a,x);

figure(c)
c= c+1;
plot(x(1:length(x)))
hold on
plot(y(1:length(x)))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Sinal inteiro - 0.75*pi');
grid on;

figure(c)
c= c+1;
plot(x(619500:633500))
hold on
plot(y(619500:633500))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Por��o do sinal de pequena amplitude - 0.75*pi');
grid on;

N = length(x);

Y2=fft(y);
Y2(2:end-1) = 2*Y2(2:end-1);
Y2 = fftshift(Y2);
Y2 = abs(Y2/N);
f = (-N/2:1:(N/2)-1)/N;

figure(c)
c= c+1;
semilogy(f,Y);
hold on
semilogy(f,Y2);
xlim([0 0.5])
legend('Sinal original','Sinal filtrado');
xlabel('Frequ�ncia normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequ�ncia dos sinais - 0.75*pi');
grid on;

%soundsc(y, Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0.875
[b,a] = butter(10,0.875);

%[h,w] = freqz(b,a);

figure(c)
c= c+1;
freqz(b,a);
ax=get(gcf,'Children'); 
li=get(ax(1),'Children'); 
r=get(ax(1),'YLabel'); 
set(r,'String','Magnitude') 
ydata=get(li,'Ydata'); 
d=10.^(ydata/20); 
set(li,'Ydata',d);
title('Espectro do filtro  - 0.875*pi');

y = filter(b,a,x);

figure(c)
c= c+1;
plot(x(1:length(x)))
hold on
plot(y(1:length(x)))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Sinal inteiro - 0.875*pi');
grid on;

figure(c)
c= c+1;
plot(x(619500:633500))
hold on
plot(y(619500:633500))
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Por��o do sinal de pequena amplitude - 0.875*pi');
grid on;

N = length(x);

Y2=fft(y);
Y2(2:end-1) = 2*Y2(2:end-1);
Y2 = fftshift(Y2);
Y2 = abs(Y2/N);
f = (-N/2:1:(N/2)-1)/N;

figure(c)
c= c+1;
semilogy(f,Y);
hold on
semilogy(f,Y2);
xlim([0 0.5])
legend('Sinal original','Sinal filtrado');
xlabel('Frequ�ncia normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequ�ncia dos sinais - 0.875*pi');
grid on;

%soundsc(y, Fs);

%O que � observado � uma extens�o do que foi anteriormente deduzido. 
%Com a diminui��o da frequ�ncia de corte mais frequ�ncias s�o atenuadas e 
%maior a atenua��o para as frequ�ncias j� atenuadas anteriormente, levando
%automaticamente a uma maior atenua��o do ru�do mas tamb�m � perda de maior
%qualidade de som quanto menor a frequ�ncia de corte, com o corte das
%por��es agudas da voz.
%O aumento da frequ�ncia de corte, por sua vez, permite uma melhor perce��o
%do sinal original, a m�sica, mas permite tamb�m que o ru�do seja menos
%atenuado. 
%Utilizando um filtro LTI � imposs�vel obter um sinal
%'perfeito' sendo necess�rio obter um equil�brio entre a perce��o do som
%original e a quantidade de ru�do presente.

%% R3.a)
%Causality - � Causal visto que os "outputs" do filtro, y(n), dependem
%dos "inputs" passados e presentes.

%Stability - � est�vel, uma vez que a resposta do filtro mediana a um
%impulso � nula.

%Linearity - � n�o-linear, porque a rela��o entre os "inputs", x, e "outputs",
%y(n), n�o � linear, uma vez que existe o c�lculo de uma mediana entre
%v�rias amostras do sinal. 
%y(n) = median[x(n-M), x(n-M+1), ..., x(n), ..., x(n+M)]

%Time Invariance - Invariante no tempo. Este filtro n�o depende das
%mudan�as dos instantes das amostras. Simplesmente, percorre todo o sinal
%com uma janela de tamanho pre-definido realizando medianas.

%% R3.b)
med_x = medfilt1(x,3);

figure(c)
c= c+1;
plot(x)
hold on
plot(med_x)
legend('Sinal original','Sinal filtrado');
xlabel('Sample');
ylabel('Sinal');
title('Sinal inteiro - Median filter');
grid on;

%Claramente esta filtragem remove a maior parte do ru�do existente no sinal
%original. Ao observar, de forma mais pr�xima, a sobreposi��o de ambos os 
%sinais, filtrado e original, verifica-se que mantivemos, ap�s a filtragem,
%o "corpo" principal do sinal de audio inicial.

%% R3.c)

N = length(x);

Y2=fft(med_x);
Y2(2:end-1) = 2*Y2(2:end-1);
Y2 = fftshift(Y2);
Y2 = abs(Y2/N);
f = (-N/2:1:(N/2)-1)/N;

figure(c)
c= c+1;
semilogy(f,Y);
hold on
semilogy(f,Y2);
xlim([0 0.5])
legend('Sinal original','Sinal filtrado');
xlabel('Frequ�ncia normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequ�ncia dos sinais - Median Filter');
grid on;

%Observa-se uma ligeira atenua��o nas maiores frequ�ncias devido �
%atenua��o dos picos resultante da aplica��o do filtro de mediana. Sendo
%os picos uma aberra��o em termos de amplitude estes s�o inevitavelmente
%atenuados.


%% R3.d)

%soundsc(med_x, Fs);

%O sinal filtrado j� n�o tem qualquer tipo de 'cliques', n�o tendo perdido
%muita qualidade de som em troca.

%% R3.e)
med_x2 = medfilt1(x,2);
med_x4 = medfilt1(x,4);
med_x5 = medfilt1(x,5);
med_x7 = medfilt1(x,7);

%soundsc(med_x2, Fs);
%soundsc(med_x4, Fs);
%soundsc(med_x5, Fs);
%soundsc(med_x7, Fs);

%No caso de reduzirmos a ordem para 2, voltamos a ter os 'cliques' que
%tinhamos inicialmente.
%Ao aumentar a ordem para 4, 5 e 7, os 'cliques' continuam a ser
%inexistentes, mas existe uma grande deforma��o e distur��o do sinal, que
%se agrava quanto maior a ordem, ficando cada vez mais ruidoso.

%% R3.f)

%O melhor filtro para este caso de ru�do "pontuais", em que apenas algumas
%amostras est�o amplificadas exageradamente, o filtro Mediana funciona
%melhor, visto que preserva a caracteristica original do sinal, a maior
%parte dos detalhes e as transi��es mais abruptas do sinal.
%O sinal filtrado com o passa-baixo perdeu detalhe, detalhe este que �
% descrito pelas altas frequ�ncias.



