function [ bonds ] = mergeData( btp,bonds)
% mergeData unisce i dati contenuti nei file btp e bond (input della
% funzione), al fine di creare una table contenente tutti i dati necessari
% al calcolo della curva dei tassi.
% I dati necessari infatti sono:
% maturity -> data di scadenza del bond
% coupon -> cedola del bond
% instrument -> tipologia di titolo
% price -> prezzo di mercato alla data di settlement di ciascun titolo
% date -> data di settlement del titolo
% NB: si lascia all'interno della table la variabile description, utile
% alla visualizzazione finale dell'output

% si salva nella varibile nBonds il numero di righe del file bonds,
% corrispondente al numero di bonds presenti nei file.
nBonds = length(bonds.Properties.RowNames);
% si salva la data di settlement del btp in modo da eseguire una sola
% computazione e replicare lo stesso valore su tutta la tabella
% la data è contenuta nella cella corrispondente all'ultima riga, prima
% colonna del file btp. Un migliore esempio è presente nel file script.m
dateSettlement = datestr(btp(end,1).Variables);
% si ripete la data di settlement per ogni riga del file bonds
bonds.date = repelem({dateSettlement},nBonds)';
% si ripete lo strumento 'Bond' per ogni riga del file bonds
bonds.instrument = repelem({'Bond'},nBonds)';
% si inseriscono i prezzi dei bond trasponendo ed aggiungendo a bonds tutti
% i valori dell'ultima riga del file btp, esclusa la prima colonna (come
% illustrato, relativa alla data), nella relativa colonna 'price'.
bonds.price = btp(end,2:end).Variables';

end

