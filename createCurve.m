function [curva] = createCurve( bonds,model )
% createCurve calcola la curva dei tassi usando i dati della tabella bonds,
% secondo il metodo specificato in input dall'utente.
% I metodi che si possono utilizzare, come precedentemente indicato, sono:
% Bootstrap, Nelson Siegel e Svensson. 

% La funzione attraverso la condizione if costruisce automaticamente la 
% curva corretta in base al metodo dato in input.
% È interessante notare la differente classe della curva dei tassi tra il
% metodo Bootstrap e i metodi Nelson Siegel e Svensson.

% Se l'input è 'Bootstrap'
if strcmp(model,'Bootstrap')
    % si crea la matrice char con colonne date (convertita in numero),
    % maturity (convertita in numero) e prezzo di mercato dei btp
    char = [datenum(bonds.date) datenum(bonds.maturity) bonds.price];
    % si crea la curva secondo il metodo Bootstrap
    curva =IRDataCurve.bootstrap('Zero',datenum(bonds.date(1)),bonds.instrument,char,'InstrumentCouponRate',bonds.coupon);
% altrimenti, se l'input è NelsonSiegel o Svensson
elseif strcmp(model,'NelsonSiegel') || strcmp(model,'Svensson')
    % si crea la matrice contenente le colonne date (convertita in numero),
    % maturity (convertita in numero), prezzo di mercato e coupon dei btp
    instr=[datenum(bonds.date) datenum(bonds.maturity) bonds.price bonds.coupon];
    % costruita la colonna di crea la curva, a seconda del metodo inserito 
    % in input
    if strcmp(model,'NelsonSiegel')
        curva= IRFunctionCurve.fitNelsonSiegel('Zero',datenum(bonds.date(1)), instr);
    elseif strcmp(model,'Svensson')
        curva=IRFunctionCurve.fitSvensson( 'Zero',datenum(bonds.date(1)),instr);
    end
% se il metodo inserito non fosse alcuno dei tre possibili, si genera un
% errore
else
    error('Model deve contenere i seguenti valori: Bootstrap, NelsonSiegel, Svensson');
end

end

