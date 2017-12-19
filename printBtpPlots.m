function [ ] = printBtpPlots( btp )
%PRINTBTPPLOTS Prints btps plots
%   Simple plots

figure
subplot(4,3,1)        
plot(btp.date, btp.btp1)
subplot(4,3,2)        
plot(btp.date, btp.btp2)
subplot(4,3,3)        
plot(btp.date, btp.btp3)
subplot(4,3,4)        
plot(btp.date, btp.btp4)


subplot(4,3,5)        
plot(btp.date, btp.btp5)
subplot(4,3,6)        
plot(btp.date, btp.btp6)
subplot(4,3,7)        
plot(btp.date, btp.btp7)
subplot(4,3,8) 
plot(btp.date, btp.btp8)


subplot(4,3,9)        
plot(btp.date, btp.btp9)
subplot(4,3,10)        
plot(btp.date, btp.btp10)
subplot(4,3,11)        
plot(btp.date, btp.btp11)
subplot(4,3,12)        
plot(btp.date, btp.btp12)

end

