function [ bonds ] = compareResult(bonds)

bonds.difference = repelem(0,length(bonds.instrument))';

for i=1:length(bonds.instrument)
    bonds.difference(i) = bonds.price(i)-bonds.clean(i);
end

end

