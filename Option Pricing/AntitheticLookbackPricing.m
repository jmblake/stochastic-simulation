close all
clear variables

T=1; N=252;
dt=T/N;
trials=10^6; %must be even

mu=0.05; sigma=0.1;
initial=1;
r=0.02;

B1=zeros(1,N);
B2=zeros(1,N);
cumsum1=0;
cumsum2=0;

for i=1:(trials/2)
    Y1=randn(1,N);
    Y2=-Y1;
    B1(1)=initial*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*Y1(1));
    B2(1)=initial*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*Y2(1));
    for j=2:N
        B1(j)=B1(j-1)*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*Y1(j));
        B2(j)=B2(j-1)*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*Y2(j));
    end
    cumsum1=cumsum1+(max([initial,B1])-B1(N));
    cumsum2=cumsum2+(max([initial,B2])-B2(N));
end
payoff=(cumsum1+cumsum2)/trials;
price=payoff*exp(-r*T);
disp(payoff)