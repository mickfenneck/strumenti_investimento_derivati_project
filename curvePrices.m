function [ bonds ] = curvePrices( bonds, curve)
% curvePrices calcola i prezzi teorici telquel(dirty) e secchi (clean) di       
% tutti i titoli scelti in input che compongono il portafoglio, utilizzando
% la curva dei tassi stimata precedentemente.

% bonds.dirty è il vettore colonna composto da tanti elementi quanti sono i
% bonds usati per comporre il portafoglio. Questo vettore andrà riempito
% con i prezzi dirty teorici dei rispettivi bond che compongono il 
% portafoglio, calcolati utilizzando il ciclo for seguente.
bonds.dirty = repelem(0,length(bonds.instrument))';

% bonds.clean è il vettore colonna composto da tanti elementi quanti sono i
% bonds usati per comporre il portafoglio. Questo vettore andrà riempito
% con i prezzi clean teorici dei rispettivi bond che compongono il 
% portafoglio, calcolati utilizzando il ciclo for seguente.
bonds.clean = repelem(0,length(bonds.instrument))';

% per i che varia da 1 al numero di bond presenti in portafoglio
for i=1:length(bonds.instrument)
    % cfamounts restituisce i flussi di cassa e le date di pagamento delle
    % cedole di tutti i bonds che compongono il portafoglio dalla data di
    % valutazione del prezzo teorico del portafoglio(settlement) alla 
    % data di maturity di ogni singolo titolo (i).
    [cf,da]=cfamounts(bonds.coupon(i),datestr(bonds.date(i)),datestr(bonds.maturity(i)));
    % getDiscountFactors prende i discount factors con cui andremo ad
    % attualizzare i flussi di cassa cedolari prima stimati con cfamounts.
    % I discount factors vengono presi dalla curva stimata in createCurve.
    disc=getDiscountFactors(curve,da);
    % bonds.dirty(i) rappresenta il prezzo tel-quel del titolo i-esimo nel
    % portafoglio, questo dato verrà sostituito all'elemento 0 nella 
    % i-esima riga del vettore bonds.dirty.
    bonds.dirty(i)=cf(2:end)*disc(2:end);
    % bonds.clean(i) rappresenta il prezzo tel-quel del titolo i-esimo nel
    % portafoglio, questo dato verrà sostituito all'elemento 0 nella  
    % i-esima riga del vettore bonds.clean.
    bonds.clean(i)=cf*disc;
end

end

