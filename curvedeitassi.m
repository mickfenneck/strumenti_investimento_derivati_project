function [ out ] = curvedeitassi(btp,bonds,dateSettlement,portCodes,model )

%CURVEDEITASSI è una funzione che mi permette di....


% All'interno del programma possiamo individuare i seguenti passaggi....
% Partendo dai dati di input... Successivamente sono stati calcolati..
% Infine sono stati calcolati...Come output otteniamo...con relativo plot..

%%dati btp  organizzati in struttura

%stru={'Bond'; 'Bond';'Bond';'Bond';'Bond'; };
%prezzi=[100.48;105.37;108.17;114.48;108.92];

%matu=[datenum('4-Jan-2022'),datenum('4-Jul-2023'),datenum('4-Jul-2025')...
      %,datenum('4-Jul-2018'),datenum('4-Jan-2020')];
%sett=[datenum('20-Nov-2017'),datenum('20-Nov-2017'),datenum('20-Nov-2017')...
  %    ,datenum('20-Nov-2017'),datenum('20-Nov-2017')];

  %cedole=[0.05;0.0375;0.0325;0.0425;0.0325];
  %
  %btp=struct('name',{stru},'price',prezzi,'maturity',{matu},'coupon',cedole...
      %,'date',sett);

    


%Questi dati permettono di costruire la curva dei tassi con la funzione
%MATLAB IRDataCurve.bootstrap

%curva=IRDataCurve.bootstrap('Zero',btp.date(1,1),btp.name,[btp.date' btp.maturity'...
    %btp.price],'InstrumentCouponRate',btp.coupon);


%descrizione degli input

%input1= matrice....
%input2= dati relativi

%descrizione degli Output:

%output1=...
%output2=...

%All'interno del programma sono state richiamate le seguenti funzioni
%matlab già esistenti:....


%BIBLIOGRAFIA
%fonte utilizzata come approfondimento di...:
%"Titolo"
%(Autore)
%per la costruzione del programma la fonte utilizzata è il Toolbox.... di
%Matlab (mathworks USA)


%% Copyright (c) 2017
% Elia Scarparo     - Mat. 190459
% Michele Sordo     - Mat. 190205
% Stefano Zampiero  - Mat. 190203

%% COMANDI FUNZIONE


% Ogni comando e ogni passo del programma devono essere adeguatamente
% commentati (anche la struttura dei cicli o delle istruzioni se presenti)

%% function
portfolio = createPortfolio(btp,bonds,dateSettlement,portCodes);
%curva = createCurve(portfolio,model);
%[dirty, clean] = curvePrice(bonds,curve,model);
% bonds -> tabella iniziale -> selezioni titolo
% portfolio -> bond sistemata

out = portfolio;

%% prezzoPrev = real forecast(titolo, dataPrev, curva) -> valore al tot giorno secondo la curva STEF
%% compareResults(titolo, valoreMkt, data, prezzoPrev); -> confronti differenza tra vmkt e prezzoprev ELIA
%% plot grafici ELIA



%% IN AGGIUNTA AL CONTENUTO DI OUTPUT MINIMO RICHIESTO
%Se si desidera aggiungere qualcosa che si ritiene utile per una migliore
%comprensione del programma (esempio:plot o elaborazioni aggiuntive...)

end


