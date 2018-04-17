# 1st DataSet

This repository contains the following parts:
* '1stExperiments.mat': a matlab file containing the trajectories (X,Y) of the hexapod robot AntBot with respect to the five ant inspired path integration (PI) strategies (see below);
* 'ProcData.m': a matlab code displaying the data contained in the above file;
* 'Area.m': a matlab code for the computation of the confidence ellipses areas in cm²;
* 'MinVolEllipse.m': a matlab code for the computation of the smallest ellipse containing a cluster of coordinates (matrix formalism);
* 'Ellipse_plot.m': a matlab code that draws ellipses using the matrix formalism;
* 'NormalityTest.m': a matlab code for normality test of the homing errors (Lilliefors' test).

The PI strategies tested here are:
* PI-ST (Distance: stride integration, Heading: stride integration);
* PI-OF-ST (Distance: optic flow, Heading: stride integration);
* PI-ST-FUSE (Distance: stride integration and optic flow, Heading: stride integration);
* PI-POL-ST (Distance: stride integration, Heading: celestial compass);
* PI-FULL (Distance: stride intagration and optic flow, Heading: celestial compass);

The experiment is the repetition (20 times) of one random outbound 5-checkpoints trajectory (approximately 5m-long), resulting in a 8-checkpoints inbound trajectory (2m-long). The experiments were conducted in Marseille, France, from January to mid-February 2018 in outdoor conditions. 

_The results presented in this dataset have been submitted for publication in Science Robotics._