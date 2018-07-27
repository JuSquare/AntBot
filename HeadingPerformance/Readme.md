# Celestial compass: Heading estimation performances

The five AOP methods are contained in the following files:
* AntBot.m
* Extended.m
* Matrix.m
* Sahabot.m
* Stokes.m

The CorrectPsi.m file aims at correcting the angles of the four methods using the half arctangent. 


Data (the normalized and filtered sine waves UV0 and UV1): 	
	Clear[1-10].mat
	Changeable[1-10].mat
	Covered[1-6].mat

Overall results (contain the AoPs, AoP errors, etc.):
	Data_Clear_Sky.mat
	Data_Changeable_Sky.mat
	Data_Covered_Sky.mat

Run the Main.m file sections after sections.
Before, run the install.m file in the IoSR/+iosr folder (for violin plots).

The experimental conditions are sum up in ExpConditions.ods file. 

For any question, feel free to contact Julien Dupeyroux: julien.dupeyroux@univ-amu.fr 

_The results presented in these datasets have been submitted for publication in the Journal of the Royal Society Interface._