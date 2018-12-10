function Y = NormData(X)
    Y = X - min(X) + 0.000001;
    Y = Y / max(Y);
end