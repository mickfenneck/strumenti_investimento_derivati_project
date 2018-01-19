function [ port ] = createPortfolio(bonds,port)
% "createPortfolio" compone una tabella composta dei titoli che l'utente
% vuole avere in portafoglio. Questa funzione crea una tabella data
% dall'unione di due tabelle:
% "port" tabella indicante il valore nominale dei titoli che l'utente desi-
% dera avere in portafoglio e bonds, cioè la tabella creata mediante la
% funzione mergeData.
% L'output è una tabella di sette colonne e tante righe quanti sono i bonds
% di cui si compone il portafoglio. Le colonne riportano il valore per ogni
% titolo dei valori di:
% value: valore nominale di ciascun titolo;
% maturity;
% coupon rate;
% descrizione;
% dateSettlement;
% instrument: tipologia di strumento, nel nostro caso Bonds;
% market price.

port = [port bonds(port.Properties.RowNames',:)];

end

