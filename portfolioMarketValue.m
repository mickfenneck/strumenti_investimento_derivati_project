function [ value ] = portfolioMarketValue( bonds )
%PORTFOLIOVALUE Summary of this function goes here
%   Detailed explanation goes here
value = bonds.valMkt'*bonds.values/100;

end

