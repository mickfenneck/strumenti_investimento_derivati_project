classdef bond_portfolio
    %BOND_PORTFOLIO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Portfolio           %bond portfolio table
        ValoreTeorico       %Valore teorico portfolio
        ValoreReale         %Valore reale portfolio
    end
    properties (Dependent)
        DifferenzaRealeTeorico      %differenza tra v.reale e v.teorico
    end
    
    methods
        function obj = bond_portfolio(port, vteo, vreal)
            obj.Portfolio = port;
            obj.ValoreTeorico = vteo;
            obj.ValoreReale = vreal;
        end
        
        function diff = get.DifferenzaRealeTeorico(obj)
            diff = obj.ValoreReale - obj.ValoreTeorico;
        end
    end
    
end

