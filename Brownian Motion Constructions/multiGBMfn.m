function S = multiGBMfn(d,initial,mu,sigma,Corr,T,N)

%dividing the time interval into N timepoints
dt=T/N;

Cov=zeros(d);                     %the covariance matrix
for covrow=1:d
    for covcol=1:d
        Cov(covrow,covcol)=sigma(covrow)*sigma(covcol)*Corr(covrow,covcol);
    end
end

%we now find the Cholesky factor A such that AA'=Cov. 
%The Matlab implementation of chol(Cov) returns A such that A'A=Cov, 
%so we need to consider the transpose (i.e. the lower triangular factor).
A=chol(Cov).';           %the Cholesky factorisation 

S=zeros(d,N);            %this matrix will hold each path in a row

%the following implements the procedure described on p104, Glasserman
for i=1:d          %we create a path for each of the d assets
    randsum=0;
    for j=1:d
        randsum=randsum+A(i,j)*randn;
    end
    S(i,1)=initial(i)*exp((mu(i)-0.5*A(i,i))*dt+sqrt(dt)*randsum);
    for k=2:N
        randsum=0;
        for j=1:d
            randsum=randsum+A(i,j)*randn;
        end
        S(i,k)=S(i,k-1)*exp((mu(i)-0.5*A(i,i))*dt+sqrt(dt)*randsum);
    end
end