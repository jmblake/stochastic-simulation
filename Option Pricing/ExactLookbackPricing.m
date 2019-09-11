close all
clear variables

%this program provides an exact pricing for a lookback call option.
T=1;
initial=1;              %the price of the asset at t=0
mu=0.05; sigma=0.1;    %change drift and volatility parameters to model different assets
r=0.02;                 %the risk-free rate
t=0;                    %the time that we want to price the option for

tau=T-t;       %the time until expiry of the option
%we now define two functions that help in giving us the exact pricing formula for the option
deltaP = @(Tau,s) (log(s)+(r+0.5*sigma^2)*Tau)/(sigma*sqrt(Tau)); 
deltaM = @(Tau,s) (log(s)+(r-0.5*sigma^2)*Tau)/(sigma*sqrt(Tau)); 

%this can be found on [p319, Shreve]
%t is the time we are pricing at;
%x is the stock price at the given t;
%y is the maximum of the stock price process up to, and including, time t.
%this means that 0<x<=y and x=y at t=0.
term1 = @(t,x,y) (1+sigma^2/(2*r))*x*normcdf(deltaP(tau,x/y));
term2 = @(t,x,y) exp(-r*tau)*y*normcdf(-deltaM(tau,x/y));
term3 = @(t,x,y) (sigma^2/(2*r))*exp(-r*tau)*(y/x)^(2*r/sigma^2)*x*normcdf(-deltaM(tau,y/x));

v = @(t,x,y) term1(t,x,y)+term2(t,x,y)-term3(t,x,y)-x;
price=v(0,initial,initial);

disp(price);