%% Script Curve dei tassi del progetto di Strumenti di Investimento e Derivati
% Lo script illustra come richiamare la funzione "curvedeitassi(..)",
% presenta come impostare gli input della funzione e fornisce un caso d'uso
% della stessa.

%% 0. Intestazione
% pulisce il workspace dalle variabili precedenti
clear
% pulisce la console - Command Window - di Matlab
clc
% Caricamento dei dati salvati in formato .mat:
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
% - valori caratteristici dei titoli

% Visualizziamo le prime 5 righe del file fornito come input del progetto.
% - btp.mat:
disp('------------------------------------');
disp('    Prime 5 righe file btp.mat');
disp('------------------------------------');
disp(btp(1:5,:));
% il file contiene una tabella con i valori di mercato di 12 Btp italiani.
% Ogni riga riporta i valori di mercato dei btp alla data specificata
% nella prima colonna.

% NB: per il progetto, l'unica riga che si dovrà utilizzare è l'ultima
% visualizziamo quindi la stessa: btp(end,:)
disp('------------------------------------');
disp('       Ultima riga file btp.mat');
disp('------------------------------------');
disp(btp(end,:));

% La settlementDate dei nostri btp sarà quindi univocamente
disp('------------------------------------');
disp('       Settlement Date btp');
disp('------------------------------------');
disp(datestr(btp(end,1).Variables));

% - bonds.mat:
disp('------------------------------------');
disp('          File bonds.mat');
disp('------------------------------------');
disp(bonds);

% bonds.mat è stato generato dal secondo foglio presente in btp.xlsx.
% Ogni riga rappresenta un diverso btp presente in btp.mat (12 totali).
% Le colonne indicano la data di maturity, il coupon e la descrizione
% presente nel file.
% NB: La descrizione è totalmente ininfluente ai fini dei calcoli,
% è stata lasciata per motivi stilistici nella presentazione dei dati.

%% 1.2 Input funzione
% Come conseguenza della sola presenza, nel file fornitoci, di
% "codice titoli" e "valori caratteristici titoli" si prosegue illustrando
% come inserire i diversi input mancanti

% Gli input ulteriori richiesti sono:
% - metodologia di stima
% - portafoglio titoli

% Metodologia di stima.
% Le metodologie richieste sono 'Bootstrap' e 'NelsonSiegel', alle quali si
% aggiunge come ulteriore sviluppo personale la metotodologia 'Svensson'.
% Nella cartella 'paper' è presente il paper: "Il modello matematico
% sottostante alla curva dei rendimenti della BCE", Gabriella D'Agostino, 
% Antonio Guglielmi; esso presenta il metodo Svensson.
% Altre metodologie non possono essere utilizzate dalla funzione sviluppata
% Per semplicità illustrativa, si definiscono 3 diverse variabili
% contenenti le diverse metodologie:
model1 = 'Bootstrap';
model2 = 'NelsonSiegel';
model3 = 'Svensson';


% Portafoglio titoli.
% al fine di creare un portafoglio titoli serve specificare:
% quali titoli si vogliano inserire in portafoglio
portCodes = [{'btp1'},{'btp2'},{'btp3'},{'btp4'}];
% quanti titoli ( in termini di valore nominale) inserire rispettivamente.
portValues = [1000;1000;1000;1000];
% la funzione curvedeitassi(..) prenderà in input la table riassuntiva
portfolio = table(portValues,'VariableNames',{'value'},'RowNames',portCodes);
disp('------------------------------------');
disp('         Portafoglio titoli');
disp('------------------------------------');
disp(portfolio);


%% 1.3 input grafico: come visualizzare la curva.
% plotCurve è una variablie booleana che permette la
% visualizzazione dei grafici della curva dei tassi (spot).
% Come impostare plotCurve:
% - true  -> la curva viene visualizzata
% - false -> la curva NON viene visualizzata
% l'input è opzionale: se non si vuole avere output visivo è sufficiente
% non inserirlo.
% Le diciture:
% a) curvedeitassi(btp,bonds,portfolio,model);
% b) curvedeitassi(btp,bonds,portfolio,model,false);
% sopprimono ugualmente l'output grafico.
% Nel nostro esempio, per chiarezza, inseriamo una variabile di nome 
% plotCurve, dal valore uguale a 'true', che verrà inserita come ultimo
% input alla chiamata della funzione
plotCurve = true;

%% La funzione
% A seguito dell'illustrazione degli input, si può procedere richiamando la
% funzione curvedeitassi(..)

%Bootstrap
portB = curvedeitassi(btp,bonds,portfolio,model1,plotCurve);

%NelsonSiegel
portNs = curvedeitassi(btp,bonds,portfolio,model2,plotCurve);

%Svensson
portS = curvedeitassi(btp,bonds,portfolio,model3,plotCurve);


%% Output
disp('----------------------------------------------------------------');
disp('----------------------------------------------------------------');
disp('----------------------------------------------------------------');
disp('                           OUTPUTs');
disp('----------------------------------------------------------------');
disp('----------------------------------------------------------------');
disp('----------------------------------------------------------------');
disp(' ');
%% Output Bootstrap
disp('-----------------------------------------------------------------');
disp('                       METODO UTILIZZATO');
disp('-----------------------------------------------------------------');
disp(portB.Model);
disp('-----------------------------------------------------------------');
disp('                     Portafoglio finale');
disp('-----------------------------------------------------------------');
disp(portB.Portfolio);
% format modificato per leggibilità risultati
origFormat = get(0, 'format');
format long g
disp('-----------------------------------------------------------------');
disp('              Valore teorico del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(portB.ValoreTeorico,2));
disp('-----------------------------------------------------------------');
disp('            Valore di mercato del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(portB.ValoreMercato,2));
disp('-----------------------------------------------------------------');
disp('Differenza tra valore di mercato e valore teorico del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(portB.DifferenzaMercatoTeorico,2));
%format originale
set(0,'format', origFormat);
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
%% Output Nelson Siegel
disp('-----------------------------------------------------------------');
disp('                       METODO UTILIZZATO');
disp('-----------------------------------------------------------------');
disp(portNs.Model);
disp('-----------------------------------------------------------------');
disp('                     Portafoglio finale');
disp('-----------------------------------------------------------------');
disp(portNs.Portfolio);
% format modificato per leggibilità risultati
origFormat = get(0, 'format');
format long g
disp('-----------------------------------------------------------------');
disp('              Valore teorico del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(portNs.ValoreTeorico,2));
disp('-----------------------------------------------------------------');
disp('            Valore di mercato del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(portNs.ValoreMercato,2));
disp('-----------------------------------------------------------------');
disp('Differenza tra valore di mercato e valore teorico del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(portNs.DifferenzaMercatoTeorico,2));
%format originale
set(0,'format', origFormat);
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
%% Output Svensson
disp('-----------------------------------------------------------------');
disp('                       METODO UTILIZZATO');
disp('-----------------------------------------------------------------');
disp(portS.Model);
disp('-----------------------------------------------------------------');
disp('                     Portafoglio finale');
disp('-----------------------------------------------------------------');
disp(portS.Portfolio);
% format modificato per leggibilità risultati
origFormat = get(0, 'format');
format long g
disp('-----------------------------------------------------------------');
disp('              Valore teorico del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(portS.ValoreTeorico,2));
disp('-----------------------------------------------------------------');
disp('            Valore di mercato del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(portS.ValoreMercato,2));
disp('-----------------------------------------------------------------');
disp('Differenza tra valore di mercato e valore teorico del portafoglio');
disp('-----------------------------------------------------------------');
disp(round(portS.DifferenzaMercatoTeorico,2));
%format originale
set(0,'format', origFormat);
disp(' ');
disp(' ');
disp(' ');
disp(' ');
disp(' ');
%% Confronto risultati - PARTE AGGIUNTIVA
% al fine di concludere questo use case della funzione curvedeitassi è
% utile dare uno sguardo alle differenze tra i risultati ottenuti tramite
% le tre differenti metodologie
disp('-----------------------------------------------------------------');
disp('-----------------------------------------------------------------');
disp('                      CONFRONTO RISULTATI');
disp('-----------------------------------------------------------------');
disp('-----------------------------------------------------------------');
disp('   Differenza tra valore di mercato e valore teorico dei titoli');
disp('              secondo le tre diverse metodologie');
disp(' ');
disp(' ');
% titoli
disp(table(portB.Portfolio.difference,portNs.Portfolio.difference, ...
           portS.Portfolio.difference,'VariableNames', ...
           {'Bootstrap','NelsonSiegel','Svensson'},'RowNames',portCodes));
       
disp('-----------------------------------------------------------------');
disp('-----------------------------------------------------------------');
% portafoglio
disp('Differenza tra valore di mercato e valore teorico del portafoglio');
disp('              secondo le tre diverse metodologie');
disp(' ');
disp(' ');
methods = [{'Bootstrap'},{'NelsonSiegel'},{'Svensson'}];
differenze = [portB.DifferenzaMercatoTeorico;...
              portNs.DifferenzaMercatoTeorico;...
              portS.DifferenzaMercatoTeorico];
disp(table(differenze,'VariableNames',{'Differenze'},'RowNames',methods));
disp('-----------------------------------------------------------------');
disp('-----------------------------------------------------------------');

%% Confronto metodologie - PARTE AGGIUNTIVA
% Come ultimo punto di questo use case si fornisce un grafico contenente un
% confronto tra le curve spot e yield calcolate secondo le tre differenti
% metodologie
compareCurves(btp,bonds);
