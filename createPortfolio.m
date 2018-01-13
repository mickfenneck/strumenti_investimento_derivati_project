function [ portfolio ] = createPortfolio( btp,bonds,dateSettlement,port,forecastDate,valMkt)
%CREATEPORTFOLIO Summary of this function goes here
%   Detailed explanation goes here
nBonds = length(port.Properties.RowNames);
portfolio = bonds(port.Properties.RowNames',:);
portfolio.date = repelem({dateSettlement},nBonds)';
portfolio.instrument = repelem({'Bond'},nBonds)';
%price
index = find(btp.date == datenum(dateSettlement));
portfolio.price = btp(index,port.Properties.RowNames').Variables';
portfolio.value = port.Value;
%creo elenco date forecast
portfolio.forecastDate = repelem({forecastDate},nBonds)';
%inserisco valMkt
portfolio.valMkt = valMkt;

end

