function psi = Sahabot(UV,i)
% psi is the AoP according to the robot's orientation
% UV is a structure containing the pre-processed UV0 and UV1 signals of
% AntBot's celestial compass
% i is the test label between 1 and 18
    Length = UV.LENGTH(i);
    UV0 = UV.UV0(i,1:Length);
    UV1 = UV.UV1(i,1:Length);
    RES = 360/Length;
    IND60 = floor(60/RES);
    IND120 = floor(120/RES);
    if( abs(IND60*RES - 60) > abs((IND60+1)*RES - 60) )
        IND60 = IND60 + 1;
    end
    if( abs(IND120*RES - 120) > abs((IND120+1)*RES - 120) )
        IND120 = IND120 + 1;
    end
    P1 = log(UV1(1)/UV0(1));
    P2 = log(UV1(IND60)/UV0(IND60));
    P3 = log(UV1(IND120)/UV0(IND120));
    Ptilde1 = 1 - 2*(1/(1 + 10^P1));
    Ptilde2 = 1 - 2*(1/(1 + 10^P2));
    Ptilde3 = 1 - 2*(1/(1 + 10^P3));
    if(Ptilde1 ~= 0.0)
        psi = 0.5*atand( (2*Ptilde2 + Ptilde1) / (sqrt(3)*Ptilde1) );
        psi = mod(psi,90);
    else
        psi = 45;
    end
end