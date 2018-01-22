function plotCurve( bonds, curve, startDate, endDate, model)

% "plotSpotCurve" è una funzione che permette di creare un plot raffiguran-
% te la curva dei tassi spot data dalla funzione createCurve. Il grafico ha
% come titolo: " Curva dei tasi BTP al 27-Sep-2017". Nell'asse delle
% ascisse è riportata la scadenza a cui si riferiscono i tassi spot e lungo
% l'asse delle ordinate la maturity. Nello stesso grafico è riportato anche
% un scatter plot con i tassi spot alle diverse scadenze.

%% plot della curva
figure

%sx1
subplot(2,2,1)
point= datenum(startDate):180:datenum(endDate);
yield = bndyield(bonds.price,bonds.coupon,bonds.date(1),bonds.maturity);
plot(point, getZeroRates(curve, point),'r')
title('Curva dei tassi SPOT')
xlabel('Maturity')
ylabel('Rate')
hold on
scatter(datenum(bonds.maturity),yield)
datetick('x')
hold off

%dx1

% "plotYieldCurve" è una funzione che permette di creare un plot raffiguran-
% te la curva dei tassi par yield costruita sulla base degli input forniti.
% Il grafico ha come titolo: " Curva dei tasi BTP al 15-Sep-2017". Nell'as-
% se delle ascisse è riportata la scadenza a cui si riferiscono i tassi 
% par yields e lungo l'asse delle ordinate la maturity. Nello stesso grafi-
% co è riportato anche un scatter plot con i tassi par yield alle diverse 
% scadenze.
%% controllare che startDate e end Date siano nell'intervallo accettabile

subplot(2,2,2)
plot(point, getParYields(curve, point),'b')
title('Curva dei tassi YIELDS')
xlabel('Maturity')
ylabel('Rate')
hold on
scatter(datenum(bonds.maturity),yield)
datetick('x')
hold off

subplot(2,2,[3 4])

plot(point, getZeroRates(curve, point),'r')
hold on
plot(point, getParYields(curve, point),'b')
scatter(datenum(bonds.maturity),yield)
title('Confronto SPOT-YIELDS')
xlabel('Maturity')
ylabel('Rate')
datetick('x')
legend('Location','southeast')
legend('tassi spot','tassi yield')
hold off

figuretitle =  {['Curve dei tassi, metodo',' ',model];
               ['Settlement date',' ',datestr(datenum(startDate)-1), ', ','Maturity date',' ',endDate]};
suptitle(figuretitle)
end

