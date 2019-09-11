% A program to simulate Merton Jump Diffusions
% We assume the time between jumps follows an exponential distribution
% We assume the relative size of each jump is lognormally distributed
 
close all
clear variables
 
T=1; 
timesMu=0.1; %the mean of the exponential distribution the interarrival times are drawn from
jumpSizeMu=0.1; jumpSizeSigma=0.2; %the parameters describing the lognormal distribution of the jump sizes
 
interarrivalTimes=[]; %this will be populated with the interarrival times
while sum(interarrivalTimes)<=T
    interarrivalTimes = [interarrivalTimes exprnd(timesMu)];
end
interarrivalTimes(end)=[]; %the last entry in interarrivalTimes is greater than T so we remove it
 
jumpTimes = cumsum(interarrivalTimes); %the arrival times
 
n=size(jumpTimes,2); %n is the number of jumps
 
%we generate the jump sizes
jumpSizes = lognrnd(jumpSizeMu,jumpSizeSigma,1,n);
%jumpFactor(i) is the factor by which we multiply the GBM sim by if
%jumpTime(i)<t<jumpTime(i+1) 
jumpFactor = cumprod(jumpSizes);
 
X=linspace(0,T,1000);
n=size(X,2);
latestJump=zeros(1,n);
 
for i = 1:n
    latestJump(i) = max([0, jumpTimes(jumpTimes <= X(i))]);
end
 
jumpIndex=zeros(1,n); 
%jumpIndex will hold the number of jumps up to the given time indexes
for j = 1:n
    jumpIndex(j) = max([0,find(jumpTimes == latestJump(j))]);
end
jumpFactor=[1 jumpFactor];
 
figure
scatter(X,jumpFactor(jumpIndex+1),2,'filled')
xlim([0, T])
ylim([0,max(jumpFactor)+1])
xlabel('$t$', 'Interpreter','latex', 'FontSize',16)
ylabel('$S(t)$', 'Interpreter','latex', 'FontSize',16)