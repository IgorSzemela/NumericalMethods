clc
clear all
close all

warning('off','all')


%T2
load trajectory1

N = 50;
[ poly_coeff, xa ] = polynomial_approx(n,x,N); 
[ poly_coeff, ya ] = polynomial_approx(n,y,N);  
[ poly_coeff, za ] = polynomial_approx(n,z,N);

figure(1)
plot3(x,y,z,'o')
grid on
axis equal
hold on
plot3(xa,ya,za,'lineWidth',4)
title("Approximation of the drone's position using polynomials for trajectory1")
xlabel('x')
ylabel('y')
zlabel('z')


%T3
load trajectory2

N = 50;
[ poly_coeff, xa ] = polynomial_approx(n,x,N);  
[ poly_coeff, ya ] = polynomial_approx(n,y,N);
[ poly_coeff, za ] = polynomial_approx(n,z,N);

figure(2)
plot3(x,y,z,'o')
grid on
axis equal
hold on
plot3(xa,ya,za,'lineWidth',4)
title("Approximation of the drone's position using polynomials for trajectory2")
xlabel('x')
ylabel('y')
zlabel('z')


%T4
%What is the name of the effect which causes the above error?: Runge’s phenomenon
load trajectory2
M = length(n);

for N = 1 : 71
    [ poly_coeff, xa ] = polynomial_approx(n,x,N); 
    [ poly_coeff, ya ] = polynomial_approx(n,y,N);
    [ poly_coeff, za ] = polynomial_approx(n,z,N); 
    
    err_x = sqrt( sum( (xa - x).^2) ) / M;
    err_y = sqrt( sum( (ya - y).^2) ) / M;
    err_z = sqrt( sum( (za - z).^2) ) / M;
    err(N)= err_x + err_y + err_z;
end

figure(3)
plot(err)
title("Error plot for N = 1, 2...71 for trajectory2 using polynomial approx.")
xlabel('N')
ylabel('err')


%T5
load trajectory1

N = 50;
[xa] = aprox_tryg(N,n,x);  
[ya] = aprox_tryg(N,n,y); 
[za] = aprox_tryg(N,n,z);

figure(4)
plot3(x,y,z,'o')
hold on
grid on
axis equal
plot3(xa,ya,za,'lineWidth',4)
title("Approximation of the drone's position using trygonometric approxiamation for trajectory1")
xlabel('x')
ylabel('y')
zlabel('z')

M = length(n);
for N = 1 : 71
    [xa] = aprox_tryg(N,n,x);  
    [ya] = aprox_tryg(N,n,y); 
    [za] = aprox_tryg(N,n,z);
    
    err_x = sqrt( sum( (xa' - x).^2) ) / M;
    err_y = sqrt( sum( (ya' - y).^2) ) / M;
    err_z = sqrt( sum( (za' - z).^2) ) / M;
    err(N)= err_x + err_y + err_z;
end

figure(5)
plot(err)
title("Error plot for N = 1, 2...71 using trygonometric approx. for trajectory1")
xlabel('N')
ylabel('err')


load trajectory2

N = 50;
[xa] = aprox_tryg(N,n,x);  
[ya] = aprox_tryg(N,n,y); 
[za] = aprox_tryg(N,n,z); 

figure(6)
plot3(x,y,z,'o')
hold on
plot3(xa,ya,za,'lineWidth',4)
title("Approximation of the drone's position using trygonometric approx. for trajectory2")
xlabel('x')
ylabel('y')
zlabel('z')
grid on
axis equal

M = length(n);
for N = 1 : 71
    [xa] = aprox_tryg(N,n,x);  
    [ya] = aprox_tryg(N,n,y); 
    [za] = aprox_tryg(N,n,z);
    
    err_x = sqrt( sum( (xa' - x).^2) ) / M;
    err_y = sqrt( sum( (ya' - y).^2) ) / M;
    err_z = sqrt( sum( (za' - z).^2) ) / M;
    err(N)= err_x + err_y + err_z;
end

figure(7)
plot(err)
title("Error plot for N = 1, 2...71 using trygonometric approx. for trajectory2")
xlabel('N')
ylabel('err')


%T6
load trajectory2

M = length(n);
for N = 1:71
    [xa] = aprox_tryg(N,n,x);  
    [ya] = aprox_tryg(N,n,y); 
    [za] = aprox_tryg(N,n,z);
    
    err_x = sqrt( sum( (xa' - x).^2) ) / M;
    err_y = sqrt( sum( (ya' - y).^2) ) / M;
    err_z = sqrt( sum( (za' - z).^2) ) / M;
    err(N)= err_x + err_y + err_z;
end

figure(8)
plot(err);
title('Error plot using trygonometric approx. for trajectory2')
xlabel('N')
ylabel('err')

[M,N] = min(err);
disp( sprintf("N where error is the lowest: %d", N));
%We can clearly see that trigonometric approximation is not prone to the
%Runge effect, because err is getting smaller and smaller when N increases
