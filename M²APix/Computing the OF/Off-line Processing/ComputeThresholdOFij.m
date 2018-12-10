function OF_DA_DB = NewComputeThresholdOFij(a,b,DataFiltered,MinThreshold,index,Time,Len,cmax,DeltaPhi)
    D1 = (DataFiltered(1000:end,b)); % has to be checked after 1000th sample due to delay
    D2 = (DataFiltered(1000:end,a)); % has to be checked after 1000th sample due to delay
    Len1000 = Len - 1000;
    OFD1D2Sens12 = 0;
    while(index<Len1000)
        index = index + 1;
        while(D1(index)<MinThreshold && index<Len1000)
            OFD1D2Sens12 = [OFD1D2Sens12 0];
            % Tant que le pixel 1 n'a rien vu, pas de flux optique
            index = index + 1;
        end
        % On sort de la boucle quand px1>seuil, et on déclenche la boucle
        % de recherche du même dépassement chez le pixel 2
            CountD2 = DetectTimeOut(MinThreshold,D2,index,cmax);
        % On en déduit le flux optique
        if CountD2 == 0
            OF = 0;
        else
            DT = (Time(CountD2) - Time(index));
            OF = DeltaPhi / DT;
        end
        OFD1D2Sens12 = [OFD1D2Sens12 OF];
    end
    OF_DA_DB = OFD1D2Sens12;
end