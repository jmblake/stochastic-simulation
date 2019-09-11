close all
clear variables

%this program provides a Monte Carlo estimate for the payoff of an Asian
%call option.

T=1;    %the right endpoint of the time interval
N=252; %the number of timesteps within the interval
dt=T/N; %the length of each timestep

mu=0.05; sigma=0.25;    %change drift and volatility parameters to model different assets
initial=1;              %the initial value taken by GBM
strike=0.5;             %the strike price of the option
r=0.02;                 %the risk-free rate

B=zeros(1,N);     %the value GBM takes at each timestep

M=1000; %the greatest number of paths that we will consider in the Monte Carlo pricing

prices=zeros(1,M);
    
cumsum=0;      %the running total of the means of the sample paths.
    
for j=1:M
    %generating the values at the first time step
    B(1)=initial*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn);
    for i=2:N
        %the recurrence relation
        B(i)=B(i-1)*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn); 
    end
    
    %we now map the entries in B to their risk-neutral prices by
    %discounting at each timestep and putting these into another array
    rnB=zeros(1,N);
    for k=1:N
        rnB(k)=B(k)*exp(-r*k*T/N);
    end
        
    %now adding the payoff for this path to the total
    cumsum = cumsum + max(mean([initial,rnB]) - strike, 0);
    prices(j) = cumsum / j;  
end
   

figure;
x=1:M;
y1=prices;

disp(x);
%disp(y1);

plot(x, y1, 'b-')
set(gca,'FontSize',16)
xlabel('Number of paths','FontSize',20);
ylabel('Price','FontSize',20);
