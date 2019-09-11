function sim = VasicekSim(T,N,b,alpha,sigma,r0)
    %This creates a simulation of the Vasicek model with given parameters.
    %
    
    dt=T/N;
    timePoints=linspace(0,T,N);
 
    r=zeros(1,N); %the interest rate at the given time points
    r(1)=r0;
    Z=randn(1,N-1); %the array Z will hold the random draws from N(0,1)
 
    for i=2:N
        r(i)=exp(-alpha*dt)*r(i-1)+b*(1-exp(-alpha*dt))...
             +sigma*sqrt((1-exp(-2*alpha*dt))/(2*alpha))*Z(i-1);
    end
    sim = r;
end