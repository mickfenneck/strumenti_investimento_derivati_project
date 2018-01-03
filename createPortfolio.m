function [ portfolio, valore_mkt ] = createPortfolio( btp,bonds,dateSettlement,portCodes,portValues)
%CREATEPORTFOLIO Summary of this function goes here
%   Detailed explanation goes here
portfolio = bonds(portCodes,:);
portfolio.date = repelem(datenum(dateSettlement),length(portCodes))';
portfolio.instrument = repelem({'Bond'},length(portCodes))';
%price
index = find(btp.date == datenum(dateSettlement));
portfolio.prices = btp(index,portCodes).Variables';
portfolio.values = portValues;

valore_mkt = portfolio.prices'*portValues/100;
end

