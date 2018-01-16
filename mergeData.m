function [ bonds ] = mergeData( btp,bonds)

%createPortfolio è una funzione che permette di creare una tabella nella 
%quale vengono presentate le caratteristiche dei bonds (scelti in input) che
%compongono il portafoglio. Queste caratteristiche sono:
%maturity: data di maturity di ciascun titolo che compone il portafoglio;
%coupon: coupon rate di ciascun titolo che compone il ptf;
%description: denominazione di ogni titolo che compone il ptf;
%instrument: tipologia di ogni titolo che compone il ptf;
%price: prezzo di mercato alla data di settlement di ciascun titolo che
%compone il ptf;
%value: valore nominale di ciascun titolo che compone il ptf;
%forecastDate: data di confronto tra il prezzo di mkt e il prezzo teorico
%di ptf;
%valMkt: valore di mkt osservato per ciascun titolo che compone il ptf;
%dirty: prezzo tel quel teorico per ciascun titolo che compone il ptf
%calcolato alla data di ForecastDate con la curva dei tassi costruita con
%il metodo segnato in input;
%clean: prezzo clean teorico calcolato con la curva dei tassi costruita con
%la curva dei tassi costruita con metodo indicato in input;
% difference: differenza di prezzo tra il prezzo di mkt e il prezzo clean
% teorico di ciascun titolo appartenente al ptf;
%portafoglio di
%
% Le righe di questa tabella si riferiscono ai titolo che compongono il
% ptf, una riga per titolo.

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

