clear
clc

load data/dataBTP.mat


%% createCurve

inst={'Bond';'Bond';'Bond';'Bond';}

char=[datenum(btp.date) datenum(btp.maturity) btp.price]
curv=IRDataCurve.bootstrap('Zero',btp.date(1),inst,char,'InstrumentCouponRate',btp.coupon);
%la curva ns vuole inst diversa
instr=[btp.date datenum(btp.maturity) btp.price btp.coupon];
curv2= IRFunctionCurve.fitNelsonSiegel('Zero',btp.date(1), instr);
curv3=IRFunctionCurve.fitSvensson( 'Zero',btp.date(1),instr);


%% curvePrice

% stima del prezzo di un titolo usando la curva
tit.price=104.19;
tit.date='15-Sep-2017';
% caratteristiche del titolo 
[cf,da]=cfamounts(0.045,tit.date,'1-Aug-2018')

disc=getDiscountFactors(curv,da);
disc2=getDiscountFactors(curv2,da);
disc3=getDiscountFactors(curv3,da);
% prezzi telquel
tit.dirty=cf(2:end)*disc(2:end);
tit.dirty2=cf(2:end)*disc2(2:end);
tit.dirty3=cf(2:end)*disc3(2:end);
%prezzi secchi
tit.clean=cf*disc;
tit.clean2=cf*disc2;
tit.clean3=cf*disc3;

% aggiungo titolo cosi creo portafoglio

tit1.price = 108.49;
tit1.date = '15-Sep-2017';
port.coupon = [0.045;0.0425];
port.date = [tit.date; tit1.date];
port.maturity = {'1-Aug-2018';'01-Sep-2019'};
port.price = [tit.price; tit1.price];

% prezzo portafoglio usando le curve
[cf,da] = cfamounts(port.coupon,port.date,port.maturity);
[cfp,dap] = cfport(cf,da);
disc = getDiscountFactors(curv,dap);
disc2 = getDiscountFactors(curv2,dap);
disc3 = getDiscountFactors(curv3,dap);
port.eprice = cfp*disc;
port.eprice2 = cfp*disc2;
port.eprice3= cfp*disc3;
tab = table(port.price, port.eprice, port.eprice2,port.eprice3, 'VariableNames',...
    {'True' 'Bootstrap' 'NelsonSiegel' 'Svensson'}, 'RowNames',{'Btp' 'Btp1'});
disp(tab)

%% plot della curva
figure
point= datenum('01-Oct-2017'):180:datenum('31-Dec-2028');
yield1 = bndyield(btp.price,btp.coupon,btp.date,btp.maturity);
plot(point, getParYields(curv2, point),'r')
title('Curva dei tassi BTP al 15-Sep-2017')
xlabel('Maturity')
ylabel('Yield')
hold on
plot(point, getParYields(curv3, point),'b')
hold on
plot(point, getParYields(curv, point),'g')
scatter(datenum(btp.maturity),yield1,'black')
datetick('x')