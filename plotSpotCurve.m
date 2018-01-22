function plotSpotCurve( bonds, curve, startDate, endDate, color)

% "plotSpotCurve" è una funzione che permette di creare un plot raffiguran-
% te la curva dei tassi spot data dalla funzione createCurve. Il grafico ha
% come titolo: " Curva dei tasi BTP al 27-Sep-2017". Nell'asse delle
% ascisse è riportata la scadenza a cui si riferiscono i tassi spot e lungo
% l'asse delle ordinate la maturity. Nello stesso grafico è riportato anche
% un scatter plot con i tassi spot alle diverse scadenze.

%% controllare che startDate e end Date siano nell'intervallo accettabile

%% plot della curva
figure
startDate=datenum('22-Nov-2017');
point= datenum(startDate):180:datenum(endDate);
yield = bndyield(bonds.price,bonds.coupon,bonds.date(1),bonds.maturity);
plot(point, getZeroRates(curve, point),color)
title('Curva dei tassi BTP al 22-Nov-2017')
xlabel('Maturity')
ylabel('Spot')
hold on
scatter(datenum(bonds.maturity),yield,'black')
datetick('x')

end

