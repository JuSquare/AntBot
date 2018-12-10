function TimeOut = DetectTimeOut(ValD1,D2,startingCounter,countmax)
    % ValD1 : Threshold
    % D2 : Deuxième pixel
    % startingCounter : t init de recherche
    % countmax : t final de recherche
    counter = startingCounter;
    while(D2(counter)<ValD1&&counter<length(D2)...
            &&counter<startingCounter+countmax)
        counter = counter + 1;
    end
    if counter<startingCounter+countmax
        TimeOut = counter;    
        % Si on a détecté un pulse sur le pixel voisin avant d'arriver à la
        % fin du buffer, alors on valide le flux optique
    else
        TimeOut = 0;
        % Si on n'a pas détecté le pulse, alors le pixel voisin n'a pas vu
        % le même contraste et donc le DT est infini, i.e. le flux optique
        % est nul
    end
end
