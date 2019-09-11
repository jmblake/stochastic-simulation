%% A simulation of sample paths of the CEV Model using the Milstein approximation
%
close all
clear variables
  
T=1; N=100; %the rightmost end of the time interval, and the number of subintervals
mu=0.05; sigma=0.005;
Y0=0.14; % the intial value of the process at t=0
beta = 3/2; %the exponent of the price in the stochastic term of the SDE
%%
dt=T/N;
timePoints = 0:dt:T;
Y=[Y0 zeros(1,N)]; % the Milstein approximation to the process
B=randn(1,N+1);
 
for i=1:N
    Y(i+1) = Y(i) + mu*Y(i)*dt + sigma*Y(i)^(beta/2)*(B(i+1)-B(i)) + (beta/4)*sigma^2*Y(i)^(beta-1)*((B(i+1)-B(i))^2-dt);
end
%%
plot(timePoints,Y,'r.-')
axis([0 1 0.13 0.16])
xlabel('$t$','Interpreter','latex','fontsize',16)
ylabel('$S(t)$','Interpreter','latex','fontsize',16)