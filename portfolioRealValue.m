function [ value ] = portfolioRealValue( bonds )
%PORTFOLIOREALVALUE Summary of this function goes here
%   Detailed explanation goes here

% nel valore teorico è /100?
value = bonds.clean'*bonds.values/100;

end

