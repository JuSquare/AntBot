function psi = Stokes(UV,i)
% psi is the AoP according to the robot's orientation
% UV is a structure containing the pre-processed UV0 and UV1 signals of
% AntBot's celestial compass
% i is the test label between 1 and 18
    Length = UV.LENGTH(i);
    UV0 = UV.UV0(i,1:Length);
    UV1 = UV.UV1(i,1:Length);
    RES = 360/Length;
    Ind0 = 1;
    Ind45 = floor(45/RES);
    S1 = UV0(Ind0) - UV1(Ind0);
    S2 = UV0(Ind45) - UV1(Ind45);
    psi = 0.5*atand(S2/S1);
    psi = mod(psi,90);
end