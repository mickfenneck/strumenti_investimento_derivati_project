%% Script del progetto di Strumenti di Investimento e Derivati
% Questo script permette di far funzionare il progetto semplicemente
% trascinando l'icona dello script nel Current Folder
clear
clc

% Il comando carica i dati salvati in formato .mat:
load data/btp.mat

% creo due bond
a = bond(12,'12-Aug-2018','12-Aug-2018',0.13);
b = bond(13,'12-Aug-2018','12-Aug-2018',0.13);

bonds = [a b];

for i=1:length(bonds)
    disp(bonds(i).price);
end

port = [{'btp1'},{'btp2'},{'btp3'},{'btp4'},...
        {'btp5'},{'btp6'},{'btp7'},{'btp8'},{'btp9'}];
    
printBtpPlots(btp,port,btp.date(1),btp.date(end));
%printBtpPlots(btp,port,btp.date(1),btp.date(end-100));

