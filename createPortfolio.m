function [ port ] = createPortfolio(bonds,port)
% createPortfolio compone il 
port = [port bonds(port.Properties.RowNames',:)];

end

