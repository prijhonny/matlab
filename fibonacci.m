clear all;
clc;
format short;
f=@(x) (x<1/2).*((1-x)./2)+(x>=0.5).*(x.^2);
L=-1;
R=1;
n=6;
t=linspace(L,R,100);
plot(t,f(t),'k','LineWidth',2)
fib=ones(1,n);

for i=3:n+1
    fib(i)=fib(i-1)+fib(i-2);
end

for k=1:n
    ratio=fib(n+1-k)/fib(n+2-k);
    x2=L+ratio*(R-L);
    x1=R+L-x2;
    fx1=f(x1);
    fx2=f(x2);
    res(k,:)=[L R x1 x2 fx1 fx2];
    if fx1 < fx2
        R=x2;
    elseif fx2<fx1
        L=x1;
    elseif fx1==fx2
        if min(abs(x1),abs(L))==abs(L)
            R=x2;
        else
            L=x1;
        end
        
    end
    
end


variables={'L','R','x1','x2','fx1','fx2'};
result=array2table(res);
result.Properties.VariableNames(1:size(res,2))=variables

optx=(L+R)/2;
disp(optx);
optf=f(optx);
disp(optf);
