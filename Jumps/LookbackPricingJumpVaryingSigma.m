close all
clear variables
T=1;
N=99;
timesMu=0.15;
jumpSizeMu=0.4;
mu=0.1;
sigma=0.4;
initial=1;

prices = [];
payoffSet = [];
trials=10^3;

X=0:0.02:1;

for jumpSizeSigma = X
    for i=1:trials
        sample = PureJump(T,N,timesMu,jumpSizeMu,jumpSizeSigma)...
                    .*GBM(T,N,mu,sigma,initial);
        samplePayoff = max(max(sample)-sample(end),0);
        payoffSet = [payoffSet samplePayoff];
    end
    prices = [prices mean(payoffSet)];
end


figure
plot(X,prices)
xlabel('$\sigma_{jump size}$','FontSize',16,'Interpreter','latex')
ylabel('$Option ~ Price$','FontSize',16,'Interpreter','latex')