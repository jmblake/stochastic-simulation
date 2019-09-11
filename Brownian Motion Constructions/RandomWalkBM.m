close all
clear variables
 
T=1; %the length of the time interval
N=1000; %the number of timesteps within the interval
dt=T/N; %the length of each timestep
mu=0; sigma=1; %these parameters can be changed to model any Brownian motion.
 
dB=zeros(1,N); %the change in Brownian motion at each timestep
B=zeros(1,N); %the value Brownian motion takes at each timestep
 
dB(1)=mu*dt+sigma*sqrt(dt)*randn; %generating the values at the first time step
B(1)=dB(1);
 
for i=2:N
    dB(i)=mu*dt+sigma*sqrt(dt)*randn;
    B(i)=B(i-1)+dB(i); %the recurrence relation
end
 
figure
plot(0:dt:T, [0,B], 'b');
set(gca,'FontSize',16);
xlabel('$t$','FontSize',20,'interpreter','latex');
ylabel('$B(t)$','FontSize',20,'interpreter','latex');