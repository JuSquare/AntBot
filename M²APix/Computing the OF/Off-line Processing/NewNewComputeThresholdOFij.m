function OF_DA_DB = NewNewComputeThresholdOFij(d1,d2,SeuilBuff,MinThreshold,index,TimeD,Len,K,DeltaPhi)
    D1 = (d2(SeuilBuff:end)); % has to be checked after 1000th sample due to delay
    D2 = (d1(SeuilBuff:end)); % has to be checked after 1000th sample due to delay
    Len1000 = Len - 1000;
    OFD1D2Sens12 = zeros(1,Len1000);
    Compteur = 0;
    Delta = 1;
    while(index<Len1000)
        index = index + 1;
        while(D1(index)<MinThreshold && index<Len1000)
            OFD1D2Sens12(1,index) = 0;
            % Tant que le pixel 1 n'a rien vu, pas de flux optique
            index = index + 1;
        end
        % On sort de la boucle quand px1>seuil, et on déclenche la boucle
        % de recherche du même dépassement chez le pixel 2
        if index>1
            if (D1(index) - D1(index-1))>0
                ind = index + Delta;
                while(D2(ind)<MinThreshold && ind<Len1000 && ind<index+K)
                    ind = ind + 1;
                end
                if(D2(ind) > MinThreshold)
                    Compteur = ind;
                    Delta = ind - index;
                else
                    Delta = 1;
                    Compteur = 0;
                end
            else
                Delta = 1;
                Compteur = 0;
            end
        else
            Delta = 1;
            Compteur = 0;
        end
        if Compteur == 0
            OFD1D2Sens12(1,index) = 0;
        else
            OF = DeltaPhi / (TimeD(Compteur) - TimeD(index));
            OFD1D2Sens12(1,index) = OF;
        end
    end
    OF_DA_DB = OFD1D2Sens12;
end