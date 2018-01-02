function [ comparison ] = compareResult_function(portCodes,valoreMkt,data,clean,dirty,coupon)
%COMPARERESULT Confronta il valore di mercato del titolo alla data di 
% osservazione con quello stimato con la curva. Il valore di mkt reale va
% specificato dall'utente prima di usare la funzione.
% La funzione si propone di creare una tabella riportante i prezzi teorici
% clean e dirty e il prezzo reale osservato.
comparison=table(clean,dirty,valoreMkt,'VariableNames',{'clean',...
    'dirty','valore_reale'},'RowNames',portCodes)
disp(comparison)

end

