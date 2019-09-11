close all
clear variables

T=1; N=1000; %T is the endpoint of the time interval, N is the number of timepoints
b=.1; alpha=10; %b is the long-run interest rate and alpha is the speed r(t) approaches b
sigma=0.02; %variance
r0=0.12; %the interest rate at t=0
trials=10^5;

cumSum = 0;
priceSet = [];
for i=1:trials
    sample=VasicekSim(T,N,b,alpha,sigma,r0);
    approxIntegral=(sum(sample)-sample(1))*T/N;
    samplePrice=exp(-approxIntegral);
    cumSum = cumSum + samplePrice;
    priceSet = [priceSet samplePrice];
end

priceSet = priceSet.';

fitdist(priceSet,'Normal')
figure
histfit(priceSet)
xlabel('$Bond ~ Price$','FontSize',16,'Interpreter','latex')
ylabel('$Density$','FontSize',16,'Interpreter','latex')