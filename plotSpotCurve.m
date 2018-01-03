function [ yield ] = plotSpotCurve( bonds, curve, startDate, endDate, color)
%PLOTSPOTCURVE Summary of this function goes here
%   Detailed explanation goes here

%% controllare che startDate e end Date siano nell'intervallo accettabile

%% plot della curva
figure
point= datenum(startDate):180:datenum(endDate);
yield = bndyield(bonds.prices,bonds.coupon,bonds.date,bonds.maturity);
plot(point, getParYields(curve, point),color)
title('Curva dei tassi BTP al 15-Sep-2017')
xlabel('Maturity')
ylabel('Yield')
hold on
scatter(datenum(bonds.maturity),yield,'black')
datetick('x')

end

