function [xvect, xdif, fx, it_cnt] = bisect(a,b,eps,fun)

for i = 1:1000
       x = (a + b)/2; %[a...x...b]
    
      if(abs(feval(fun,x)) <= eps && abs(a - b) <= eps )
        break;    
      end

      if(feval(fun,x) * feval(fun,b) < 0)
        a = x;
      else
        b = x;
      end
      
      xvect(i) = x;
      
      if (i>=2)
        xdif(i) = abs(xvect(i-1) - x);
      else
        xdif(i) = x;
      end
    
      fx = feval(fun,x); %compute_impedance(x) or upward_velocity(x)     
end
 it_cnt = i - 1;     
end