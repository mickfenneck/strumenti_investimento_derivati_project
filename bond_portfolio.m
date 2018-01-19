classdef bond_portfolio
    
    % BOND_PORTFOLIO: bond_portfolio è una classe utilizzata per identifi-
    % care un tipo di dato astratto: in questo caso il portafoglio composto
    % da bond. 
    
    properties
        Portfolio           %bond portfolio table
    end
    
    % Come istanze e attributi della classe abbiamo utilizzato gli oggetti:
    % bond_portfolio:Valore teorico portfolio
    % ValoreMercato:Valore reale portfolio
    % DifferenzaMercatoTeorico: differenza tra v.reale e v.teorico
    
    properties (Dependent)
        ValoreTeorico               %Valore teorico portfolio
        ValoreMercato                 %Valore reale portfolio
        DifferenzaMercatoTeorico      %differenza tra v.reale e v.teorico
    end
    
    % I seguenti metodi sono condivisi da tutti gli oggetti creati e hanno
    % lo scopo di calcolare il valore reale e teorico del portafoglio
    % oltre alla differenza tra v.reale e v.teorico ed succesivamente
    % assegnarlo agli oggetti che compongono le istanze della classe.
    
    methods
        function obj = bond_portfolio(port)
            obj.Portfolio = port;
        end
        
        function diff = get.DifferenzaMercatoTeorico(obj)
            diff = obj.ValoreMercato - obj.ValoreTeorico;
        end
        
        function vr = get.ValoreMercato(obj)
            vr = obj.Portfolio.price'*obj.Portfolio.value/100;
        end
        
        function vt = get.ValoreTeorico(obj)
            vt = obj.Portfolio.clean'*obj.Portfolio.value/100;
        end
    end
    
end

