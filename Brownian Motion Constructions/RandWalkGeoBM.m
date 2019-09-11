close all
clear variables

T=1;    %the right endpoint of the time interval
N=1000; %the number of timesteps within the interval
dt=T/N; %the length of each timestep
mu=2; sigma=0.5;    %change parameters to model different GBM
initial=1;          %the initial value taken by GBM
B=zeros(1,N);       %the value GBM takes at each timestep

%generating the values at the first time step
B(1)=initial*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn);

for i=2:N
    B(i)=B(i-1)*exp((mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn); %the recurrence relation
end

figure
plot(0:dt:T, [initial,B], 'b');
set(gca,'FontSize',16);
xlabel('$t$','FontSize',20,'interpreter','latex');
ylabel('$S(t)$','FontSize',20,'interpreter','latex');