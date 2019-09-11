close all
clear variables

rng(1); %fixing the rng seed so that we can rerun the program with the same random variables.
T=1; N=512;
comp=min([128,N-1]); %the number of principal components considered
t=N^(-1):N^(-1):T;
C=zeros(N,N);
for i=1:N
    for j=1:N
        C(i,j)=min([i,j])/N; %creating the covariance matrix
    end
end
[V,D]=eig(C); %this returns a diagonal matrix D of eigenvalues and matrix V of eigenvectors
B=zeros(N,1);
for i=1:comp
    B=B+sqrt(D(N+1-i,N+1-i))*V(:,N+1-i)*randn;
end


figure
plot(t,B,'b');
set(gca,'FontSize',16);
xlabel('$t$','FontSize',20,'interpreter','latex');
ylabel('$B(t)$','FontSize',20,'interpreter','latex');    