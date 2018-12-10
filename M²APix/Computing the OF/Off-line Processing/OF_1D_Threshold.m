%% Chargement Des Données
% Format : Px1 / Px2 / ... / Px12
Z = dlmread('../Time/Data.txt');
MAPIX = Z(:,2:13);
Len = length(Z);
%% Reconstruction temps
RES = 373.8333;
TimeD = (RES:RES:Len*RES)/1000000;
%% Affichage
figure()
hold on
    plot(TimeD,MAPIX(:,1))
    plot(TimeD,MAPIX(:,2))
hold off
legend('Pix1','Pix2');
%% Paramètres généraux
Ts = 0.00333; % sampling frequency of the model (i.e. sensors' signals)
Ts_OF = Ts; % sampling frequency of the OF processing
N = 2; % filter order
% Paramètres de filtrage passe bande
Fcl =1; % low cut-off frequency (en général 3Hz)
Fch = 10;% high cut-off frequency
wn = [Fcl Fch]*Ts*2; % cut-off frequencies for 'butter'
[z,p,k] = butter(N,wn,'bandpass');
[B,A] = zp2tf(z,p,k); % filter design by zeros-poles for higher precision 
% Filtrage
MAPIX_Filt = zeros(Len,12);
for i=1:12
    MAPIX_Filt(:,i) = filter(B,A,MAPIX(:,i));
end
T = 45000:46000;
% Affichage
figure()
hold on
    plot(TimeD(T),MAPIX_Filt(T,1));
    plot(TimeD(T),MAPIX_Filt(T,2));
hold off
legend('Pix1','Pix2');
[a,lag] = xcorr(MAPIX_Filt(T,1),MAPIX_Filt(T,2));
[~,I]   = max(abs(a));
lagDiff = lag(I);
% Calcul vitesse
DeltaPhi = 3.3*3.1415926/180; % En radians
DT = lagDiff * RES / 1000000; % En secondes
OF = DeltaPhi / DT; % En rad/s
Dist = 19.2; % En cm
VitesseBanc = Dist * OF; % En cm/s
%% Calcul du flux optique sur la ligne 1 dans le sens 1 > 6
MinThreshold =0.25; % Seuil de détection de flux optique
cmax = 100; % index max de rech de dépassement de seuil chez le pixel voisin
K = 2;
figure()
subplot(5,1,1:4)
hold on;
for i=1:1
    %OFLigne = NewComputeThresholdOFij(i,i+1,(K*MAPIX_Filt),MinThreshold,0,TimeD(1000:end),Len,cmax,DeltaPhi);
    OFLigne = NewNewComputeThresholdOFij(K*NormData(MAPIX_Filt(:,i)),K*NormData(MAPIX_Filt(:,i+1)),1000,MinThreshold,0,TimeD(1000:end),Len,100,DeltaPhi);
    plot(TimeD(3500:4000)/1000000,180*OFLigne(2500:3000)/3.1415926,'+');
end
grid on
hold off;
% legend('1','2','3','4','5')
subplot(515)
hold on;
plot(TimeD(3500:4000)/1000000,K*NormData(MAPIX_Filt(3500:4000,1)),TimeD(3500:4000)/1000000,K*NormData(MAPIX_Filt(3500:4000,2)));
plot(TimeD(3500:4000)/1000000,MinThreshold*ones(1,length(3500:4000)));
hold off;
%% Calcul du flux optique sur la ligne 2 dans le sens 7 > 12
MinThreshold = 2.5; % Seuil de détection de flux optique
index = 0; 
cmax = 50; % index max de rech de dépassement de seuil chez le pixel voisin
figure()
subplot(5,1,1:4)
hold on;
for i=7:11
    OFLigne = ComputeThresholdOFij(i,i+1,(MAPIX_Filt),MinThreshold,...
        index,TimeD(1000:end),Len,cmax,DeltaPhi);
    plot(TimeD(3500:4000)/1000000,OFLigne(2500:3000),'+');
end
hold off;
legend('7','8','9','10','11')
subplot(515)
plot(TimeD(3500:4000)/1000000,abs(MAPIX_Filt(3500:4000,7:12)));