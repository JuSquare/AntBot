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

serleng = int(Args[2])

with open(Args[1],'w') as DataRec:
	with serial.Serial(sername,serbaud,timeout=1) as ser:
		ser.flush()
		i = 0
		print "Starting MAPix data recording..."
		t0 = time.time()
		while(i<serleng):
			line = ser.readline()
			data = line.split(b',')
			if len(data) !=13:
				continue 
			for z in range(13):
				if z == 0:
					continue
				else:
					data[z] = (int)(data[z])
			data[0] = time.time()-t0
			for z in range(12):
				DataRec.write(str(data[z]))
				DataRec.write(',')
			DataRec.write(str(data[12]))
			DataRec.write('\n')
			i = i+1
		print "MAPix session acquisition done."
	


