function [ bonds ] = curvePrices( bonds, curve, forecastDate)
%CURVEPRICE Calcola curva del portafoglio
%   Detailed explanation goes here

bonds.dirty = repelem(0,length(bonds.instrument))';
bonds.clean = repelem(0,length(bonds.instrument))';

for i=1:length(bonds.instrument)
    [cf,da]=cfamounts(bonds.coupon(i),datestr(bonds.date(i)),datestr(forecastDate));
    disc=getDiscountFactors(curve,da);
    % prezzi telquel
    bonds.dirty(i)=cf(2:end)*disc(2:end);
    %prezzi secchi
    bonds.clean(i)=cf*disc;
end

end

