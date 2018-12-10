#!/bin/sh

echo "\033[1;33m Compiling ResetCompass.cpp \033[0;32m"
g++ -Wall ResetCompass.cpp -o ResetCompass -std=c++0x -lwiringPi
echo "\033[0;36m -> Finished !"

echo "\033[1;33m Compiling main.cpp \033[0;32m"
g++ -Wall main.cpp -o CelestialCompass -std=c++0x -lwiringPi
echo "\033[0;36m -> Finished !"
echo "\033[0;35m Run sudo ./CelestialCompass name_of_results_file\n"

