close all
clear variables

%this program prices a two-asset down-and-in barrier put option
%i.e. a put on S_1 that knocks in when S_2 drops below a barrier at b.

%n.b. multiGBMfn takes parameters (d,initial,mu,sigma,Corr,T,N)

r=0.05;                           %the risk-free rate
b=1;                              %the barrier
strike=2;                         %the strike price of the option
trials=10^3;                      %the number of Monte Carlo trials

d=2;                            %the number of assets
initial=[1,1];                  %the prices of the assets at t=0
mu=0.2*ones(1,d);               %the drift vector of the assets
sigma=0.1*ones(1,d);            %the variance of each of the assets
Corr=0.8*ones(d)+0.2*eye(d);    %the assets' correlation matrix
T=1;                            %length of time interval
N=252;                          %number of timesteps

cumsum=0;

for m=1:trials
    paths = multiGBMfn(d,initial,mu,sigma,Corr,T,N);
    if min(paths(2,:))<b
        payoff=max(strike-paths(1,N),0);
        cumsum=cumsum+payoff;
    end
end
%discounting the average terminal payoffs
price=exp(-r*T)*cumsum/trials;
disp(price);