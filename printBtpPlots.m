function [ ] = printBtpPlots( btp , titoli)
%PRINTBTPPLOTS Prints btps plots
%   Simple plots

ntitoli = length(titoli);

figure
if mod(ntitoli,4) == 0
    nrow = ntitoli/4;
    ncol = 4;
elseif mod(ntitoli,3) == 0
    nrow = ntitoli/3;
    ncol = 3;
elseif mod(ntitoli,2) == 0
    nrow = ntitoli/2;
    ncol = 2;
else
    nrow = ntitoli;
    ncol = 1;
end

for i = 1:ntitoli
    subplot(nrow,ncol,i)        
    plot(btp.date, btp{1:end,titoli(i)})
    title(titoli(i));
end


% figure
% subplot(4,3,1)        
% plot(btp.date, btp.btp1)
% subplot(4,3,2)        
% plot(btp.date, btp.btp2)
% subplot(4,3,3)        
% plot(btp.date, btp.btp3)
% subplot(4,3,4)        
% plot(btp.date, btp.btp4)
% 
% 
% subplot(4,3,5)        
% plot(btp.date, btp.btp5)
% subplot(4,3,6)        
% plot(btp.date, btp.btp6)
% subplot(4,3,7)        
% plot(btp.date, btp.btp7)
% subplot(4,3,8) 
% plot(btp.date, btp.btp8)
% 
% 
% subplot(4,3,9)        
% plot(btp.date, btp.btp9)
% subplot(4,3,10)        
% plot(btp.date, btp.btp10)
% subplot(4,3,11)        
% plot(btp.date, btp.btp11)
% subplot(4,3,12)        
% plot(btp.date, btp.btp12)

end

