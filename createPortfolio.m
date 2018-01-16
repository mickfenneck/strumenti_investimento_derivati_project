function [ port ] = createPortfolio(bonds,port)

port = [port bonds(port.Properties.RowNames',:)];

end

