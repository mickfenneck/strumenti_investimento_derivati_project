classdef bond_portfolio
    %BOND_PORTFOLIO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Bonds   %bond portfolio
    end
    
    methods
        function BP = bond_portfolio()
            BP.Bonds = [];
        end

        function obj = set.Bonds (obj, nbond)
            obj.Bonds = nbond;
            %BP.bonds = [BP.bonds nbond];
%             if ~isa(nbond,'bond')
%                 error('The element is not a bond');
%             end
%             obj.bonds = [obj.bonds bond];
        end
    end
    
end

