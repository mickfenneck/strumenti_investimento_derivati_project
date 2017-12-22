function [ portfolio ] = createPortfolio( btp,bonds,dateSettlement,portCodes)
%CREATEPORTFOLIO Summary of this function goes here
%   Detailed explanation goes here
portfolio = bonds(portCodes,:);
portfolio.date = repelem(datenum(dateSettlement),length(portCodes))';
%price
index = find(btp.date == datenum(dateSettlement));
portfolio.prices = btp(index,portCodes).Variables';

end

