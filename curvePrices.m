function [ bonds ] = curvePrices( bonds, curve)

%curvePrices calcola i prezzi teorici telquel(dirty) e secchi (clean) di       
%tutti i titoli scelti in input che compongono il portafoglio utilizzando
%la curva dei tassi stimata con il metodo scelto in input.

bonds.dirty = repelem(0,length(bonds.instrument))';
% bonds.dirty è il vettore colonna composto da tanti elementi quanti sono i
% bonds usati per comporre il portafoglio. Questo vettore andrà riempito
% con i prezzi dirty teorici dei rispettivi bond che compongono il 
% portafoglio, calcolati utilizzando il ciclo for seguente. 

bonds.clean = repelem(0,length(bonds.instrument))';
% bonds.clean è il vettore colonna composto da tanti elementi quanti sono i
% bonds usati per comporre il portafoglio. Questo vettore andrà riempito
% con i prezzi dirty teorici dei rispettivi bond che compongono il 
% portafoglio, calcolati utilizzando il ciclo for seguente.

for i=1:length(bonds.instrument)
    
    [cf,da]=cfamounts(bonds.coupon(i),bonds.forecastDate(i),datestr(bonds.maturity(i)));
    % cfamounts restituisce i flussi di cassa e le date di pagamento delle
    % cedole di tutti i bonds che compongono il ptf dalla data di
    % valutazione del prezzo teorico del portafoglio(forecastDate) alla 
    %data di maturity di ogni singolo titolo (i).
    disc=getDiscountFactors(curve,da);
    % getDiscountFactors prende i discount factors con cui andremo ad
    % attualizzare i flussi di cassa cedolari prima stimati con cfamounts.
    % I discount factors vengono presi dalla curva stimata in createCurve.
    bonds.dirty(i)=cf(2:end)*disc(2:end);
    % bonds.dirty(i) rappresenta il prezzo tel-quel del titolo i-esimo nel
    % nostro ptf, questo dato verrà sostituito all'elemento 0 nella i-esima 
    % riga del vettore bonds.dirty.
    bonds.clean(i)=cf*disc;
    % bonds.clean(i) rappresenta il prezzo tel-quel del titolo i-esimo nel
    % nostro ptf, questo dato verrà sostituito all'elemento 0 nella i-esima 
    % riga del vettore bonds.clean.
    
end

end

