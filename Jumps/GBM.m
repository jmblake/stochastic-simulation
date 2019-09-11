function sim = GBM(T,N,mu,sigma,initial)
dt = T/N;
B=zeros(1,N);       %the value GBM takes at each timestep
%generating the values at the first time step
B(1)=initial*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn);

for i=2:N
    B(i)=B(i-1)*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn); %the recurrence relation
end

sim = [initial,B];
end