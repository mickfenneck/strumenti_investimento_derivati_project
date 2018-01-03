%% Script del progetto di Strumenti di Investimento e Derivati
% Questo script permette di far funzionare il progetto semplicemente
% trascinando l'icona dello script nel Current Folder
clear
clc

% Il comando carica i dati salvati in formato .mat:
load data/btp.mat
load data/bonds.mat

dateSettlement = '17-Nov-2017';
portCodes = [{'btp1'},{'btp2'},{'btp7'},{'btp9'}];
portValues = [1000;1000;1000;1000];
model1 = 'Bootstrap';
model2 = 'NelsonSiegel';
model3 = 'Svensson';
valMkt = [103.12; 103.21; 101.11; 104.99];

%[port, curva1,vm] = curvedeitassi(btp,bonds,dateSettlement,portCodes,portValues,model1,valMkt);
%[port, curva2,vm] = curvedeitassi(btp,bonds,dateSettlement,portCodes,portValues,model2,valMkt);
[port, curva3,vm] = curvedeitassi(btp,bonds,dateSettlement,portCodes,portValues,model3,valMkt);

disp('Portfolio');
disp(port);
difference = comparePortfolio(port);
disp('Portfolio difference');
disp(difference);
% for i = 1:length(portCodes)
%     disp(portCodes(i));
% end
%port = bonds({'btp1','btp3'},:);

%port = bonds({'btp1','btp3'},:)



% data = [{'btp1'},{'btp2'};
%         0.012,0.045;
%         '12-Aug-2028','12-Aug-2038'];

% % creo due bond
% a = bond(12,'12-Aug-2018','12-Aug-2018',0.13);
% b = bond(13,'12-Aug-2018','12-Aug-2018',0.13);
% c = bond(13,'12-Aug-2018','12-Aug-2018',0.13);
% 
% %= bond_portfolio(a,b,c);
% disp(port);
% 
% bonds = [a b];
% 
% for i=1:length(bonds)
%     disp(bonds(i).price);
% end
% 
% port = [{'btp1'},{'btp2'},{'btp3'},...
%         {'btp4'},{'btp5'},{'btp6'},...
%         {'btp7'},{'btp8'},{'btp9'}];
%     
% printBtpPlots(btp,port,btp.date(1),btp.date(end));
% %printBtpPlots(btp,port,btp.date(1),btp.date(end-100));

