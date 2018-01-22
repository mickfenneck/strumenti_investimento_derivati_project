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

% Visualizziamo le prime 5 righe del file fornito come input del progetto.
% - btp.mat:
disp('------------------------------------');
disp('    Prime 5 righe file btp.mat');
disp('------------------------------------');
disp(btp(1:5,:));
% il file contiene una tabella con valori di mercato di 12 Btp italiani.
% ogni riga riporta i valori di mercato dei btp nella data specificata
% nella prima colonna.

% NB: per il progetto, l'unica riga che si dovr� utilizzare � l'ultima
% visualizziamo quindi la stessa: btp(end,:)
disp('------------------------------------');
disp('       Ultima riga file btp.mat');
disp('------------------------------------');
disp(btp(end,:));

% La settlementDate dei nostri btp sar� quindi univocamente
disp('------------------------------------');
disp('       Settlement Date btp');
disp('------------------------------------');
disp(datestr(btp(end,1).Variables));

% - bonds.mat:
disp('------------------------------------');
disp('          File bonds.mat');
disp('------------------------------------');
disp(bonds);

% bonds.mat � stato generato dal secondo foglio presente in btp.xlsx.
% Ogni riga rappresenta un diverso btp presente in btp.mat (12 totali).
% Le colonne indicano la data di maturity, il coupon e la descrizione
% presente nel file.
% NB: La descrizione � totalmente ininfluente ai fini dei calcoli,
% � stata lasciata per motivi stilistici nella presentazione dei dati.

%% 1.2 Input funzione
% Come conseguenza della sola presenza, nel file fornitici, di
% "codice titoli" e "valori caratteristici titoli" si prosegue illustrando
% come inserire i diversi input mancanti

% Gli input ulteriori richiesti sono:
% - metodologia di stima
% - portafoglio titoli

% Metodologia di stima.
% le metodologie richieste sono 'Bootstrap' e 'NelsonSiegel', alle quali si
% aggiunge come ulteriore sviluppo personale la metotodologia 'Svensson'.
% Nella cartella 'paper' � presente il paper: "Il modello matematico
% sottostante alla curva dei rendimenti della BCE", Gabriella D?Agostino, 
% Antonio Guglielmi; esso presenta il metodo Svensson.
% Altre metodologie non possono essere utilizzate dalla funzione sviluppata
% Per semplicit� illustrativa, si definiscono 3 diverse variabili
% contenenti le diverse metodologie:
model1 = 'Bootstrap';
model2 = 'NelsonSiegel';
model3 = 'Svensson';


% Portafoglio titoli.
% al fine di creare un portafoglio titoli serve specificare:
% quali titoli si vogliano inserire in portafoglio
portCodes = [{'btp1'},{'btp2'},{'btp3'},{'btp4'}];
% quanti titoli inserire rispettivamente.
portValues = [1000;1000;1000;1000];
% la funzione curvedeitassi(..) prender� in input la table riassuntiva
portfolio = table(portValues,'VariableNames',{'value'},'RowNames',portCodes);
disp('------------------------------------');
disp('         Portafoglio titoli');
disp('------------------------------------');
disp(portfolio);


%% 1.3 input grafico: come visualizzare la curva.
% plotCurve � una variablie booleana che permette la
% visualizzazione dei grafici della curva dei tassi (spot).
% Come impostare plotCurve:
% - true  -> la curva viene visualizzata
% - false -> la curva NON viene visualizzata
% l'input � opzionale: se non si vuole avere output visivo � sufficiente
% non inserirlo.
% Le diciture:
% a) curvedeitassi(btp,bonds,portfolio,model);
% b) curvedeitassi(btp,bonds,portfolio,model,false);
% sopprimono ugualmente l'output grafico.
% Nel nostro esempio, per chiarezza, inseriamo una variabile di nome 
% plotCurve, dal valore uguale a 'true', che verr� inserita come ultimo
% input alla chiamata della funzione
plotCurve = true;

%% La funzione
% A seguito dell'illustrazione degli input, si pu� procedere chiamando la
% funzione curvedeitassi(..)

%Bootstrap
%port = curvedeitassi(btp,bonds,portfolio,model1,plotCurve);

%NelsonSiegel
port = curvedeitassi(btp,bonds,portfolio,model3,plotCurve);

%Svensson
%port = curvedeitassi(btp,bonds,portfolio,model3,plotCurve);


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
% format modificato per leggibilit� risultati
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
