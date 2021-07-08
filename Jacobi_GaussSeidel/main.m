clc
clear all 
close all 

% Task A
% ----------------------------------
N = 10;
density = 3; 
Edges = generate_network(N,density); 
% ----------------------------------

% Task B
% ----------------------------------
n = max(max(Edges));
nr_of_links = size(Edges,2);
d = 0.85;

b = ones(n,1) * (1 - d)/n;
I = speye(n);
B = sparse(Edges(2, :), Edges(1, :), ones(1,nr_of_links));
L = full(sum(B));  
A = sparse(1:n, 1:n, 1./L);
M = I - d * B * A;
save taskB A B I M b
% ----------------------------------

% Task C
% ----------------------------------
r = M\b;
save taskC r
% ----------------------------------

% Task D
% ----------------------------------
clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];
density=10;

for i = 1:length(N)    
    Edges = generate_network(N(i),density); 
    % 1. Generate table Edges for N corresponding to the loop index
    n = max(max(Edges));
    nr_of_links = size(Edges,2);
    d = 0.85;

    b = ones(n,1) * (1 - d)/n;
    I = speye(n);
    B = sparse(Edges(2, :), Edges(1, :), ones(1,nr_of_links));
    L = full(sum(B))  ;
    A = sparse(1:n, 1:n, 1./L);
    M = I - d * B * A;
    % 2. Generate tables A,B,I,b, and M
    tic
    r = M\b
    % 3. Formula for the direct solution to Mr=b 
    timeDirect(i) = toc;
end

figure(1)
% plot computational time vs N (label both axes and add a title)
plot(N, timeDirect)
title("Computational time in a function of N using direct method")
ylabel("time[s]")
xlabel("Matrix size[N]")
saveas(gcf,'taskD','png')

figure(2)
semilogy(N, timeDirect)
title("Computational time in a function of N (semilogy function) using direct method")
ylabel("time[s]")
xlabel("Matrix size[N]")
% plot computational time vs N using function semilogy (label both axes and add a title)
saveas(gcf,'taskD_semilog','png')
%----------------------------------



% Repeat Task D using r = inv(M)*b instead of r = M\b. 
% To this end, consider only 4 cases: N = [500,1000,3000,6000]
clc
clear all
close all
N = [500, 1000, 3000, 6000];
density=10;


for i = 1:length(N)
    
    Edges = generate_network(N(i),density); 
    n = max(max(Edges));
    nr_of_links = size(Edges,2);
    d = 0.85;

    b = ones(n,1) * (1 - d)/n;
    I = speye(n);
    B = sparse(Edges(2, :), Edges(1, :), ones(1,nr_of_links));
    L = full(sum(B))  ;
    A = sparse(1:n, 1:n, 1./L);
    M = I - d * B * A;
    tic
    r = inv(M)*b;
    timeDirect(i) = toc;
end

figure(1)
plot(N, timeDirect)
title("Computational time in a function of N using r = inv(M)*b")
ylabel("time[s]")
xlabel("Matrix size[N]")
saveas(gcf,'taskD_repeated','png')

figure(2)
semilogy(N, timeDirect)
title("Computational time in a function of N using semilogy function using r = inv(M)*b")
ylabel("time[s]")
xlabel("Matrix size[N]")
saveas(gcf,'taskD_semilog_repeated','png')
%----------------------------------

% Task E
%----------------------------------
clc
clear all
close all
% Jacobi

N = [500, 1000, 3000, 6000, 12000];

density=10;
eps=10^-10;
iterMax=10^3; %update this values if needed

for i=1:1:length(N)
    Edges = generate_network(N(i),density)
     % Generate Edges
    n = max(max(Edges));
    nr_of_links = size(Edges,2)
    d = 0.85;

    b = ones(n,1) * (1 - d)/n;
    I = speye(n);
    B = sparse(Edges(2, :), Edges(1, :), ones(1,nr_of_links));
    L = full(sum(B))  ;
    A = sparse(1:n, 1:n, 1./L);
    M = I - d * B * A;
   
    L=tril(M,-1);
    U=triu(M,1);
    D=diag(diag(M));
    rJ = ones(N(i),1);
    tic
    for j=1:1:iterMax
        rJ = (-D) \ ((L+U)*rJ - b);
        res = M*rJ - b;
        nres(j) = norm(res);
        disp(nres(j)) % displays the current norm of 'res'
        if nres(j)<=eps % stop condition
            timeJacobi(i)=toc;
            iter(i)=j;
            nresAll(i)=nres(j);
%             fprintf('Number of iterations for N=%i: %i\n',N(i),iter(i));
            break
        end
    end
end

figure(1)
% plot computational time (timeJacobi) vs N (label both axes and add a title) 
plot(N, timeJacobi)
title("Computational time in a function of N using Jacobi method")
ylabel("time[s]")
xlabel("Matrix size[N]")
saveas(gcf,'taskE1','png')

figure(2)
% plot number of iterations (iter) vs N (label both axes and add a title) 
plot(N, iter);
title("Number of iterations in function of N using Jacobi method")
xlabel("Matrix size[N]")
ylabel("Number of iterations[i]")
saveas(gcf,'taskE2' ,'png')

figure(3)
semilogy(N, nresAll)
title("Residuum norm for all values of N using Jacobi method")
ylabel("Residdum vector[r]")
xlabel("Matrix size[N]")
% plot residdum vector norm (nresAll) vs N using function semilogy (label both axes and add a title) 
saveas(gcf,'taskE3','png')
save taskE timeJacobi iter nresAll
% ----------------------------------

% % Task F
% % ----------------------------------
clc
clear all
close all

% Gauss-Seidel

N = [500, 1000, 3000, 6000, 12000];
density=10;
eps=10^-10;
iterMax=10^3;


for i=1:1:length(N)
    Edges = generate_network(N(i),density); 
     % Generate Edges
    n = max(max(Edges));
    nr_of_links = size(Edges,2);
    d = 0.85;

    b = ones(n,1) * (1 - d)/n;
    I = speye(n);
    B = sparse(Edges(2, :), Edges(1, :), ones(1,nr_of_links));
    L = full(sum(B))  ;
    A = sparse(1:n, 1:n, 1./L);
    M = I - d * B * A;
    % Generate tables A,B,I,b,M
    % Generate the lower triangular part of matrix M using L=tril(M,-1);
    L=tril(M,-1);
    % Generate the upper triangular part of matrix M using U=triu(M,1);
    U=triu(M,1);
    % Generate the the main diagonal of matrix M using D=diag(diag(M));
    D=diag(diag(M));
    % Set the initial r vector using ones(N(i),1);
     rGS = ones(N(i),1);
    tic
    fprintf('Executing GS method for N=%i:\n',N(i));
   
    % Use the forward substitution instead of using explicit matrix inverse
    % Calculate residuum vector 'res' and its norm 'nres'
    for j=1:1:iterMax
        rGS = -(D+L) \ (U*rGS) + (D+L)\b;       
        res = M*rGS - b;
        nres(j) = norm(res);
        disp(nres(j)) % displays the current norm of 'res'
        if nres(j)<=eps % stop condition
            timeGS(i)=toc;
            iter(i)=j;
            nresAll(i)=nres(j);
            fprintf('Number of iterations for N=%i: %i\n',N(i),iter(i));
            break
        end
    end
end

figure(1)
plot(N, timeGS)
title(" computational time in a function of N using GS method")
ylabel("time[s]")
xlabel("Matrix size[N]")
saveas(gcf,'taskF1','png')

figure(2)
plot(N, iter);
title("number of iterations in function of N using GS method")
xlabel("Matrix size[N]")
ylabel("Number of iterations[i]")
saveas(gcf,'taskF2','png')

figure(3)
semilogy(N, nresAll)
title("Residuum norm for all values of N using GS method")
ylabel("Residdum vector[r]")
xlabel("Matrix size[N]")
saveas(gcf,'taskF3','png')
save taskF timeGS iter nresAll

