# Celestial Compass Program

List of files:
* Compile.sh: compiling file. Simply run: sh Compile.sh
* Hall.cpp: for detecting the end of one full rotation (using the hall effect sensors placed below the rotating filters). 
* main.cpp: main program. Run: sudo ./CelestialCompass name_of_results_file
* main.h: headers.
* ResetCompass.cpp: resetting program. Must be done before measuring the celestial pattern of polarization (aligns the rotating filters). Simply run: sudo ./ResetCompass

These are the basic files to use on-board a Raspberry Pi 2 B electronic board. Stepper motor is Faulhaber AM0820-A-0225-7 and UV photodiodes are SGLux SG01D18. Feel free to contact me if any question. 