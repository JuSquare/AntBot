function psi = Extended(UV,i)
% psi is the AoP according to the robot's orientation
% UV is a structure containing the pre-processed UV0 and UV1 signals of
% AntBot's celestial compass
% i is the test label between 1 and 18
    Length = UV.LENGTH(i);
    UV0 = UV.UV0(i,1:Length);
    UV1 = UV.UV1(i,1:Length);
    RES = 360/Length;
    P   = log(UV1./UV0);
    Pbar = zeros(size(P));
    for j = 1:Length
        Pbar(j) = 1/(1 + 10^P(j));
    end
    Ptilde = 1 - 2*Pbar;
    PsiK = 0:RES:(Length-1)*RES;
    C = zeros(Length,2);
    for j = 1:Length
        C(j,1) = cosd(2*PsiK(j));
        C(j,2) = sind(2*PsiK(j));
    end
    Cplus = inv(C'*C)*C';
    D = Cplus*Ptilde';
    if(D(1) ~= 0)
        psi = 0.5*atan(D(2)/D(1))*180/pi;
        psi = mod(psi,90);
    else
        psi = 45;
    end
end