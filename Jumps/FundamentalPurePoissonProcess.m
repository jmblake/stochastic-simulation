close all
clear variables
 
T=100; 
mu=10; %the mean of the exponential distribution the interarrival times are drawn from
 
interarrivalTimes=[]; %this will be populated with the interarrival times
while sum(interarrivalTimes)<=T
    interarrivalTimes = [interarrivalTimes exprnd(mu)];
end
interarrivalTimes(end)=[];
 
jumpTimes = cumsum(interarrivalTimes); %the arrival times
 
[m,n]=size(jumpTimes); %n is the number of jumps
jumpProcess = 0:n;
 
figure
stairs([0 jumpTimes], jumpProcess)
xlabel('$t$', 'Interpreter','latex', 'FontSize',16)
ylabel('$N(t)$', 'Interpreter','latex', 'FontSize',16)