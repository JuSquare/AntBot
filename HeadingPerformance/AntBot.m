function psi = AntBot(UV,i)
% psi is the AoP according to the robot's orientation
% UV is a structure containing the pre-processed UV0 and UV1 signals of
% AntBot's celestial compass
% i is the test label between 1 and 18
    Length = UV.LENGTH(i);
    UV0 = UV.UV0(i,1:Length);
    UV1 = UV.UV1(i,1:Length);
    RES = 360/Length;
    P   = log(UV1./UV0);
%     IND = floor(Length/2);
%     [~,a] = min(P(1:IND)); P1 = a*RES;
%     [~,a] = min(P(IND+1:end)); P2 = a*RES;
%     [~,a] = max(P(1:IND)); P3 = a*RES;
%     [~,a] = max(P(IND+1:end)); P4 = a*RES;
%     psi = (P1 + P2 + P3 + P4 + 180)/4;
%     if psi>180
%         psi = psi - 180;
%     elseif psi<0
%         psi = psi + 180;
%     end
    [~,a] = min(P);
    [~,b] = max(P);
    MinPsi = a * RES;
    MinPsi = mod(MinPsi,180);
    MaxPsi = b * RES;
    MaxPsi = mod(MaxPsi,180);
    if MaxPsi > MinPsi
        MaxPsi = MaxPsi - 90;
    else
        MaxPsi = MaxPsi + 90;
    end
    psi = 0.5*(MinPsi + MaxPsi);
end