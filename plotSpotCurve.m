function plotSpotCurve( bonds, curve, startDate, endDate, color)

%plotSpotCurve è una funzione che permette di creare un plot raffigurante
%la curva 

%% controllare che startDate e end Date siano nell'intervallo accettabile

%% plot della curva
figure
startDate=datenum('20-Nov-2017');
point= datenum(startDate):180:datenum(endDate);
yield = bndyield(bonds.price,bonds.coupon,bonds.date(1),bonds.maturity);
plot(point, getZeroRates(curve, point),color)
title('Curva dei tassi BTP al 27-Sep-2017')
xlabel('Maturity')
ylabel('Yield')
hold on
scatter(datenum(bonds.maturity),yield,'black')
datetick('x')

end

