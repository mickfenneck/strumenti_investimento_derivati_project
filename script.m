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
portValues = [1000;500;3000;2000];
model1 = 'Bootstrap';
model2 = 'NelsonSiegel';
model3 = 'Svensson';
valMkt = [103.12; 103.21; 101.11; 104.99];

[port, curva1,vm] = curvedeitassi(btp,bonds,dateSettlement,portCodes,portValues,model1,valMkt);
%[port, curva2,vm] = curvedeitassi(btp,bonds,dateSettlement,portCodes,portValues,model2,valMkt);
%[port, curva3,vm] = curvedeitassi(btp,bonds,dateSettlement,portCodes,portValues,model3,valMkt);

disp('Portfolio');
disp(port);
difference = comparePortfolio(port);
disp('Portfolio difference');
disp(difference);
