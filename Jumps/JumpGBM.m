close all
clear variables
T=1;
N=999999;
timesMu=0.15;
jumpSizeMu=0.05;
jumpSizeSigma=0.08;
mu=0.1;
sigma=0.4;
initial=0.12;

process = PureJump(T,N,timesMu,jumpSizeMu,jumpSizeSigma).*GBM(T,N,mu,sigma,initial);
dt=T/N;
X=0:dt:T;
figure
scatter(X,process,1,'filled')
xlabel('$t$', 'Interpreter','latex', 'FontSize',16)
ylabel('$S(t)$', 'Interpreter','latex', 'FontSize',16)