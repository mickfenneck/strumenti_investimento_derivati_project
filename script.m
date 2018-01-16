%% Script Curve dei tassimdel progetto di Strumenti di Investimento e Derivati
% Lo script illustra come richiamare la funzione "curvedeitassi(..)"
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

%% 1.0 Input
% la funzione richiede i seguenti input:
% - codice titoli
% - valori caratteristici titoli
% - metodologia di stima
% - portafoglio titoli
disp('----------------------------------------------------------------');
disp('----------------------------------------------------------------');
disp('                            INPUTs');
disp('----------------------------------------------------------------');
disp('----------------------------------------------------------------');



%% 1.1 FILE input
% I file contengono i seguenti input:
% - codice titoli
% - valori caratteristici titoli

% Visualizziamo le prime 5 righe dei file forniti come input del progetto:
% - btp.mat:
disp('------------------------------------');
disp('     Prime 5 righe file btp.mat');
disp('------------------------------------');
disp(btp(1:5,:));
% il file contiene una tabella con valori di mercato di 12 Btp italiani.
% ogni riga riporta i valori di mercato dei btp nella data specificata
% nella prima colonna.

% - bonds.mat:
disp('------------------------------------');
disp('          File bonds.mat');
disp('------------------------------------');
disp(bonds);
% il file è stato generato dal secondo foglio presente in btp.xlsx.
% Ogni riga rappresenta un diverso btp presente in btp.mat (12 totali)
% le colonne indicano la data di maturity, il coupon e la descrizione
% presente nel file.
% NB: La descrizione è totalmente ininfluente ai fini dei calcoli,
% è stata lasciata per motivi stilistici nella presentazione dei dati.

%% 1.2 Input funzione
% Come conseguenza della sola presenza, nel file fornitici, di
% "codice titoli" e "valori caratteristici titoli" si prosegue illustrando
% come inserire i diversi input mancanti

% Gli input richiesti che vanno inseriti sono:
% - metodologia di stima
% - portafoglio titoli

% Metodologia di stima.
% le metodologie richieste sono 'Bootstrap' e 'NelsonSiegel', alle quali si
% aggiunge come ulteriore sviluppo personale la metotodologia 'Svensson'.
% Altre metodologie non possono essere utilizzate dalla funzione sviluppata
% Per semplicità illustrativa, si definiscono 3 diverse variabili
% contenenti le diverse metodologie:
model1 = 'Bootstrap';
model2 = 'NelsonSiegel';
model3 = 'Svensson';

% Portafoglio titoli.
% al fine di creare un portafoglio titoli serve specificare:
% quali titoli si vogliano inserire in portafoglio
portCodes = [{'btp1'},{'btp2'},{'btp3'},{'btp4'},{'btp5'},{'btp6'},{'btp7'},{'btp8'},{'btp9'},{'btp10'},{'btp11'},{'btp12'}];
% quanti titoli inserire rispettivamente.
portValues = [1000;1000;1000;1000;1000;1000;1000;1000;1000;1000;1000;1000];
% la funzione curvedeitassi(..) prenderà in input la table riassuntiva
portfolio = table(portValues,'VariableNames',{'Value'},'RowNames',portCodes);
disp('------------------------------------');
disp('         Portafoglio titoli');
disp('------------------------------------');
disp(portfolio);

%% Ulteriori input
% Al fine di sviluppare una funzione che produca gli output richiesti nella
% consegna, sono necessari ulteriori input:
% - dateSettlement
% - forecastDate
% - valMkt

% dateSettlement deve essere una delle date contenute nella prima colonna
% del file btp.mat, è necessaria al fine di costruire la curva dei tassi
% dateSettlement sarà, necessariamente, la medesima per tutti i bond
dateSettlement = '21-Nov-2017';
% forecastDate sarà input necessario per calcolare cfamounts(..) tramite la
% curva dei tassi che si andrà a costruire.
% Per definizione deve essere successiva a dateSettlement
forecastDate = datestr(btp.date(end));
%forecastDate = datestr(btp(end,1));
% valMkt indica il valore di mercato dei bond inseriti nel portafoglio.
% Questo array è necessario per calcolare le differenze tra prezzi teorici
% e prezzi di mercato reali.
valMkt = 108.101;111.308;117.022;123.397;122.089;116.941;101.125;123.519;143.469;144.117;122.147;106.452;
%% Come visualizzare la curva
% plotCurve è una variablie booleana che permette di sopprimere la
% visualizzazione dei grafici della curva dei tassi (spot e forward).
% Come impostare plotCurve:
% - true  -> la curva viene visualizzata
% - false -> la curva NON viene visualizzata
% l'input è opzionale, se non si vuole avere output visivo è sufficiente
% non inserirlo.
% Le diciture:
% a) curvedeitassi(btp,bonds,dateSettlement,portfolio,model,forecastDate,valMkt);
% b) curvedeitassi(btp,bonds,dateSettlement,portfolio,model2,forecastDate,valMkt,false);
% sopprimono ugualmente l'output grafico
% nel nostro esempio, per chiarezza, inseriamo una variabile di nome 
% plotCurve, dal valore uguale a 'true', che verrà inserita come ultimo
% input alla chiamata della funzione
plotCurve = false;

%% La funzione
% A seguito dell'illustrazione degli input, si può procedere richiamando la
% funzione curvedeitassi(..)

port = curvedeitassi(btp,bonds,dateSettlement,portfolio,model1,forecastDate,valMkt,plotCurve);
%port = curvedeitassi(btp,bonds,dateSettlement,portfolio,model2,forecastDate,valMkt,plotCurve);
%port= curvedeitassi(btp,bonds,dateSettlement,portfolio,model3,forecastDate,valMkt,plotCurve);


%% Output
disp('----------------------------------------------------------------');
disp('----------------------------------------------------------------');
disp('                           OUTPUTs');
disp('----------------------------------------------------------------');
disp('----------------------------------------------------------------');
disp(' ');
disp('-----------------------------------------------------------------');
disp('                     Portafoglio finale');
disp('-----------------------------------------------------------------');
disp(port.Portfolio);
% format modificato per leggibilità risultati
origFormat = get(0, 'format');
format long g
disp('-----------------------------------------------------------------');
disp('              Valore teorico del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(port.ValoreTeorico,2));
disp('-----------------------------------------------------------------');
disp('            Valore di mercato del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(port.ValoreMercato,2));
disp('-----------------------------------------------------------------');
disp('Differenza tra valore di mercato e valore teorico del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(port.DifferenzaMercatoTeorico,2));
%format originale
set(0,'format', origFormat);
