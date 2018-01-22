classdef bond_portfolio
    
    % BOND_PORTFOLIO: classe che rappresenta un portafoglio di bonds
    % contenente i risultati della funzione curvedeitassi.
    % La classe è create per fornire all'utente un tipo di oggetto rigoroso
    % e facilitarlo nell'utilizzo dello stesso.
    
    % Proprietà dell'oggetto
    properties
        Portfolio           % Table contenente il portafoglio calcolato da curvedeitassi 
        Model               % Modello utilizzato per il calcolo dei prezzi
    end
    
    % Le proprietà (Dependent) della classe non vengono definite al momento
    % della creazione dell'oggetto: vengono calcolate on-the-fly ogni volta
    % che vengono chiamate esternamente.
    % Si è optato per definire le seguenti proprietà come dependent per
    % evitare problemi di consistenza dei dati: è così infatti impossibile
    % modificare i valori della tabella "Portfolio" lasciando invariati i
    % valori del portafoglio stesso
    properties (Dependent)
        ValoreTeorico                 % Valore teorico portfolio
        ValoreMercato                 % Valore reale portfolio
        DifferenzaMercatoTeorico      % Differenza tra v.reale e v.teorico
    end
    
    % I metodi della classe definiscono le funzioni interne all'oggetto che
    % vengono richiamate al momento della creazione dell'istanza e alla
    % chiamata delle proprietà dependent
    
    methods
        % Costruttore della classe portfolio: aggiunge all'oggetto la table
        % e il modello specificati in input.
        function obj = bond_portfolio(port, model)
            obj.Portfolio = port;
            obj.Model = model;
        end
        % Calcola il valore di mercato del portafoglio
        function vr = get.ValoreMercato(obj)
            vr = obj.Portfolio.price'*obj.Portfolio.value/100;
        end
         % Calcola il valore teorico del portafoglio
        function vt = get.ValoreTeorico(obj)
            vt = obj.Portfolio.clean'*obj.Portfolio.value/100;
        end
         % Calcola la differenza tra valore di mercato del portafoglio e
         % valore teorico del portafoglio. Al suo interno chiama entrambi i
         % metodi precedenti
        function diff = get.DifferenzaMercatoTeorico(obj)
            diff = obj.ValoreMercato - obj.ValoreTeorico;
        end
    end
    
end

