%close all
%clear variables

%this program provides a Monte Carlo estimate for the payoff of a lookback
%call option.

T=1;    %the right endpoint of the time interval
N=1000; %the number of timesteps within the interval
dt=T/N; %the length of each timestep

mu=0.05; sigma=0.1;    %change drift and volatility parameters to model different assets
initial=1;          %the initial value taken by GBM
numpaths = 10000; %the number of paths sampled in the Monte Carlo method
r=0.02; %the risk-free rate

B=zeros(1,N);       %the value GBM takes at each timestep
cumsum=0; %the running total of the means of the sample paths.


for j=1:numpaths
    %generating the values at the first time step
    B(1)=initial*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn);
 
    for i=2:N
        %the recurrence relation
        B(i)=B(i-1)*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn); 
    end
    
    %now adding the payoff of the call option for the path to the total
    %the payoff of the lookback call is max(max(B)-B(N),0)
    cumsum = cumsum + (max([initial,B]) - B(N)); 
end

payoff = cumsum / numpaths;
price = payoff * exp(-r*T);
disp(payoff);