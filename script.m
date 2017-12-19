%% Script del progetto di Strumenti di Investimento e Derivati
clear
clc

load data/btp.mat

% creo due bond
a = bond(12,'12-Aug-2018','12-Aug-2018',0.13);
b = bond(13,'12-Aug-2018','12-Aug-2018',0.13);

bonds = [a b];

for i=1:length(bonds)
    disp(bonds(i).price);
end

printBtpPlots(btp);

