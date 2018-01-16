function [ portf ] = curvedeitassi(btp,bonds,dateSettlement,portfolio,model, forecastDate, valMkt,outputPlot)
%%CURVEDEITASSI è una funzione che mi permette di calcolare il valore di
% mercato di un portafoglio di titoli obbligazionari, stimare la curva dei
%tassi con 3 metodologie di stima (Bootstrap, Nelson-Siegel e Svensson), 
%estrarre i tassi spot, i tassi forward dalle curve e quindi utilizzare la 
%curva per stimare il prezzo teorico dei titoli presenti in portafoglio e 
%successivamente calcolare la differenza tra il loro valore reale e il 
%loro valore di mercato estendendo la valutazione anche al portafoglio.


% All'interno del programma possiamo individuare i seguenti passaggi....
% Partendo dai dati di input... 
%

%Successivamente sono stati calcolati..
% Infine sono stati calcolati...
%Come output otteniamo...con relativo plot..



 
%Questi dati permettono di costruire la curva dei tassi con la funzione
%MATLAB IRDataCurve.bootstrap
%MATLAB IRFunction.NelsonSI
%MATLAB IRDataCurve.bootstrap




%descrizione degli input

%input1= matrice....
%input2= dati relativi

%descrizione degli Output:

%output1=...
%output2=...

%% All'interno del programma sono state richiamate le seguenti funzioni
% COMANDI USATI COMPLESSIVAMENTE:
% 
% repelem
% datenum
% length
% find
% strcmp
% IRDataCurve.bootstrap
% IRFunctionCurve.fitNelsonSiegel
% IRFunctionCurve.fitSvensson
% error
% cfamounts
% datestr
% end
% getDiscountFactors
% sum
% figure
% datenum
% bndyield
% plot
% title
% xlabel
% ylabel
% hold on
% scatter
% datenum
% datetick
% clear
% clc
% load
% disp
% 
% 
% COMANDI USATI PER SINGOLA FUNZIONE:
% 
% script ( script iniziale di richiamo alla funzione curvedeitassi):
% clear
% clc
% load
% disp
% 
% curvedeitassi function ( funzione generale di richiamo alle seguenti funzioni):
% datestr
% 
% 1. createPortfolio function:
% repelem
% datenum
% length
% find
% 
% 2. createCurve function:
% strcmp
% datenum
% IRDataCurve.bootstrap
% IRFunctionCurve.fitNelsonSiegel
% IRFunctionCurve.fitSvensson
% error
% 
% 3. plotForwardCurve function:
% figure
% datenum
% bndyield
% plot
% title
% xlabel
% ylabel
% hold on
% scatter
% datenum
% datetick
% 
% 4. plotSpotCurve function
% figure
% datenum
% bndyield
% plot
% title
% xlabel
% ylabel
% hold on
% scatter
% datetick
% 
% 5. plotYieldCurve function
% 
% 6. curvePrices function:
% repelem
% length
% cfamounts
% datestr
% getDiscountFactors
% 
% 7. compareResult function:
% repelem
% length
% 
% 8. comparePortfolio function:
% sum
% Si troverà una spiegazione dettagliata di ogni singola funzione
% all'interno della funzione stessa
%% BIBLIOGRAFIA

%fonte utilizzata come approfondimento della metodologia di stima della 
%term structure con il modello di Nelson siegel e Svensson per estrazione
%dei tassi spot dalla curva dei tassi:

%"Il modello matematico sottostante alla curva dei rendimenti della BCE"
% autori:(Gabriella D'Agostino, Antonio Guglielmi)



%"Examing the Nelson-Siegel class of term structure models"
% autore("Michiel De Pooter")
% In questo paper l'autore ha esaminato varie estensioni del modello Nelson
% Siegel, dimostrando che usando modelli più flessibili conduce ad una
% migliore costruzione della term structure,inoltre ha dimostrato che il
% modello a 4 fattori (Nelson-Siegel-Svensson) che aggiunge un secondo
% fattore pendenza al modello NS a 3 fattori produce delle più accurate
% previsoni della curva.

%per la costruzione del programma la fonte utilizzata è il 
%financial Toolbox di Matlab (mathworks USA)


%% Copyright (c) 2017-2018
% Elia Scarparo     - Mat. 190459
% Michele Sordo     - Mat. 190205
% Stefano Zampiero  - Mat. 190203

%% COMANDI FUNZIONE


% Ogni comando e ogni passo del programma devono essere adeguatamente
% commentati (anche la struttura dei cicli o delle istruzioni se presenti)

%% FUNCTION
port = createPortfolio(btp,bonds,dateSettlement,portfolio,forecastDate,valMkt);
curva = createCurve(port,model);
curvaforward = createForwardCurve(port,model);
startDate = datestr(port.date(1));      % doppio controllo
%% come settare start end date?
if exist('outputPlot','var') && outputPlot
    endDate = '17-Nov-2027';
    %plotSpotCurve(port, curva, startDate, endDate, 'r');
    %plotForwardCurve(port, curvaforward, startDate, endDate, 'b');
    plotYieldCurve(port, curva, startDate, endDate, 'g')
end
%calcolo prezzo teorico dei titoli
port = curvePrices(port, curva);
port = compareResult(port);
portf = bond_portfolio(port);


%% DESCRIZIONE DEllE TRE METODOLOGIE DI STIMA DELLA CURVA DEI TASSI


%I tre modelli  estraggono  i tassi spot utilizzando gli strumenti presenti
%sul mercato.

%Il modello bootstrap ricava il tasso che fissa il prezzo di mercato ed il
%resto lo trova per interpolazione; tale modello è una semplice
%approssimazione dei dati di mercato e può risentire di eventuali
%imperfezioni come sovrastima o sottostima dei tassi veri e dipendenza
%stretta dei dati. Infatti questo metodo calcola i tassi spot in punti
%definiti lasciando uno spazion fra i due punti; se vengono chiesti dei
%punti intermedi va a fare un'interpolazione fra i due punti che può essere
%lineare, quadratica.... ma è sempre un'interpolazione e da dei piccoli
%errori.

% Nelson & Siegel (1987) hanno suggerito un diverso approccio:
% creando la curva forward a una certa data con una classe matematica di 
% funzioni approssimate. In matlab utilizzando questo modello il software 
% lavora in questo modo: sulla base dei dati costruisce la curva e poi si
% estrae la curva dei tassi spot; esso calcola in punti definiti i tassi e
% poi va a calcolarsi i 4 parametri della curva Nelson siegel.
% Il paper di "Gabriella D'Agostino, Antonio Guglielmi" afferma che
% il modello Nelson-Siegel-Svensson è utilizzato da molte banche centrali
% per costruire la curva dei rendimenti in quanto
% provvede ad una parsimoniosa approssimazione della curva utilizzando
% pochi parametri che danno una buona interpretazione a breve e a medio
% lungo termine.

% Per incrementare la flessibilità e migliorare l?adattamento Svensson
% estende la funzione di Nelson - Siegel aggiungendo un quarto parametro
% pendenza al modello a 3 fattori e ciò conduce ad una migliore previsione
% della curva.  Ciò è confermato nel paper di "Michiel De Pooter") 
% nel quale l'autore ha esaminato varie estensioni del modello 
% Nelson Siegel, dimostrando che usando modelli più flessibili porta ad 
% una migliore costruzione della term structure,inoltre ha dimostrato che il
% modello a 4 fattori (Nelson-Siegel-Svensson) che aggiunge un secondo
% fattore pendenza al modello NS a 3 fattori produce delle più accurate
% previsoni della curva.


%% IN AGGIUNTA AL CONTENUTO DI OUTPUT MINIMO RICHIESTO

% qui dobbiamo dire che in più abbiamo scelto il metodo svensson per la sua
% maggiore precisione, il plot delle curve con i diversi metodi e qualche
% altra figata esempio table con il confronto 

%Se si desidera aggiungere qualcosa che si ritiene utile per una migliore
%comprensione del programma (esempio:plot o elaborazioni aggiuntive...)


end


