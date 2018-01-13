function [curva] = createCurve( bonds,model )
%CREATECURVE Summary of this function goes here
%   Detailed explanation goes here
if strcmp(model,'Bootstrap')
    char = [datenum(bonds.date) datenum(bonds.maturity) bonds.prices];
    curva =IRDataCurve.bootstrap('Zero',datenum(bonds.date(1)),bonds.instrument,char,'InstrumentCouponRate',bonds.coupon);
elseif strcmp(model,'NelsonSiegel') || strcmp(model,'Svensson')
    instr=[datenum(bonds.date) datenum(bonds.maturity) bonds.prices bonds.coupon];
    if strcmp(model,'NelsonSiegel')
        curva= IRFunctionCurve.fitNelsonSiegel('Zero',datenum(bonds.date(1)), instr);
    elseif strcmp(model,'Svensson')
        curva=IRFunctionCurve.fitSvensson( 'Zero',datenum(bonds.date(1)),instr);
    end
else
    error('Model deve contenere i seguenti valori: Bootstrap, NelsonSiegel, Svensson');
end

end

