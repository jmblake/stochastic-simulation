%% A program to simulate interest rates under the Cox-Ingersoll-Ross model
% We sample from the exact transition law of the process.
% We must keep 2*alpha*b >= sigma^2. 
% An explanation can be found on pp.121-122, Glasserman.

clear variables

T=1; N=1001; %T is the endpoint of the time interval, N is the number of timepoints
b=.1; alpha=10; %b is the long-run interest rate and alpha is the speed r(t) approaches b
sigma=0.02; %variance
r0=0.11; %the interest rate at t=0

timePoints=linspace(0,T,N); 
dt=timePoints(2)-timePoints(1);

r=zeros(1,N); %the interest rate at the given time points
r(1)=r0; 

% lambda is the noncentrality paramenter and d=4*b*alpha/sigma^2 is the
% degree of freedom of the chi-squared distribution we draw from
lambda = zeros(1,N-1);
d=4*b*alpha/sigma^2;

Chi=zeros(1,N-1); %this is the set of chi-squared random variables

for i=2:N
    lambda(i-1) = r(i-1)*4*alpha*exp(-alpha*dt)/(sigma^2*(1-exp(-alpha*dt)));
    Chi(i-1) = (randn+sqrt(lambda(i-1)))^2 +chi2rnd(d-1);
    r(i) = sigma^2*(1-exp(-alpha*dt))/(4*alpha)*Chi(i-1);
end

hold on
plot(timePoints,r)
xlabel('$t$','Interpreter','latex','fontsize',16)
ylabel('$r(t)$','Interpreter','latex','fontsize',16)