function [ value ] = portfolioRealValue( bonds )
%PORTFOLIOREALVALUE Summary of this function goes here
%   Detailed explanation goes here

% nel valore teorico � /100?
value = bonds.clean'*bonds.value/100;

end

