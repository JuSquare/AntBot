function VectPsiCorr = CorrectPsi(VectPsi)
    EPS = 50;
    VectPsiCorr = VectPsi - min(VectPsi);
    for k = 2:length(VectPsiCorr)
        if VectPsiCorr(k) - VectPsiCorr(k-1) > EPS
            VectPsiCorr(k) = VectPsiCorr(k) - 90;
        end
        if VectPsiCorr(k-1) - VectPsiCorr(k) > EPS
            VectPsiCorr(k) = VectPsiCorr(k) + 90;
        end
    end
    VectPsiCorr = VectPsiCorr - min(VectPsiCorr);
    for k = 2:length(VectPsiCorr)
        if VectPsiCorr(k) - VectPsiCorr(k-1) > EPS
            VectPsiCorr(k) = VectPsiCorr(k) - 90;
        end
        if VectPsiCorr(k-1) - VectPsiCorr(k) > EPS
            VectPsiCorr(k) = VectPsiCorr(k) + 90;
        end
    end
    for k = 2:length(VectPsiCorr)
        if VectPsiCorr(k) - VectPsiCorr(k-1) > EPS
            VectPsiCorr(k) = VectPsiCorr(k) - 90;
        end
        if VectPsiCorr(k-1) - VectPsiCorr(k) > EPS
            VectPsiCorr(k) = VectPsiCorr(k) + 90;
        end
    end
    VectPsiCorr = -(VectPsiCorr - VectPsiCorr(1));
end