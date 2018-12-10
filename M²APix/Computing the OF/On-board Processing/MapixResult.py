import serial
import sys
import time
import numpy as np
from scipy.signal import lfilter
from scipy.signal import correlate
from math import floor

sername = '/dev/ttyACM1'
serbaud = 115200

Args = sys.argv

print "Now analyzing MAPix recordings to estimate the walked distance..."

# Les variables de Mapix
Ph1  = list()
Ph2  = list()
Ph3  = list()
Ph4  = list()
Ph5  = list()
Ph6  = list()
Ph7  = list()
Ph8  = list()
Ph9  = list()
Ph10 = list()
Ph11 = list()
Ph12 = list()
T    = list()
# Pour rallonger les signaux en vue du filtrage
Rab = 2000
# Les vecteurs de filtrage
A = np.array([1,-3.729301001380911,5.22766899514945,-3.266402684474863,0.768050971214958])
B = np.array([0.007673911006959,0,-0.015347822013913,0,0.007673911006959])

# Chargement des donnees 
with open(Args[1],'r') as DATA:
	compteur = 0
	for line in DATA:
		data = line.split(',')
		for z in range(13):
			data[z] = (float)(data[z])
		Ph1.append(data[1])
		Ph2.append(data[2])
		Ph3.append(data[3])
		Ph4.append(data[4])
		Ph5.append(data[5])
		Ph6.append(data[6])
		Ph7.append(data[7])
		Ph8.append(data[8])
		Ph9.append(data[9])
		Ph10.append(data[10])
		Ph11.append(data[11])
		Ph12.append(data[12])
		# Si on est au premier coup, on duplique Rab fois les valeurs
		if compteur == 0:
			for i in range(Rab):
				Ph1.append(data[1])
				Ph2.append(data[2])
				Ph3.append(data[3])
				Ph4.append(data[4])
				Ph5.append(data[5])
				Ph6.append(data[6])
				Ph7.append(data[7])
				Ph8.append(data[8])
				Ph9.append(data[9])
				Ph10.append(data[10])
				Ph11.append(data[11])
				Ph12.append(data[12])
		T.append(data[0])
		compteur = compteur + 1
# Filtrage
Ph1Filt = lfilter(B,A,Ph1)
Ph2Filt = lfilter(B,A,Ph2)
Ph3Filt = lfilter(B,A,Ph3)
Ph4Filt = lfilter(B,A,Ph4)
Ph5Filt = lfilter(B,A,Ph5)
Ph6Filt = lfilter(B,A,Ph6)
Ph7Filt = lfilter(B,A,Ph7)
Ph8Filt = lfilter(B,A,Ph8)
Ph9Filt = lfilter(B,A,Ph9)
Ph10Filt = lfilter(B,A,Ph10)
Ph11Filt = lfilter(B,A,Ph11)
Ph12Filt = lfilter(B,A,Ph12)
# Suppression de la partie du signal inutile
Ph1 = Ph1[Rab:]
Ph1Filt = Ph1Filt[Rab:]
Ph2 = Ph2[Rab:]
Ph2Filt = Ph2Filt[Rab:]
Ph3 = Ph3[Rab:]
Ph3Filt = Ph3Filt[Rab:]
Ph4 = Ph4[Rab:]
Ph4Filt = Ph4Filt[Rab:]
Ph5 = Ph5[Rab:]
Ph5Filt = Ph5Filt[Rab:]
Ph6 = Ph6[Rab:]
Ph6Filt = Ph6Filt[Rab:]
Ph7 = Ph7[Rab:]
Ph7Filt = Ph7Filt[Rab:]
Ph8 = Ph8[Rab:]
Ph8Filt = Ph8Filt[Rab:]
Ph9 = Ph9[Rab:]
Ph9Filt = Ph9Filt[Rab:]
Ph10 = Ph10[Rab:]
Ph10Filt = Ph10Filt[Rab:]
Ph11 = Ph11[Rab:]
Ph11Filt = Ph11Filt[Rab:]
Ph12 = Ph12[Rab:]
Ph12Filt = Ph12Filt[Rab:]

# Fonction de detection de fin de mouvement pour connaitre le temps
def DetectMotion(Ph,Seuil):
	N = len(Ph)
	while abs(Ph[N-1])<Seuil and N > 0:
		N = N-1 
	return N
# Calcul du temps total de mouvement
FullTimeIndex = DetectMotion(Ph1Filt,2)
Res = 0.0
for i in range(compteur-1):
	Res = Res + (T[i+1] - T[i])
Res = Res / (compteur -1)
MotionTime = FullTimeIndex*Res
# DeltaPhi en rad et distance au sol du capteur en cm
DeltaPhi = 0.062308254296198
D = 17.5
# Liste des valeurs de Speed retournees par chaque calcul d'OF
Speed = list()
compteurSpeed = 0
SpeedMax = 1.25*8.5
SpeedMin = 0.75*8.5
# Fonction de calcul du flux optique
def CalculateOpticFlow(Y1,Y2,Diviseur):
	TAILLE = 200
	Nb_Max_Troncons = int(floor(compteur / TAILLE))
	for i in range(Nb_Max_Troncons):
		x = np.asarray(Y1[1+(i)*TAILLE : 1+(i+1)*TAILLE])
		y = np.asarray(Y2[1+(i)*TAILLE : 1+(i+1)*TAILLE])
		Corr = correlate(y,x,'full')
		LagAxis = np.arange(Corr.size)
		Lags = LagAxis - (y.size - 1)
		Index = np.argmax(abs(Corr))
		pIndex = Lags[Index]
		DT = Res*pIndex / float(Diviseur)
		if DT != 0:
			newSpeed_OF = abs(DeltaPhi * D / DT)
			if newSpeed_OF > SpeedMin and newSpeed_OF < SpeedMax:
				Speed.append(newSpeed_OF)
	return 

# Calcul OF_12
CalculateOpticFlow(Ph1Filt,Ph2Filt,1)
# Calcul OF_23
CalculateOpticFlow(Ph2Filt,Ph3Filt,1)
# Calcul OF_34
CalculateOpticFlow(Ph3Filt,Ph4Filt,1)
# Calcul OF_45
CalculateOpticFlow(Ph4Filt,Ph5Filt,1)
# Calcul OF_56
CalculateOpticFlow(Ph5Filt,Ph6Filt,1)
# Calcul OF_78
CalculateOpticFlow(Ph7Filt,Ph8Filt,1)
# Calcul OF_89
CalculateOpticFlow(Ph8Filt,Ph9Filt,1)
# Calcul OF_910
CalculateOpticFlow(Ph9Filt,Ph10Filt,1)
# Calcul OF_1011
CalculateOpticFlow(Ph10Filt,Ph11Filt,1)
# Calcul OF_1112
CalculateOpticFlow(Ph11Filt,Ph12Filt,1)	
		
AverageSpeed = np.mean(np.asarray(Speed))
DistanceParcourue = MotionTime*AverageSpeed

FichierSortie = 'RESULT_' + Args[1]

with open(FichierSortie,'a') as f:
	f.write(str(DistanceParcourue)+'\n')



