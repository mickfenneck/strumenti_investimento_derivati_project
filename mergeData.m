function [ bonds ] = mergeData( btp,bonds)

%mergeData è una funzione che permette di creare una tabella nella 
%quale vengono presentate le caratteristiche dei bonds dati come input nei
%file btp e bonds che useremo per la costruzione della curva.
%Queste caratteristiche sono:
%maturity;
%coupon rate;
%description: denominazione di ogni titolo;
%instrument: tipologia di ogni titolo;
%price: prezzo di mercato alla data di settlement di ciascun titolo;

nBonds = length(bonds.Properties.RowNames); %port.Properties.RowNames);

%portfolio = bonds; %(port.Properties.RowNames',:);
dateSettlement = datestr(btp(end,1).Variables);
bonds.date = repelem({dateSettlement},nBonds)';
bonds.instrument = repelem({'Bond'},nBonds)';
%price
%index = find(btp.date == datenum(dateSettlement));
bonds.price = btp(end,2:end).Variables';
%portfolio.value = port.Value;
%creo elenco date forecast
%portfolio.forecastDate = repelem({forecastDate},nBonds)';
%inserisco valMkt
%portfolio.valMkt = valMkt;

end

