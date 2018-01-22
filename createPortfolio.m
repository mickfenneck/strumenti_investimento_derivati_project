function [ port ] = createPortfolio(bonds,port)
% createPortfolio aggiunge alla table port data in input, contenente i 
% titoli che l'utente desidera in portafoglio, le informazioni attualmente
% contenute in bonds relative a tali titoli.
% port inizialmente contiene unicamente il valore nominale dei titoli.
% Le colonne aggiunte conterranno quindi:
% maturity;
% coupon;
% descrizione;
% date (settlement);
% instrument
% price (valore di mercato)

% si concatenano a port le colonne del sottinsieme di tali titoli contenute
% in bonds
port = [port bonds(port.Properties.RowNames',:)];

end

