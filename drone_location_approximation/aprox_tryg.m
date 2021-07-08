function [ x_aprox ] = aprox_tryg( N, n,x  )

n = n/max(n);
S = zeros(N,N);

t = zeros(N,1);
for k = 1 : N
    for i = 1:length(x)
        t(k,1) = t(k,1) + cos(k * n(i)) * x(i);
    end   
end

for k = 1:N
  for l = 1:N
      for i = 1:length(x)
            S(k,l) =   S(k,l) + cos(k * n(i)) * cos(l * n(i));
      end   
   end
end   

c = S\t;

c1 = [];
for i = 1: N
    c1(i,:) = cos(i * n) ;
end

x_aprox = c1' * c;

end

