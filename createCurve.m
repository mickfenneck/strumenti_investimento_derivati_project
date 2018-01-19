function [curva] = createCurve( bonds,model )
%createCurve calcola la curva dei tassi usando i dati della tabella bonds
%creata con la funzione mergeData. Questa funzione crea le curve dei tassi
%stimate con il metodo specificato in input dall'utente. Questi metodi
%possono essere: Bootstrap, Nelson Siegel e Svensson. La funzione
%attraverso la condizione if costruisce automaticamente la curva corretta
%in base al metodo scelto in input.
%Da notare la diversa tecnica di costruzione della curva dei tassi tra il
%metodo Bootstrap e i metodi Nelson Siegel e Svensson.

if strcmp(model,'Bootstrap')
    char = [datenum(bonds.date) datenum(bonds.maturity) bonds.price];
    curva =IRDataCurve.bootstrap('Zero',datenum(bonds.date(1)),bonds.instrument,char,'InstrumentCouponRate',bonds.coupon);
elseif strcmp(model,'NelsonSiegel') || strcmp(model,'Svensson')
    instr=[datenum(bonds.date) datenum(bonds.maturity) bonds.price bonds.coupon];
    if strcmp(model,'NelsonSiegel')
        curva= IRFunctionCurve.fitNelsonSiegel('Zero',datenum(bonds.date(1)), instr);
    elseif strcmp(model,'Svensson')
        curva=IRFunctionCurve.fitSvensson( 'Zero',datenum(bonds.date(1)),instr);
    end
else
    error('Model deve contenere i seguenti valori: Bootstrap, NelsonSiegel, Svensson');
end

end

