% Here are displayed the four extreme points of each confidence ellipses in the following order:
% 	1- PI-ST
% 	2- PI-OF-ST
% 	3- PI-ST-FUSE
% 	4- PI-POL-ST 
% 	5- PI-FULL
% Points A and C depict the limits of the major axis, and points B and D depict the limits of the minor axis. 
A = [0.286 -0.026 ; -0.0013 0.237  ; 0.36  0.151  ; -0.312 0.071  ; 0.016  -0.095]' * 100;
B = [0.445 -0.314 ; 0.4183  0.118  ; 0.489 -0.076 ; 0.011  0.2    ; -0.006 0.032]'  * 100;
C = [0.272 -0.614 ; 0.411   -0.257 ; 0.33  -0.275 ; 0.357  0.062  ; 0.106  0.083]'  * 100;
D = [0.115 -0.3   ; -0.026  -0.156 ; 0.204 -0.04  ; 0.019  -0.068 ; 0.132  -0.029]' * 100;

AC = C - A;
BD = D - B;

SemiMajor = zeros(1,5); % semi major axis length (cm)
SemiMinor = zeros(1,5); % semi minor axis length (cm)
Areas     = zeros(1,5); % ellipse area (cm²)

for i = 1:5
    SemiMajor(i) = norm(AC(:,i))/2;
    SemiMinor(i) = norm(BD(:,i))/2;
    Areas(i) = pi * SemiMajor(i) * SemiMinor(i);
end