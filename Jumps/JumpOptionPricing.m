close all
clear variables
T=1;
N=999;
timesMu=0.15;
jumpSizeMu=0.4;
jumpSizeSigma=0.3;
mu=0.1;
sigma=0.4;
initial=1;

payoffSet = [];
trials=10^3;

for i=1:trials
    sample = PureJump(T,N,timesMu,jumpSizeMu,jumpSizeSigma)...
                .*GBM(T,N,mu,sigma,initial);
    samplePayoff = max(max(sample)-sample(end),0);
    payoffSet=[payoffSet samplePayoff];
end

disp(mean(payoffSet))
disp(sqrt(var(payoffSet)))

figure
histogram(payoffSet,10^4)
xlabel('$Option ~ Price$','FontSize',16,'Interpreter','latex')
ylabel('$Density$','FontSize',16,'Interpreter','latex')