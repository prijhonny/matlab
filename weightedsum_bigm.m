clc
clear all
M=10000;
A=[2,4,1,0,1,0,8;3,5,4,-1,0,1,15];
NAV=3;
basic=(5:6);
artificial=(6:6);
cost=[-2,-3.5,-3.5,0,0,M,0];
ZjCj=[-2-3*M,-3.5-5*M,-3.5-4*M,M,0,0,-15*M];
table1=[ZjCj;A];
simptable=array2table(table1);
simptable.Properties.VariableNames(1:size(table1,2))={'x1','x2','x3','s2','s1','a2','solution'}
basic
flag=0;
while flag==0
    Zc=ZjCj(1:size(A,2)-1);
    if any(Zc<0)
        fprintf('Not optimal table\n');
        [value,pivotcol]=min(Zc);
        val=A(:,size(A,2));
        alpha=A(:,pivotcol);
        if all(alpha<=0)
            fprintf('LPP is unbounded\n');
            break;
        end
        ratio=zeros(1,size(A,1));
        for i=1:size(A,1)
            if alpha(i)>0
                ratio(i)=val(i)./alpha(i);
            else
                ratio(i)=inf;
            end
        end
        [value1,pivotrow]=min(ratio);
        basic(pivotrow)=pivotcol;
        pivotele=A(pivotrow,pivotcol);
        A(pivotrow,:)=A(pivotrow,:)./pivotele;
        for i=1:size(A,1)
            if i~=pivotrow
                A(i,:)=A(i,:)-(A(i,pivotcol).*A(pivotrow,:));
            end
        end
        ZjCj=ZjCj-(ZjCj(pivotcol).*A(pivotrow,:));
        table=[ZjCj;A];
        simptable=array2table(table);
        simptable.Properties.VariableNames(1:size(table1,2))={'x1','x2','x3','s2','s1','a2','solution'}
        basic
    else
        flag=1;
        if any(basic>5)
            fprintf('no solution\n');
            break;
        end
    end
end