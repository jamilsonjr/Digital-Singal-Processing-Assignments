%% Laboratório 3 de PDS - 2020/21 - 2º Semestre
%Grupo 1
%Bernardo Rocha nº89867
%Ricarte Ribeiro nº89998

clear all
c = 1;
%% R1.a)
[x,Fs] = audioread('fugee.wav');
%soundsc(x,Fs);

%É possível ouvir diversos 'cliques' característicos da distorção muitas
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

%Observa-se, como seria de esperar após a audição do sinal, vários picos
%não característicos. Estes pontos de maior amplitude serão
%responsáveis pela distorção ouvida. São observados ao longo do sinal
%inteiro com amplitudes variáveis (devido à natureza aleatória do ruído)
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
xlabel('Frequência normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequência do sinal');
grid on;

%Observa-se que as frequências de maior amplitude são as menores. Isto
%deve-se à natureza mais infrequente do tipo de ruído observado, que
%ocorrendo de forma esporádica tem uma menor frequência que a maioria das
%componentes do sinal de voz e instrumental. A soma da amplitude do sinal
%natural e do ruído leva assim a uma amplitude significativamente maior no
%início do espetro.

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
%atenuação na magnitude do filtro, sendo neste caso equivalente a 0.7071
%ou, mais exatamente, 0.7071^2=0.5 em potência que é equivalente à esperada
%atenuação na frequência de corte de -3dB.

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
title('Porção do sinal de pequena amplitude');
grid on;

%Observa-se imediatamente uma atenuação geral do sinal, no gráfico do sinal
%completo, efeito óbvio da aplicação do filtro passa-baixo. Ao ampliar o
%gráfico, observando uma porção do sinal de reduzida amplitude, verifica-se
%que as porções pertencentes ao próprio sinal foram ligeiramente atenuadas
%no geral mas mantém-se maioritariamente parecidas com o sinal original. Os
%picos de ruído no entanto, sendo equiparáveis a deltas de dirac e assim
%tendo elevada frequência, são fortemente atenuados.

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
xlabel('Frequência normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequência dos sinais');
grid on;

%Corrobora-se facilmente o que foi anteriormente verificado. Devido ao
%efeito do filtro as menores frequências, abaixo de 2kHz, mantém-se quase
%inalteradas enquanto que as frequências acima destas apresentam uma
%crescente atenuação.

%% R2.e)

%soundsc(y, Fs);

%Os 'cliques' existentes anteriormente no sinal são menos notáveis, não
%sendo no entanto não existentes devido a não terem sido atenuados o
%suficiente para desaparecerem. Nota-se também que, devido à eliminação das
%maiores frequências, só são audíveis os sons mais graves da música
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
title('Porção do sinal de pequena amplitude - 0.25*pi');
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
xlabel('Frequência normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequência dos sinais - 0.25*pi');
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
title('Porção do sinal de pequena amplitude - 0.125*pi');
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
xlabel('Frequência normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequência dos sinais - 0.125*pi');
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
title('Porção do sinal de pequena amplitude - 0.75*pi');
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
xlabel('Frequência normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequência dos sinais - 0.75*pi');
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
title('Porção do sinal de pequena amplitude - 0.875*pi');
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
xlabel('Frequência normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequência dos sinais - 0.875*pi');
grid on;

%soundsc(y, Fs);

%O que é observado é uma extensão do que foi anteriormente deduzido. 
%Com a diminuição da frequência de corte mais frequências são atenuadas e 
%maior a atenuação para as frequências já atenuadas anteriormente, levando
%automaticamente a uma maior atenuação do ruído mas também à perda de maior
%qualidade de som quanto menor a frequência de corte, com o corte das
%porções agudas da voz.
%O aumento da frequência de corte, por sua vez, permite uma melhor perceção
%do sinal original, a música, mas permite também que o ruído seja menos
%atenuado. 
%Utilizando um filtro LTI é impossível obter um sinal
%'perfeito' sendo necessário obter um equilíbrio entre a perceção do som
%original e a quantidade de ruído presente.

%% R3.a)
%Causality - É Causal visto que os "outputs" do filtro, y(n), dependem
%dos "inputs" passados e presentes.

%Stability - É estável, uma vez que a resposta do filtro mediana a um
%impulso é nula.

%Linearity - É não-linear, porque a relação entre os "inputs", x, e "outputs",
%y(n), não é linear, uma vez que existe o cálculo de uma mediana entre
%várias amostras do sinal. 
%y(n) = median[x(n-M), x(n-M+1), ..., x(n), ..., x(n+M)]

%Time Invariance - Invariante no tempo. Este filtro não depende das
%mudanças dos instantes das amostras. Simplesmente, percorre todo o sinal
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

%Claramente esta filtragem remove a maior parte do ruído existente no sinal
%original. Ao observar, de forma mais próxima, a sobreposição de ambos os 
%sinais, filtrado e original, verifica-se que mantivemos, após a filtragem,
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
xlabel('Frequência normalizada (f/fs)');
ylabel('Amplitude');
title('Espetro de frequência dos sinais - Median Filter');
grid on;

%Observa-se uma ligeira atenuação nas maiores frequências devido à
%atenuação dos picos resultante da aplicação do filtro de mediana. Sendo
%os picos uma aberração em termos de amplitude estes são inevitavelmente
%atenuados.


%% R3.d)

%soundsc(med_x, Fs);

%O sinal filtrado já não tem qualquer tipo de 'cliques', não tendo perdido
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
%inexistentes, mas existe uma grande deformação e disturção do sinal, que
%se agrava quanto maior a ordem, ficando cada vez mais ruidoso.

%% R3.f)

%O melhor filtro para este caso de ruído "pontuais", em que apenas algumas
%amostras estão amplificadas exageradamente, o filtro Mediana funciona
%melhor, visto que preserva a caracteristica original do sinal, a maior
%parte dos detalhes e as transições mais abruptas do sinal.
%O sinal filtrado com o passa-baixo perdeu detalhe, detalhe este que é
% descrito pelas altas frequências.



