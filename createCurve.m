function [curva] = createCurve( bonds,model )
%CREATECURVE Summary of this function goes here
%   Detailed explanation goes here

inst=repelem({'Bond'},length(portCodes))';
char=[datenum(btp.date) datenum(btp.maturity) btp.price];
instr=[btp.date datenum(btp.maturity) btp.price sbtp.coupon];

if model == 'Bootstrap'
    curva =IRDataCurve.bootstrap('Zero',btp.date(1),inst,char,'InstrumentCouponRate',btp.coupon);
elseif model == 'NelsonSiegel'
    instr=[btp.date datenum(btp.maturity) btp.price btp.coupon];
    curva= IRFunctionCurve.fitNelsonSiegel('Zero',btp.date(1), instr);
elseif model == 'Svensson'
    curva=IRFunctionCurve.fitSvensson( 'Zero',btp.date(1),instr);
else
    error('Model deve contenere i seguenti valori: Bootstrap, NelsonSiegel, Svensson');
end


end

