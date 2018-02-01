function compareCurves(btp,bonds)
% compareCurves crea un grafico al fine di confrontare le curve spot e 
% yield calcolate secondo le tre differenti metodologie.


% Creazione, come in curvedeitassi(...) dei dati di input per la creazione 
% delle curve
bonds = mergeData(btp,bonds);
% Creazione curva 'Bootstrap'
curve1 = createCurve(bonds,'Bootstrap');
% Creazione curva 'NelsonSiegel'
curve2 = createCurve(bonds,'NelsonSiegel');
% Creazione curva 'Svensson'
curve3 = createCurve(bonds,'Svensson');

% Per utilizzare getZeroRates è necessario avere un arco temporale
% successivo alla settlement date. In base a ciò si fissa come startDate il
% giorno successivo alla settlementDate.
startDate = datenum(bonds.date(1))+1;
% Come data finale si sceglie la maturity maggiore dei titoli contenuti in
% bonds
endDate = max(datenum(bonds.maturity));
% si definisce l'intervallo
point= startDate:180:endDate;

yield = bndyield(bonds.price,bonds.coupon,bonds.date(1),bonds.maturity);

% Si apre la figura contenente i 2 differenti grafici
figure
% Primo grafico, a sinistra
subplot(1,2,1)
% curva spot Bootstrap, rossa
plot(point, getZeroRates(curve1, point),'r')
hold on
% curva spot NelsonSiegel, verde
plot(point, getZeroRates(curve2, point),'g')
% curva spot Svensson, blu
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
% curva yield Bootstrap, rossa
plot(point, getParYields(curve1, point),'r')
hold on
% curva yield NelsonSiegel, verde
plot(point, getParYields(curve2, point),'g')
% curva yield Svensson, blu
plot(point, getParYields(curve3, point),'b')
scatter(datenum(bonds.maturity),yield)
title('Curva dei tassi YIELDS')
xlabel('Maturity')
ylabel('Rate')
datetick('x')
legend('Location','southeast')
legend('Bootstrap','NelsonSiegel','Svensson')
hold off

% definizione del titolo della figura
figuretitle =  {'Confronto tra curve nei tre diversi metodi';
               ['Settlement date',' ',datestr(datenum(startDate)-1), ', ','Maturity date',' ',endDate]};
suptitle(figuretitle)

end


