%% Script del progetto di Strumenti di Investimento e Derivati
clear
clc

load btp.mat

% creo due bond
a = bond(12,'12-Aug-2018','12-Aug-2018',0.13);
b = bond(13,'12-Aug-2018','12-Aug-2018',0.13);

bonds = [a b];

for i=1:length(bonds)
    disp(bonds(i).price);
end

figure
subplot(5,2,1)        
plot(btp.date, btp.btp1)
subplot(5,2,2)        
plot(btp.date, btp.btp2)
subplot(5,2,3)        
plot(btp.date, btp.btp3)
subplot(5,2,4)        
plot(btp.date, btp.btp4)
subplot(5,2,5)        
plot(btp.date, btp.btp5)

subplot(5,2,6)        
plot(btp.date, btp.btp6)
subplot(5,2,7)        
plot(btp.date, btp.btp7)
subplot(5,2,8)        
plot(btp.date, btp.btp8)
subplot(5,2,9)        
plot(btp.date, btp.btp9)
subplot(5,2,10)        
plot(btp.date, btp.btp10)

