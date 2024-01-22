%% Solvin %%Calculating eigenvalues of a nonsymmetric matrix using Particle Swarm Optimization- KDW-VG (inverse method)
%% Initialization
clear all
close all
clc
global Rainfallduration Intensity Us zz Wr Ws;
Rainfallduration=input('Rainfall duration(hr)=');
Intensity=input('Rainfall intensity(mm.hr-1)=');
Us= Intensity;
tic
format long G
swarm_size = 200 ;            % Size of the swarm 
swich=0 ;
max_iter =1000;              % Maximum number of iteration for every run
k = 5;
c2 = 2.4 ;            % PSO parameter C1 
c1 = 1.2 ;            % PSO parameter C2 
R1 = rand(k, swarm_size) ;
R2 = rand(k, swarm_size) ;
ww=1.1;
w1=1.2  ;
w2=0.2  ;
eps = 0.0001 ;
% Specifying the band and range of the coefficients.
ev=[-.9 -1.5;1.1 0.8;105 70;0.000013 0.000013;0.0043 0.0043];
%% **************************************************************************
                     %-------------------------------------------------------%
                     % Initializing swarm and velocities and position %
                     %-------------------------------------------------------%
for i=1:swarm_size                     
    position(1,i) = ev(1,2)+rand*( ev(1,1) - ev(1,2) );
    position(2,i) = ev(2,2)+rand*( ev(2,1) - ev(2,2) );
    position(3,i) = ev(3,2)+rand*( ev(3,1) - ev(3,2) );
    position(4,i) = ev(4,2)+rand*( ev(4,1) - ev(4,2) );%wr
    position(5,i) = ev(5,2)+rand*( ev(5,1) - ev(5,2) );%ws
end
        
position_fitness= faindif(position,swarm_size);
        if zz==1;
             fprintf('**Warning**: Choose the appropriate "h" and "tu" in faindif mfile to avoid the complex numbers for "u". Also it possible that the Wr value is high');
             return;
        end;           
p_best_position  = position;
p_best_fitness = position_fitness;
[g_best_fitness,g] = min(p_best_fitness) ;
last_best_fitness = g_best_fitness ;

for i = 1 : swarm_size
    g_best_position(:,i) = p_best_position(:,g) ;
end
velocity = zeros(k,swarm_size);
    

%% ************************************************************************
%% Main Loop
sprintf(' start ...' );
    iter = 0 ;        % Iteration’s counter
while  ( iter < max_iter ) && (swich==0) 
%     (g_best_fitness > eps)
iter = iter + 1 ;
R1 = rand(k, swarm_size) ;
R2 = rand(k, swarm_size) ;
ww = w1 - (w1-w2)*(iter/max_iter) ;
 velocity = ww * velocity + c1*(R1.*(p_best_position - position)) + c2*(R2.*(g_best_position - position)) ;
 position1 = position + velocity ;
for j=1:k
     for i=1:swarm_size
         if position1(j,i)<= ev(j,1) && position1(j,i) >=ev(j,2)
             position(j,i)= position1(j,i);
         end
     end
 end 

 position_fitness= faindif(position,swarm_size); if zz==1;return; end;
for i = 1 : swarm_size
        if position_fitness(i) < p_best_fitness(i)
           p_best_fitness(i) = position_fitness(i) ;  
           p_best_position(:,i) = position(:,i) ;      
        end   
end
 [global_best_fitness,g] = min(p_best_fitness) ; 
if global_best_fitness < g_best_fitness
   g_best_fitness = global_best_fitness ;
   for i = 1 : swarm_size
       g_best_position(:,i) = p_best_position(:,g) ;
   end  
end
 rrr(iter) = g_best_fitness ;
 sprintf(' iteration  %3.0f  .....', iter )

 if abs(g_best_fitness)<=eps
     swich=1;
 end    
end      % end of while loop      
j=j+1 ;
% t/exe_step
fprintf('Best position l = %f \n',g_best_position(1,1));
fprintf('Best position m = %f\n',g_best_position(2,1));
fprintf('Best position Vw = %f\n',g_best_position(3,1));
fprintf('Best position Wr = %f\n',g_best_position(4,1));
fprintf('Best position Ws = %f\n',g_best_position(5,1));
fprintf('Best fitness = %f\n',g_best_fitness);

figure(3);plot(rrr);set(gca,'Xtick',0:100:1000);
xlabel('Number of iteration');ylabel('Cost function');box;
title('KDW-VG (160.49)- Inverse sulotion- Cost function vs. Number of iteration')
save ('d')
load ('u')

figure('name','Numerical 2','color','w');plot(t,u(end,:));hold on;
plot(t1,u1,'o');hold on;
xlabel('Time (h)');ylabel('u (mm/h)');box;
set(gca,'Xtick',0:0.02:.16);
set(gca,'Ytick',0:30:180);
title('KDW-VG (160.49)- Inverse sulotion');

figure(2); plot(t,(u(end,:)),'*',t,real(u(end,:)),'.',t,imag(u(end,:)),'s');
xlabel('Time (h)');ylabel('u (mm/h)');box;
set(gca,'Xtick',0:0.02:.16);
set(gca,'Ytick',0:30:180);
title('KDW-VG (160.49)- Inverse sulotion');
Timerun= toc
% hold on
%% ************************************************************************