function [poly_coeff, x_approx] = polynomial_approx(n,x,N)

mu = [mean(n) std(n)];
n2 = (n-mu(1))/mu(2);
poly_coeff = polyfit(n2,x,N);
x_approx = polyval(poly_coeff,n2);

end

