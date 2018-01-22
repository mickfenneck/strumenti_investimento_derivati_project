function plotYieldCurve( bonds,curva ,startDate, endDate,color )
% "plotYieldCurve" è una funzione che permette di creare un plot raffiguran-
% te la curva dei tassi par yield costruita sulla base degli input forniti.
% Il grafico ha come titolo: " Curva dei tasi BTP al 15-Sep-2017". Nell'as-
% se delle ascisse è riportata la scadenza a cui si riferiscono i tassi 
% par yields e lungo l'asse delle ordinate la maturity. Nello stesso grafi-
% co è riportato anche un scatter plot con i tassi par yield alle diverse 
% scadenze.
%% controllare che startDate e end Date siano nell'intervallo accettabile

%% plot della curva
figure

point= datenum(startDate):180:datenum(endDate);
yield = bndyield(bonds.price,bonds.coupon,bonds.date,bonds.maturity);
plot(point, getParYields(curva, point),color)
title('Curva dei tassi yields BTP al 22-Nov-2017')
xlabel('Maturity')
ylabel('Yield')
hold on
scatter(datenum(bonds.maturity),yield,'r')
datetick('x')

end

