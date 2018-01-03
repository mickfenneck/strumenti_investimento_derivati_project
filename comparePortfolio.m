function [ difference ] = comparePortfolio( bonds )
%CO Summary of this function goes here
%   Detailed explanation goes here
difference = sum(bonds.difference.*bonds.values);
end

