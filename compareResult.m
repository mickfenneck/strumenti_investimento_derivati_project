function [ bonds ] = compareResult(bonds)
% compareResult calcola la differenza tra il valore di mercato dei singoli 
% titoli del portafoglio ed il relativo prezzo teorico clean. Inserisce i
% valori nella rispettiva colonna "difference" in bonds.
%
% Si crea un vettore di zeri, di tante righe quanti i bonds in portafoglio,
% lo si traspone e lo si aggiunge come colonna a bonds, che verrà riempita
% dal ciclo successivo.
bonds.difference = repelem(0,length(bonds.instrument))';
% per i che varia da 1 al numero di bonds presenti in portafoglio
for i=1:length(bonds.instrument)
    % calcolo della differenza prezzo di mercato - prezzo teorico
    bonds.difference(i) = bonds.price(i)-bonds.clean(i);
end

end

