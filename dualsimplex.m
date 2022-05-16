clear all;
clc ;
format short;

variables={'x1','x2','x3','s1','s2','sol'};
cost=[-2 0 -1 0 0 0];
info=[-1 -1 1 ; -1 2 -4];
b=[-5 ;-8];
s=eye(size(info,1));
A=[info s b];
BV=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            BV=[BV i];
        end
    end
end

fprintf('Basic Variables\n');
disp(variables(BV));

zjcj=cost(BV)*A-cost;
zcj=[zjcj ; A];
simptable=array2table(zcj);
simptable.Properties.VariableNames(1:size(zcj,2))=variables

run=true;
while run

sol=A(:,end);
if any(sol<0)
    fprintf('The current BFs is not Feasible\n');
    [leaval,piv_row]=min(sol);
    fprintf('The leaving Row is %d\n',piv_row);
    row=A(piv_row,1:end-1);
    zj=zjcj(:,1:end-1);
    for i=1:size(row,2)
        if row(i)<0
            ratio(i)=abs(zj(i)./row(i));
        else
            ratio(i)=inf;
        end
    end
    [minval,pvt_col]=min(ratio);
    fprintf('Entering variables = %d\n',pvt_col);
    BV(piv_row)=pvt_col;
    fprintf('Basic Variables (BV) =')
    disp(variables(BV));
    
    pvt_key=A(piv_row,pvt_col);
    A(piv_row,:)=A(piv_row,:)./pvt_key;
    
    
    for i=1:size(A,1)
        if i~=piv_row
            A(i,:)=A(i,:)-A(i,pvt_col).*A(piv_row,:);
            
        end
        
    end
    
    zjcj=cost(BV)*A-cost;
zcj=[zjcj ; A];
simptable=array2table(zcj);
simptable.Properties.VariableNames(1:size(zcj,2))=variables

else
    run=false
    fprintf('The current BFs is Feasible\n');
    
end
end