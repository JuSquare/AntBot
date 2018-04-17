%% Normality test 1st dataset
FILE = load('1stExperiments.mat');
LENGTH = 20;
%% PI-ST
ErrorInCMPI_ST = FILE.PI_ST.HomingError;
[h,p,k,c] = lillietest(ErrorInCMPI_ST);
P_Value_PI_ST = p;
%% PI-OF-ST
ErrorInCMPI_OF_ST = FILE.PI_OF_ST.HomingError;
[h,p,k,c] = lillietest(ErrorInCMPI_OF_ST);
P_Value_PI_OF_ST = p;
%% PI-ST-FUSE
ErrorInCMPI_ST_FUSE = FILE.PI_ST_FUSE.HomingError;
[h,p,k,c] = lillietest(ErrorInCMPI_ST_FUSE);
P_Value_PI_ST_FUSE = p;
%% PI-POL-ST
ErrorInCMPI_POL_ST = FILE.PI_POL_ST.HomingError;
[h,p,k,c] = lillietest(ErrorInCMPI_POL_ST);
P_Value_PI_POL_ST = p;
%% PI-FULL
ErrorInCMPI_FULL = FILE.PI_FULL.HomingError;
[h,p,k,c] = lillietest(ErrorInCMPI_FULL);
P_Value_PI_FULL = p;
