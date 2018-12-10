import serial
import numpy as np
import math
import sys
import matplotlib.pyplot as plt

UV0 = list()
UV1 = list()

Args = sys.argv

with open(Args[1]) as f:
	for line in f:
		a = line.split(',')
		if len(a) !=2:
			continue
		UV0.append((int)(a[0]))
		UV1.append((int)(a[1]))

L = len(UV0)
Resolution = 360.0/L
	
def ZeroFFT(x,l):
	y = np.fft.fft(x)
	for i in range(2,l-4):
		y[i] = 0
	xfilt = np.fft.ifft(y)
	xfilt = abs(xfilt)
	return xfilt
	
UV0Filtre = ZeroFFT(UV0,L)
UV1Filtre = ZeroFFT(UV1,L)

def NormalizeData(x,l):
	m = min(x)
	eps = 0.0001
	data1 = list()
	data2 = list()
	for i in range(0,l):
		data1.append(x[i] - m + eps)
	M = max(data1)
	for i in range(0,l):
		data2.append(data1[i] / M)
	return data2
	
UV0NC = NormalizeData(UV0Filtre,L)
UV1NC = NormalizeData(UV1Filtre,L)

def SearchMinMax(x,l,Res):
	mini = 4096
	indi = 0
	maxi = -1
	inda = 0
	for i in range(0,l):
		if x[i] < mini:
			mini = x[i]
			indi = i
		elif x[i] > maxi:
			maxi = x[i]
			inda = i
	return [mini, indi*Res, maxi, inda*Res]
	
def LogUV(x,v,l):
	y = list()
	for i in range(0,l):
		y.append(math.log10(v[i]/x[i]))
	return y

LogUVNC = LogUV(UV0NC,UV1NC,L)

L_MEDIAN = int(math.floor(L/2))
LogUVNC_DEBUT = LogUVNC[0:L_MEDIAN-1]
L_DEBUT = len(LogUVNC_DEBUT)
LogUVNC_FIN   = LogUVNC[L_MEDIAN:L-1]
L_FIN   = len(LogUVNC_FIN)

[m1, indm1, M1, indM1] = SearchMinMax(LogUVNC_DEBUT,L_DEBUT,Resolution)
[m2, indm2, M2, indM2] = SearchMinMax(LogUVNC_FIN,L_FIN,Resolution)

if indM2 < indm2:
	indM2 = indM2 + 90.0
else:
	indM2 = indM2 - 90.0

if indM1 < indm1:
	indM1 = indM1 + 90.0
else:
	indM1 = indM1 - 90.0

Psi = 0.25*(indM1 + indM2 + indm1 + indm2)

with open("Result.txt",'a') as f:
	f.write(str(Psi)+'\n')

