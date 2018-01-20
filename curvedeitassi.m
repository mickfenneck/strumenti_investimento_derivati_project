function [ portf ] = curvedeitassi(btp,bonds,portfolio,model,valMkt,outputPlot)
%% DESCRIZIONE GENERALE DELLE FUNZIONI CREATE:
% CURVEDEITASSI è una funzione che mi permette di:
% 1. Stimare la curva dei tassi con 3 metodologie di stima (Bootstrap, 
% Nelson-Siegel e Svensson). Nel fare questo ci riferiamo alle due
% funzioni: "mergeData" e "createCurve". "mergeData" serve a sistemare i 
% dati di input dei file btp e bonds in un unico file bonds. I dati
% inseriti in questo file vengono usati nella funzione createCurve, assieme
% al metodo di stima della curva selezionato dall'utente per la costruzione
% della curva dei tassi.
% 
% 2. creare un portafoglio di titoli: l'utente innanzitutto procede a sele-
% zionare quali dei titoli usati per costruire la curva saranno parte del 
% portafoglio di cui si calcolerà il prezzo teorico e se ne farà il con-
% fronto con il prezzo reale di mkt. Nei dati di input inseriti dall'utente
% nello script vi sono "portCodes" e "portValues". Questi dati si riferis-
% cono al nome ( nel nostro caso Btp1, Btp2, Btp3, Btp4) dei titoli e al 
% loro valore nominale. La funzione createPortfolio poi crea una tabella 
% sulla base delle due tabelle "portfolio", che si compone di una colonna e 
% tante righe quanti sono i titoli che l'utente ha scelto per comporre il 
% portafolgio, e della tabella creata con mergeData. Si torna a ripetere 
% che i titoli inseriti in questo portafoglio sono per forza parte dei 
% titoli che prima avevamo usato per costruire la curva dei tassi. 
%
% 3. Calcolare il valore teorico di tutti i titoli inseriti in portafoglio.
% Attraverso la funzione "curvePrices" si procede a stimare i prezzi clean 
% e dirty dei titoli inseriti in portafoglio. Attraverso questa funzione si
% procede prima a stimare i casflows e le date di pagamento dei flussi
% cedolari di ciascun titolo inserito in portafoglio. Dopodiché si procede
% ad estrarre i discount factors dalla curva dei tassi stimata in
% corrispondenza di ciascuna data di pagamento cedolare. Infine si procede
% a stimare il prezzo clean e dirty di ciascun titolo inserito in portafo-
% glio. Da notare che in fase di costruzione la funzione viene applicata
% all'oggetto bonds, e per cui sarebbe in grado di calcolare i prezzi
% teorici clean e tel quel di tutti i titoli che abbiamo usato per la
% costruzione della curva. Quando però la funzione viene richiamata, essa
% viene applicata alla tabella portfolio e dunque è per questo set di dati
% a cui si fa riferimento nella spiegazione della curva.
%
% 4. Confrontare il prezzo teorico clean dei singoli titoli scelti per 
% comporre il portafoglio ed il loro valore reale. Con la funzione 
% "compareResult" si procede a calcolare la differenza tra il valore di 
% mercato per ciascun titolo voluto dall'utente ( questo è un dato di input
% che l'utente deve inserire) ed il prezzo teorico clean stimato con la
% curva dei tassi. L'outputdi questa funzione è inserito nella tabella
% "portfolio" in ultima colonna. Da notare che in fase di costruzione la 
% funzione viene applicata all'oggetto bonds, e per cui sarebbe in grado di
% operare il confronto tra il prezzo teorico clean e tel quel di tutti i 
% titoli che abbiamo usato per la costruzione della curva. Quando però la 
% funzione viene richiamata, essa viene applicata alla tabella "portfolio" 
% e dunque è a questo set di dati a cui si fa riferimento nella spiegazione
% della curva.
%
% 5. creazione della classe "port" per mezzo del file "bond_portfolio". 
% Questa classe prende la tabella "portfolio" indicante i titoli voluti 
% dall'utente per la composizione di portafoglio ed oltre a rappresentarla 
% al suo interno è in grado di comporre il portafolgio desiderato 
% dall'utente, calcolarne il valore di mercato reale ed il prezzo teorico. 
% Infine calcola differenza tra i due prezzi.
%
% Lo script è inoltre arricchito con:
% 1. la visualizzazione della tabella "portfolio" all'interno della classe 
% "port", assieme al valore di mercato e al prezzo teorico clean contenuti 
% nella classe "port".
% 2. la visualizzazione di un plot della curva dei tassi spot.

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
% "script.m" ( script iniziale di richiamo alla funzione curvedeitassi):
% clear
% clc
% load
% disp
% table
% set
% get
% round
% format
% 
% "curvedeitassi.m" function ( funzione generale di richiamo delle altre funzioni):
% 
% 1. "mergeData.m" function:
% length
% datestr
% repelem
% 
% 2. "createCurve" function:
% strcmp
% datenum
% IRDataCurve.bootstrap
% IRFunctionCurve.fitNelsonSiegel
% IRFunctionCurve.fitSvensson
% error
% 
% 3. "createPortfolio" function:
% repelem
% datenum
% length
% find
% 
% 4. "curvePrices.m" function:
% repelem
% length
% cfamounts
% datestr
% getDiscountFactors
%
% 5. "compareResult.m" function:
% repelem
% length
% 
% 6. "bond_portfolio.m"
% 
% 7. "plotSpotCurve.m" function
% figure
% datenum
% bndyield
% plot
% title
% xlabel
% ylabel
% hold
% scatter
% datetick
% 
% 8. "plotYieldCurve.m" function
% figure
% datenum
% bndyield
% plot
% title
% xlabel
% ylabel
% hold
% scatter
% datetick

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
bonds = mergeData(btp,bonds);
curva = createCurve(bonds,model);
curvaforward = createForwardCurve(bonds,model);
%startDate = datestr(port.date(1));      % doppio controllo
% %% come settare start end date?
% if exist('outputPlot','var') && outputPlot
%     endDate = '17-Nov-2027';
%     %plotSpotCurve(port, curva, startDate, endDate, 'r');
%     %plotForwardCurve(port, curvaforward, startDate, endDate, 'b');
%     plotYieldCurve(port, curva, startDate, endDate, 'g')
% end

%% cose nuove
portfolio = createPortfolio(bonds,portfolio);


%calcolo prezzo teorico dei titoli
portfolio = curvePrices(portfolio, curva);
portfolio = compareResult(portfolio);
portf = bond_portfolio(portfolio);


%% DESCRIZIONE DELLE TRE METODOLOGIE DI STIMA DELLA CURVA DEI TASSI


%I tre modelli  estraggono  i tassi spot utilizzando gli strumenti presenti
%sul mercato.

%Il modello bootstrap ricava i tassi spot usando strumenti presenti sul mkt.
%Essendo gli strumenti presenti sul mkt in numero limitato, tassi
%corrispondenti ad intervalli di tempo per i quali non esistono
%strumenti sul mercato vengono individuati per interpolazione. A causa di
%questa interpolazione i tassi individuati con la curva costruita con il
%metodo Bootstrap, che sono un'approssimazione dei dati di mercato, possono
%essere oggetto di imperfezioni come sovrastima o sottostima dei tassi veri.
%Si nota inoltre una dipendenza stretta dei dati. 
%Dunque, questo metodo calcola i tassi spot per intervalli definiti di
%tempo - quelli per cui sono disponibili strumenti di mkt- lasciando spazi
%vuoti fra i due intervalli i quali vengono colmati per interpolazione. Se 
%vengono chiesti tassi corrispondenti ad intervalli intermedi, Bootstrap va
%a fare un'interpolazione fra i due punti che può essere lineare,
%quadratica.... la quale è e rimane un'interpolazione che può dare origine 
%a piccoli errori di stima.

%Nelson & Siegel (1987) hanno suggerito un diverso approccio:
%Si parte da un'equazione differenziale per la derivazione dei tassi
%Forward. Con una serie di passaggi matematici si arriva poi alla curva dei
%tassi forward. In matlab utilizzando questo modello il software 
%lavora in questo modo: sulla base dei dati costruisce la curva e poi si
%estrae la curva dei tassi spot; esso calcola in punti definiti i tassi e
%poi va a calcolarsi i 4 parametri della curva Nelson siegel.
%Il paper di "Gabriella D'Agostino, Antonio Guglielmi" afferma che
%il modello Nelson-Siegel-Svensson è utilizzato da molte banche centrali
%per costruire la curva dei rendimenti in quanto provvede ad una 
%parsimoniosa approssimazione della curva utilizzando pochi parametri che 
%danno una buona interpretazione a breve e a medio-lungo termine.

%IN AGGIUNTA AL CONTENUTO DI OUTPUT MINIMO RICHIESTO abbiamo voluto 
%costruire la curva dei tassi secondo il metodo Svensson. Per incrementare 
%la flessibilità e migliorare l'adattamento della curva dei tassi Svensson 
%estende la funzione di Nelson - Siegel aggiungendo un quarto parametro 
%pendenza al modello a 3 fattori e ciò conduce ad una migliore capacità 
%previsiva della curva. Questo è confermato nel paper di "Michiel De Pooter" 
%nel quale l'autore ha esaminato varie estensioni del modello
%Nelson Siegel, osservando che usando modelli più flessibili si arriva ad 
%una migliore costruzione della term structure, inoltre ha dimostrato che 
%il modello a 4 fattori (Nelson-Siegel-Svensson), che aggiunge un secondo
%fattore pendenza al modello NS a 3 fattori, produce delle più accurate
%previsoni della curva.

end


