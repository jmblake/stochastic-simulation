close all
clear variables

T=1;    %the right endpoint of the time interval
N=252; %the number of timesteps within the interval
dt=T/N; %the length of each timestep

mu=0.05; sigma=0.1;     %change drift and volatility parameters to model different assets
initial=1;              %the initial value taken by GBM
r=0.02;                 %the risk-free rate

B1=zeros(1,N);     %the value GBM takes at each timestep
B2=zeros(1,N);
B=zeros(1,N);

M=500; %max number of trials. Must be even

antiprices=zeros(1,M/2);
crudeprices=zeros(1,M);
    
anticumsum=0;      %the running total of the means of the sample paths.
crudecumsum=0;

%the antithetic lookback option pricing
for j=1:M/2
    Z=randn(1,N);
    %generating the values at the first time step
    B1(1)=initial*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*Z(1));
    B2(1)=initial*exp((mu-0.5*sigma^2)*dt-sigma*sqrt(dt)*Z(1));
    for i=2:N
        %the recurrence relation
        B1(i)=B1(i-1)*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*Z(i));
        B2(i)=B2(i-1)*exp((mu-0.5*sigma^2)*dt-sigma*sqrt(dt)*Z(i));
    end
    payoff1=max([initial,B1]-B1(N));
    payoff2=max([initial,B2]-B2(N));
    avpayoff=(payoff1+payoff2)/2;
    %now adding the payoff for this path to the total
    anticumsum = anticumsum + avpayoff;
    antiprices(j) = anticumsum / j;  
end
antiprices=antiprices*exp(-r*T);

%crude lookback option pricing
for p=1:M
    B(1)=initial*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn);
    for q=2:N
        %the recurrence relation
        B(q)=B(q-1)*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn);
    end
    payoff=max(B-B(N)); %error here
    crudecumsum=crudecumsum + payoff;
    crudeprices(p)=crudecumsum/p;
end
crudeprices=crudeprices*exp(-r*T);

%exact lookback pricing
tau=T;
deltaP = @(Tau,s) (log(s)+(r+0.5*sigma^2)*Tau)/(sigma*sqrt(Tau)); 
deltaM = @(Tau,s) (log(s)+(r-0.5*sigma^2)*Tau)/(sigma*sqrt(Tau)); 
term1 = @(t,x,y) (1+sigma^2/(2*r))*x*normcdf(deltaP(tau,x/y));
term2 = @(t,x,y) exp(-r*tau)*y*normcdf(-deltaM(tau,x/y));
term3 = @(t,x,y) (sigma^2/(2*r))*exp(-r*tau)*(y/x)^(2*r/sigma^2)*x*normcdf(-deltaM(tau,y/x));
v = @(t,x,y) term1(t,x,y)+term2(t,x,y)-term3(t,x,y)-x;    
exactprice=v(0,initial,initial);

figure;
hold on
x=2:2:M;
y1=antiprices;
y2=crudeprices(2:2:M);

plot(x, y1, 'b-')
plot(x, y2, 'r-')

set(gca,'FontSize',16)
xlabel('Number of paths','FontSize',20);
ylabel('Price','FontSize',20);
hold off
legend('Antithetic MC','Crude MC')