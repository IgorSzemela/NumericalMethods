clear all
close all
clc 

load('wig20.mat')
wig_data = WIG20'; 

MACD = zeros(1,1000);
SIGNAL = zeros(1,1000);

for i = 27:1000
MACD(i) = EMA(wig_data, 12, i)-EMA(wig_data, 26, i);  
end 

for i = 27:1000
SIGNAL(i) = EMA(MACD, 9, i);        
end

hold on
plot(WIG20,'b')
plot(MACD,'r')
plot(SIGNAL,'g')
hold off
legend("WIG index","MACD", "SIGNAL")

