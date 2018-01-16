function plotForwardCurve( bonds,curvaforward, startDate, endDate,color )
%PLOTFORWARDCURVE Summary of this function goes here

%% controllare che startDate e end Date siano nell'intervallo accettabile

%% plot della curva
figure
startDate=datenum('20-Nov-2017');
point= datenum(startDate):180:datenum(endDate);
yield = bndyield(bonds.price,bonds.coupon,bonds.date,bonds.maturity);
plot(point, getForwardRates(curvaforward, point),color)
title('Curva dei tassi forward al 20-Nov-2017')
xlabel('Maturity')
ylabel('Yield')
hold on
scatter(datenum(bonds.maturity),yield,'g')
datetick('x')

end


