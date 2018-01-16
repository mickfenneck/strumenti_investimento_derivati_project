function [curvaforward] = createForwardCurve( bonds,model )
%createForwardCurve è una funzione che crea la curva dei tassi forwardin base al
%modello scelto in input fra Bootstrap,NelsonSiegel e Svensson)

if strcmp(model,'Bootstrap')
    char = [datenum(bonds.date) datenum(bonds.maturity) bonds.price];
    curvaforward =IRDataCurve.bootstrap('Forward',datenum(bonds.date(1)),bonds.instrument,char,'InstrumentCouponRate',bonds.coupon);
elseif strcmp(model,'NelsonSiegel') || strcmp(model,'Svensson')
    instr=[datenum(bonds.date) datenum(bonds.maturity) bonds.price bonds.coupon];
    if strcmp(model,'NelsonSiegel')
        curvaforward= IRFunctionCurve.fitNelsonSiegel('Forward',datenum(bonds.date(1)), instr);
    elseif strcmp(model,'Svensson')
        curvaforward=IRFunctionCurve.fitSvensson( 'Forward',datenum(bonds.date(1)),instr);
    end
else
    error('Model deve contenere i seguenti valori: Bootstrap, NelsonSiegel, Svensson');
end

end

