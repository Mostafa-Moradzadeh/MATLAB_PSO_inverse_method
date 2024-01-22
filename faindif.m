%Name: KDW-VG Finite difference- Inverse solution

function position_fitness = faindif(position,swarm_size)
global Us Wr Ws zz Rainfallduration t
format longG
swarm_size=200;
h=150;tu=0.0002;
%In parentheses of 'xlsread,' the paths of the files should be entered, like ('E:\..\..\t.xlsx') and ('E:\..\..\u.xlsx')
t1=xlsread('E:\..\..\t.xlsx');
t1=t1';
u1=xlsread('E:\..\..\u.xlsx');
u1=u1';
l=300;T=t1(end);
t=0:tu:T;
m=length(t)-1;
x=0:h:l;
x(end)=l;
n=length(x)-1;
for q=1:swarm_size
        Vw=position(3,q);
        ll=position(1,q);
        mm=position(2,q);
        Wr=position(4,q);
        Ws=position(5,q);
%--------------------------------------------------------------------------
u=zeros(n+1,m+1);for i=1:n+1;u(i,1)=u0(x(i));end;
for j=1:m+1;u(1,j)=Ui(t(j));end;
%--------------------------------------------------------------------------

zz=0;
for j=2:m+1;
     if zz==1;break;end
    for i=2:n+1;
       b1=(u(i-1,j)+u(i,j-1))/2;

if t(j)<Rainfallduration
 w=.0009*exp(.0093*b1);
else
w=- 1.88701e-9*b1^3 + 4.17667e-7*b1^2 + 0.00000687555*b1 + 0.000200175;
end
       
c=(2*Us*(1 - ((Wr - w)/(Wr - Ws))^(1/mm))^(mm - 1)*((Wr - w)/(Wr - Ws))^((ll*mm - mm + 1)/mm)*((1 - ((Wr - w)/(Wr - Ws))^(1/mm))^mm - 1))/(Wr - Ws) - (Us*ll*((Wr - w)/(Wr - Ws))^(ll - 1)*((1 - ((Wr - w)/(Wr - Ws))^(1/mm))^mm - 1)^2)/(Wr - Ws);

        Vu=c*Vw;
        if i==n+1
           u(i,j)=((tu*Vu)/(h^2))*((u(i,j-1)-2*u(i-1,j-1)+u(i-2,j-1)))- ...
                ((c*tu)/(h))*(u(i,j-1)-u(i-1,j-1))+u(i,j-1);
        else
            u(i,j)=((tu*Vu)/(h^2))*((u(i+1,j-1)-2*u(i,j-1)+u(i-1,j-1)))- ...
                ((c*tu)/(2*h))*(u(i+1,j-1)-u(i-1,j-1))+u(i,j-1);
        end
         if imag(u(i,j))~=0
            zz=1;break;
         end 
    end
%     disp([j m]);
end
%--------------------------------------------------------------------------
save('u');

 position_fitness(q) = fitness(position(:,q),u,u1,t1,h,tu,n);    
end


