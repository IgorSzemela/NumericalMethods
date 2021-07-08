clc
clear all
close all

a = 0;   
b = 50;

figure(1)
[xvect, xdif, fx, it_cnt] = bisect(a,b,1e-12,@compute_impedance);
plot(1:it_cnt,xvect,'g')
hold on
[xvect, xdif, fx, it_cnt] = secant(a,b,1e-12,@compute_impedance);
plot(1:it_cnt,xvect,'b');
title("Impedance, aproximation of a root value x")
ylabel('Value of x');
xlabel('Number of iterations');
legend("Bisection","Secant")
hold off

figure(2)
[xvect, xdif, fx, it_cnt] = bisect(a,b,1e-12,@compute_impedance);
semilogy(1:it_cnt, xdif, 'g');
hold on
[xvect, xdif, fx, it_cnt] = secant(a,b,1e-12,@compute_impedance);
semilogy(1:it_cnt, xdif,'b');
title("Impedance, convergence rate")
ylabel('Difrences in x');
xlabel('Number of iterations');
legend("Bisection","Secant")
hold off

figure(3)
[xvect, xdif, fx, it_cnt] = bisect(a, b,1e-12,@upward_velocity);
plot(1:it_cnt,xvect,'g');
hold on
[xvect, xdif, fx, it_cnt] = secant(a, b,1e-12,@upward_velocity);
plot(1:it_cnt,xvect,'b');
title("Computing the time of a rocket, aproximation of a root value x")
ylabel('Value of x');
xlabel('Number of iterations');
legend("Bisection","Secant")
hold off

figure(4)
[xvect, xdif, fx, it_cnt] = bisect(a, b,1e-12,@upward_velocity);
semilogy(1:it_cnt,xdif, 'g');
hold on
[xvect, xdif, fx, it_cnt] = secant(a, b,1e-12,@upward_velocity);
semilogy(1:it_cnt, xdif,'b');
title("Computing the time of a rocket, convergence rate")
ylabel('Difrences in x');
xlabel('Number of iterations');
legend("Bisection","Secant")
hold off


options = optimset('Display','iter');

fzero(@tan,6,options)
fzero(@tan,4.5,options)
 
