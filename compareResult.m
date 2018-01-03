function [ bonds ] = compareResult(bonds,valMkt)

bonds.difference = repelem(0,length(bonds.instrument))';

for i=1:length(bonds.instrument)
    bonds.difference(i) = valMkt(i)-bonds.clean(i);
end

end

