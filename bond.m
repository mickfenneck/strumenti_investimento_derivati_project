classdef bond
    %BOND Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        price           % price
        settlement      % settlment date
        maturity        % maturyty date
        coupon          % coupon 
    end
    
    methods
        function obj = bond (price, sett, matu, coup)
            if ~isa(price,'double')
                error('Price needs to be double type');
            end
            if ~isa(coup,'double')
                error('Coupon needs to be double type');
            end
            if obj.settlement > obj.maturity
                error('Maturity date needs to be after settlement date');
            end
            obj.price = price;
            obj.settlement = datenum(sett);
            obj.maturity = datenum(matu);
            obj.coupon = coup; 
        end
        
    end
    
end

