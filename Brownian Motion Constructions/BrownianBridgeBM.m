close all
clear variables

mu=1; sigma=0.5;
T=1; m=4; 
N=2^m; dt=T/N;
t=N^(-1):N^(-1):T;
B=zeros(1,N+1);
h=N; j_max=1;

B(h+1)=sqrt(T)*normrnd(mu*t(m),t(m)); %generating the rightmost point

for i=1:N+1
    t(i)=(i-1)*dt; %creating the vector of time points
end

for k=1:m
    i_min=h/2; i=i_min+1;
    l=1; r=h+1;
    for j=1:j_max
        a=((t(r)-t(i))*B(l)+(t(i)-t(l))*B(r))/(t(r)-t(l));
        b=sqrt((t(i)-t(l))*(t(r)-t(i))/(t(r)-t(l)));
        B(i)=a+b*randn;
        i=i+h; l=l+h; r=r+h;
    end
    j_max=2*j_max;
    h=i_min;
end

figure
plot(t, sigma*B, 'b'); %multiplying by sigma scales BM to the desired distribution
set(gca,'FontSize',16);
xlabel('$t$','FontSize',20,'interpreter','latex');
ylabel('$B(t)$','FontSize',20,'interpreter','latex');