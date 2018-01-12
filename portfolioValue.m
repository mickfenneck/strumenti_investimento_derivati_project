function [ value ] = portfolioValue( portfolio )
%PORTFOLIOVALUE Summary of this function goes here
%   Detailed explanation goes here
value = portfolio.prices'*portfolio.values/100;

end

