function plotCurve( bonds, curve, model)

% plotCurve è una funzione che permette di creare una figure raffigurante:
% - la curva dei tassi spot
% - la curva dei tassi yields
% - il confronto tra le due precedenti curve
% Nell'asse delle ascisse è riportata la scadenza a cui si riferiscono i 
% tassi spot e lungo l'asse delle ordinate il tasso.
% Nei grafici è riportato anche un scatter plot con i tassi spot alle 
% diverse scadenze.

% Per calcolare getZeroRates è necessario avere un arco temporale
% successivo alla settlement date. In base a ciò si fissa come startDate il
% giorno successivo alla settlementDate.
startDate = datenum(bonds.date(1))+1;
% Come data finale si sceglie la maturity maggiore dei titoli contenuti in
% bonds
endDate = max(datenum(bonds.maturity));
% si definisce l'intervallo
point= startDate:180:endDate;
%% controllare che davvero i prezzi non debbano essere clean
yield = bndyield(bonds.price,bonds.coupon,bonds.date(1),bonds.maturity);

% Si apre la figura contenente i 3 differenti grafici
figure
% Primo grafico, in alto a sinistra
subplot(2,2,1)
% plot della curva dei tassi spot, rossa
plot(point, getZeroRates(curve, point),'r')
title('Curva dei tassi SPOT')
xlabel('Maturity')
ylabel('Rate')
hold on
%si aggiungono i tassi spot alle diverse scadenze
scatter(datenum(bonds.maturity),yield)
datetick('x')
hold off

% Secondo grafico, in alto a destra
subplot(2,2,2)
% plot della curva dei tassi yield, blu
plot(point, getParYields(curve, point),'b')
title('Curva dei tassi YIELDS')
xlabel('Maturity')
ylabel('Rate')
hold on
scatter(datenum(bonds.maturity),yield)
datetick('x')
hold off

% Terzo grafico, in basso
subplot(2,2,[3 4])
% plot della curva dei tassi spot, rossa
plot(point, getZeroRates(curve, point),'r')
hold on
% plot della curva dei tassi yield, blu
plot(point, getParYields(curve, point),'b')
scatter(datenum(bonds.maturity),yield)
title('Confronto SPOT-YIELDS')
xlabel('Maturity')
ylabel('Rate')
datetick('x')
legend('Location','southeast')
legend('tassi spot','tassi yield')
hold off

% definizione del titolo della figura
figuretitle =  {['Curve dei tassi, metodo',' ',model];
               ['Settlement date',' ',datestr(startDate-1), ', ','Maturity date',' ',datestr(endDate)]};
suptitle(figuretitle)

end

