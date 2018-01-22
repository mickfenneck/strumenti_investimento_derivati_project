function [ portf ] = curvedeitassi(btp,bonds,portfolio,model,outputPlot)

% CURVEDEITASSI stima la curva dei tassi e fornisce un confronto tra valori
% teorici (clean) e di mercato del portafoglio e dei titoli richiesti.

% [ portf ] = curvedeitassi(btp,bonds,portfolio,model,outputPlot)

% NB: essendo outputPlot opzionale, si può sottintendere la soppressione 
% degli output grafici chiamandola come:

% [ portf ] = curvedeitassi(btp,bonds,portfolio,model)


% CURVEDEITASSI stima la curva dei tassi spot (e yield), a partire da due
% file forniti in input, con la finalità di prezzare teoricamente i btp
% specificati nel portafoglio e fornire un confronto tra prezzi teorici
% (clean) e di mercato dei titoli e i relativi prezzi teorici (clean) e di
% mercato dell'intero portafoglio. La funzione produce, in maniera opzionale,
% un output grafico contenente la curva dei tassi spot, la curva dei tassi
% yield ed un confronto tra esse.


% La funzione inizialmente unisce i valori dei due file, creando una table
% con gli input necessari al calcolo della curva dei tassi. Prosegue 
% creando la curva, in base al metodo dato in input. Unicamente se 
% specificato dall'utente produce l'output grafico creando i grafici 
% relativi alla curva spot, curva yield ed il confronto tra le due 
% differenti curve.
% Una volta calcolata la curva a partire da tutti i btp, si prosegue 
% arricchendo l'input portfolio con i dati contenuti nei due file e si 
% calcolano quindi i prezzi clean e dirty, grazie alla curva appena creata.
% Trovati i prezzi teorici (clean) si aggiunge ai titoli contenuti in 
% portfolio la differenza tra il valore di mercato ed il prezzo clean.
% Come ultimo passaggio si istanzia un oggetto bond_portfolio per fornire 
% all'utente un output comodo e consistente.


% DESCRIZIONE INPUT:

% btp = table contenente i valori di mercato registrati per dei bonds, ogni
%       riga corrisponde ad una data differente. Ai fini dell'esercizio si
%       utilizza, restando ligi alla consegna assegnata, unicamente 
%       l'ultima riga, che registra i valori di mercato all'ultima data 
%       disponibile.

%bonds = table che contiene maturity, coupon e description dei bonds 
%        presenti all'interno della table btp.

%portfolio = table contenente i dati di portafoglio. Ogni riga corrisponde
%            ad un differente bond, obbligatoriamente presente all'interno 
%            delle table btp e bonds. La prima colonna contiene i valori 
%            nominali di ogni bond.

%model = stringa contenente il modello da utilizzare per la stima della
%        curva dei tassi. Deve essere obbligatoriamente Bootstrap, 
%        NelsonSiegel o Svensson. Altri valori generano errore 
%        opportunamente generato.

%outputPlot = variabile booleana che indica la volontà di generare i
%             grafici tramite la funzione. L'input è OPZIONALE, se non 
%             inserito è sottinteso che i grafici non debbano essere 
%             generati.

% NB: un'ulteriore e più approfondita analisi degli input è presente nel
% file script.m, che illustra come chiamare la funzione e visualizzare gli
% output dopo aver mostrato i file di input.

% DESCRIZIONE OUTPUT:
% portf = oggetto istanza della classe bond_portfolio, contenente la table
%         del portafoglio completo. L'oggetto calcola dinamicamente il
%         valore di mercato, teorico e la differenza tra i due valori per
%         il portafoglio al suo interno.
% La struttura dell'oggetto è adeguatamente commentata all'interno della
% classe bond_portfolio.
% L'utilizzo di un oggetto permette di evitare errori di inconsistenza tra
% i dati: è infatti impossibile modificare i valori nominali dei titoli
% mantenendo invariato il calcolo dei valori teorici e di mercato del 
% portfoglio.


% All'interno del programma sono state richiamate le seguenti funzioni
% matlab già esistenti.

%% questa sezione è da modificare @EliaScarparo
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

% BIBLIOGRAFIA

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

% FUNCTION
% Tramite la funzione mergeData si uniscono i valori presenti nell'ultima
% riga del file btp (ultimi valori osservati) ai valori generali di bonds,
% al fine di avere un'unica table contenente tutti i dati necessari al
% calcolo delle curve dei tassi. 
bonds = mergeData(btp,bonds);

% Tramite la funzione createCurve si crea una curva secondo il metodo
% Bootstrap, NelsonSiegel o Svensson, in base all'input specificato
% dall'utente.
curva = createCurve(bonds,model);

% Se specificato dall'utente tramite la variabile outputPlot==true,
% si procede a creare i grafici relativi alla curva spot, yield ed il
% confronto tra le due differenti curve.
% La condizione if controlla l'esistenza della variabile outputPlot, se la
% variabile esiste allora controlla che sia uguale a true.
if exist('outputPlot','var') && outputPlot
    plotCurve(bonds, curva, model);
end

% Tramite la funzione createPortfolio si prosegue selezionando il
% sottinsieme di titoli per il quale si vuole calcolare il prezzo teorico.
% I pesi del portafoglio sono già assegnati in input, si aggiungono quindi
% al portafoglio i valori contenuti in bonds.
portfolio = createPortfolio(bonds,portfolio);

% Tramite la funzione curvePrices si procede prima a stimare i cashflows 
% e le date di pagamento dei flussi cedolari di ciascun titolo inserito in
% portafoglio; si procede quindi ad estrarre i discount factors dalla curva
% dei tassi stimata in corrispondenza di ciascuna data di pagamento cedolare.
% Si stimano infine i prezzi clean e dirty di ciascun titolo inserito in
% portafoglio e li si aggiunge alla table precedente.
portfolio = curvePrices(portfolio, curva);

% Tramite la funzione compareResult si aggiunge alla table una colonna
% che indica la differenza tra prezzo di mercato e prezzo teorico (clean)
portfolio = compareResult(portfolio);

% Al fine di consegnare all'utente un output consistente, che calcoli
% dinamicamente il valore di mercato e di portafoglio anche a seguito di
% variazione della table, si inseriscono i dati all'interno di un oggetto
% bond_portfolio. L'oggetto è istanziato a partire dalla classe 
% bond_portfolio, creata per soddisfare la consegna richiesta. La struttura
% della classe è illustrata nella sezione commenti output.
portf = bond_portfolio(portfolio,model);



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

%% PARTE AGGIUNTIVA
% Lo script è inoltre arricchito con:
% 1. classe bond_portfolio
% 2. metodologia Svensson per il calcolo della curva dei tassi
% 3. funzione plotCurve per visualizzare curva dei tassi spot, curva dei 
%    tassi yield e confronto tra le due curve
% 4. funzione compareCurves per calcolare e confrontare le tre differenti
%    curve dei tassi spot e le tre differenti curve dei tassi yield per le
%    tre diverse metodologie
% 5. use case della funzione curvedeitassi per approfondire la modellazione
%    dei dati ed illustrare al meglio input, chiamata della funzione 
%    curvedeitassi(..), output e parte aggiuntiva (compreso confronto tra i
%    risultati ottenuti).

end


