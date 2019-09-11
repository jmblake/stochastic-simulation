close all
clear variables

%this program prices a call option on the spread between two assets
%n.b. multiGBMfn takes parameters (d,initial,mu,sigma,Corr,T,N)

%note that spread options are priced only on the value of the assets at
%t=T, so we need only consider the one-step paths.

r=0.05;                         %the risk-free rate
strike=0.1;                     %the strike price of the option
trials=10^6;                    %the number of Monte Carlo trials

d=2;                            %the number of assets
initial=[1,1];                  %the prices of the assets at t=0
mu=0.2*ones(1,d);               %the drift vector of the assets
sigma=0.1*ones(1,d);            %the variance of each of the assets
Corr=0.8*ones(d)+0.2*eye(d);    %the assets' correlation matrix
T=1;                            %length of time interval
N=1;                            %number of timesteps

cumsum=0;

for m=1:trials
    paths = multiGBMfn(d,initial,mu,sigma,Corr,T,N);

    %the spread option is an option on the value of the asset at expiry of 
    %the option, so we only need those as opposed to the entire path:
    finalpoints=paths(:,N);
    payoff=max((finalpoints(1,1)-finalpoints(2,1))-strike,0);
    cumsum=cumsum+payoff;
end
%discounting the average terminal payoffs
price=exp(-r*T)*cumsum/trials;
disp(price);