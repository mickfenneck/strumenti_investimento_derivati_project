%% Script Curve dei tassi del progetto di Strumenti di Investimento e Derivati
% Lo script illustra come richiamare la funzione "curvedeitassi(..)",
% presenta come impostare gli input della funzione e fornisce un caso d'uso
% della stessa.

%% 0. Intestazione
% pulisce il workspace dalle variabili precedenti
clear
% pulisce la console - Command Window - di Matlab
clc
% Caricamento i dati salvati in formato .mat:
load data/btp.mat       % fornito da progetto
load data/bonds.mat     % creato alla base del secondo foglio di btp.xlsx

compareCurves(btp,bonds);
