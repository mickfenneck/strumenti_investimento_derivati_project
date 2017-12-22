classdef bond_portfolio
    %BOND_PORTFOLIO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Bonds   %bond portfolio
    end
    
    methods
        function obj = bond_portfolio(varargin)
%             for i=1:length(varargin)
%                 if ~isa(varargin(i),'bond')
%                     error('Only bonds ammitted as portfolio inputs');
%                 end
%             end
            obj.Bonds = varargin;
        end

        function obj = set.Bonds (obj, varargin)
            obj.Bonds = nbond;
            
            %BP.bonds = [BP.bonds nbond];
%             if ~isa(nbond,'bond')
%                 error('The element is not a bond');
%             end
%             obj.bonds = [obj.bonds bond];
        end
    end
    
end

