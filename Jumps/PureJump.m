function sim = PureJump(T,N,timesMu,jumpSizeMu,jumpSizeSigma)

dt=T/N;

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
 
X=0:dt:T;
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

sim = jumpFactor(jumpIndex+1);
end