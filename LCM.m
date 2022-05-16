format short
clear all
clc

 cost=[ 11 20 7 8; 
     21 16 10 12;
     8 12 18 9];
 A=[50 40 70];
 B=[30 25 35 40];
 
 if sum(A)==sum(B)
     fprintf('Given TP is balanced\n');
 else
     fprintf('Given TP unbalanced\n');
     if(sum(A)<sum(B))
         cost(end+1,:)=zeros(1,size(A,2));
         A(end+1)=sum(B)-sum(A);
     elseif(sum(B)<sum(A))
         cost(:,end+1)=zeros(1,size(A,2));
         B(end+1)=sum(A)-sum(B);
     
     end
     
 end
 
 icost=cost;
 x=zeros(size(cost));
 [m ,n]=size(cost);
 bfs=m+n-1;
 
 for i=1:size(cost,1)
     for j=1:size(cost,2)
            hh=min(cost(:));
            [rowind,colind]=find(hh==cost);
            x11=min(A(rowind),B(colind));
            [val,ind]=max(x11);
            ii=rowind(ind);
            jj=colind(ind);
            y11=min(A(ii),B(jj));
            x(ii,jj)=y11;
            A(ii)=A(ii)-y11;
            B(jj)=B(jj)-y11;
            cost(ii,jj)=inf;
     end
 end
 
 fprintf('Initial BFS=\n');
 IB=array2table(x);
 disp(IB);
 
 
 TotalBFS=length(nonzeros(x));
 if TotalBFS==bfs
     fprintf('Initail BFS is non-degenerate \n');
 else
     fprintf('Initail BFS is degenerate \n');
     
     
 end
 Initialcost=sum(sum(icost.*x));
 fprintf('Initial Cost=%d\n',Initialcost);
 
 
 