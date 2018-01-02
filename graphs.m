function [ cf,da ] = graphs(dateSettlement,dateMaturity,coupon )
% GRAPHS calcola i cashflows cedolari e le date di pagamento delle cedole e
% ne fa un grafico.
[cf,da]=cfamounts(coupon,dateSettlement,dateMaturity);
cfplot(da,cf,'ShowAmnt',[1,2,3,4],'DateFormat',28)

end

