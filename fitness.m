%% this M-file evaluate the fitness function of KDW-VG model
function f = fitness(pos,u,u1,t1,h,tu,n)
global Us Rainfallduration t
sum = 0;
%Us=57;Wr=0.023;Ws=0.55;
for ii=2:length(t1)
    j = floor(t1(ii)/tu)+1 ;
b1=(u(n,j)+u(n+1,j-1))/2;

if t(j)<Rainfallduration
 w=.0009*exp(.0093*b1);
else
w=- 1.88701e-9*b1^3 + 4.17667e-7*b1^2 + 0.00000687555*b1 + 0.000200175;
end   


a1=(w-pos(4))/(pos(5)-pos(4));a2=1/(pos(5)-pos(4)); te11=pos(1)*Us*a1^(pos(1)-1)*a2; te12=(1-( 1-a1^(1/pos(2)) )^pos(2) )^2; te1=te11*te12;
te21=2*Us*a2; te22=1-( 1-a1^(1/pos(2)) )^pos(2); te23=( 1-a1^(1/pos(2)) )^(pos(2)-1); te24=a1^(1/pos(2)+pos(1)-1);
te2=te21*te22*te23*te24; c=te1+te2;

teta(ii)=((tu*pos(3)*c)/(h^2))*((u(n+1,j-1)-2*u(n,j-1)+u(n-1,j-1)))-((c*tu)/(2*h))*(u(n+1,j-1)-u(n,j-1))+u(n+1,j-1);
end
sum = norm(u1-teta)/sqrt(length(t1));    
f = sum;

            
            
            
            