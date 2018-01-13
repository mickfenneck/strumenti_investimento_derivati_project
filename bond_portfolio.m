classdef bond_portfolio
    %BOND_PORTFOLIO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Portfolio           %bond portfolio table
    end
    properties (Dependent)
        ValoreTeorico               %Valore teorico portfolio
        ValoreMercato                 %Valore reale portfolio
        DifferenzaMercatoTeorico      %differenza tra v.reale e v.teorico
    end
    
    methods
        function obj = bond_portfolio(port)
            obj.Portfolio = port;
        end
        
        function diff = get.DifferenzaMercatoTeorico(obj)
            diff = obj.ValoreMercato - obj.ValoreTeorico;
        end
        
        function vr = get.ValoreMercato(obj)
            vr = obj.Portfolio.valMkt'*obj.Portfolio.value/100;
        end
        
        function vt = get.ValoreTeorico(obj)
            vt = obj.Portfolio.clean'*obj.Portfolio.value/100;
        end
    end
    
end

