function compareCurves(btp,bonds)


%% FUNCTION
model1 = 'Bootstrap';
model2 = 'NelsonSiegel';
model3 = 'Svensson';
bonds = mergeData(btp,bonds);
curve1 = createCurve(bonds,model1);
curve2 = createCurve(bonds,model2);
curve3 = createCurve(bonds,model3);

startDate = datestr(datenum(bonds.date(1))+1);      % doppio controllo
endDate = datestr(max(datenum(bonds.maturity)));


%% plot della curva
figure

%SPOT (SX1)
subplot(1,2,1)
point= datenum(startDate):180:datenum(endDate);
yield = bndyield(bonds.price,bonds.coupon,bonds.date(1),bonds.maturity);
plot(point, getZeroRates(curve1, point),'r')
hold on
plot(point, getZeroRates(curve2, point),'g')
plot(point, getZeroRates(curve3, point),'b')
scatter(datenum(bonds.maturity),yield)
title('Curva dei tassi SPOT')
xlabel('Maturity')
ylabel('Rate')
datetick('x')
legend('Location','southeast')
legend('Bootstrap','NelsonSiegel','Svensson')
hold off


%YIELDS dx1
subplot(1,2,2)
plot(point, getParYields(curve1, point),'r')
hold on
plot(point, getParYields(curve2, point),'g')
plot(point, getParYields(curve3, point),'b')
scatter(datenum(bonds.maturity),yield)
title('Curva dei tassi YIELDS')
xlabel('Maturity')
ylabel('Rate')
datetick('x')
legend('Location','southeast')
legend('Bootstrap','NelsonSiegel','Svensson')
hold off

figuretitle =  {'Confronto tra curve nei tre diversi metodi';
               ['Settlement date',' ',datestr(datenum(startDate)-1), ', ','Maturity date',' ',endDate]};
suptitle(figuretitle)

end


