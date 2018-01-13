function [ value ] = portfolioRealValue( bonds,valMkt )
%PORTFOLIOREALVALUE Summary of this function goes here
%   Detailed explanation goes here

% nel valore teorico è /100?
value = valMkt'*bonds.values/100;

end

