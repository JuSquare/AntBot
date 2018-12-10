function OF_DA_DB = NewComputeThresholdOFij(a,b,DataFiltered,MinThreshold,index,TimeD,Len,cmax,DeltaPhi)
    D1 = (DataFiltered(1000:end,b)); % has to be checked after 1000th sample due to delay
    D2 = (DataFiltered(1000:end,a)); % has to be checked after 1000th sample due to delay
    Len1000 = Len - 1000;
    OFD1D2Sens12 = zeros(1,Len1000);
    CountD2 = 0;
    p = 0;
    while(index<Len1000)
        index = index + 1;
        while(D1(index)<MinThreshold && index<Len1000)
            OFD1D2Sens12(1,index) = 0;
            % Tant que le pixel 1 n'a rien vu, pas de flux optique
            index = index + 1;
        end
        % On sort de la boucle quand px1>seuil, et on déclenche la boucle
        % de recherche du même dépassement chez le pixel 2
        if p == 0
            CountD2 = index+1;
        end
        CountD2 = DetectTimeOut(MinThreshold,D2,CountD2,cmax);
        % On en déduit le flux optique
        if CountD2 == 0
            OF = 0;
        else
            if index<Len1000
                if D1(index) - D1(index+1) < 0
                    DT = (TimeD(CountD2) - TimeD(index));
                    OF = DeltaPhi / DT;
                    p = p + 1;
                else
                    OF = 0;
                end
            else
                OF = 0;
            end
        end
        OFD1D2Sens12(1,index) = OF;
    end
    OF_DA_DB = OFD1D2Sens12;
end