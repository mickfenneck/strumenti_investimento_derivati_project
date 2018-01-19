function [ bonds ] = compareResult(bonds)

% "compareResult": questa funzione confronta il prezzo teorico clean dei 
% singoli titoli scelti per comporre il portafoglio ed il loro valore di 
% mercato reale. 
% L'output di questa funzione così come usata in " curve dei tassi" è inse-
% rito nella tabella "portfolio" in ultima colonna. Qui è invece riferita
% alla tabella bonds. 
%
% Spiegando la funzione per come vi si fa riferimento
% in "curvedeitassi", si crea un vettore di zeri, di tante righe quanti
% sono i bonds usati per comporre il portafoglio.
% Si procede poi a calcolare per mezzo di una operazione algebrica la
% differenza tra il prezzo di mercato osservato di ciascun bond e il suo
% prezzo clean teorico. Tali differenze sono calcolate per mezzo di un
% ciclo for, che si ripete tante volte quanti sono i "bonds" in portafo-
% glio. Tali differenze vanno poi a sostituirsi ai valori zero disposti
% nelle righe del vettore prima creato.

bonds.difference = repelem(0,length(bonds.instrument))';

for i=1:length(bonds.instrument)
    bonds.difference(i) = bonds.price(i)-bonds.clean(i);
end

end

