function [xvect, xdif, fx, it_cnt] = secant(a,b,eps,fun)

   fa = feval(fun,a);
   fb = feval(fun,b);
   
for i = 1:1000
    
     if(abs(fa - fb) <= eps && abs(a - b) <= eps)
        break;
     end
     
    x = (a*fb - b*fa) / (fb - fa);
    xvect(i) = x;
    f = feval(fun, x);
    
     if( abs(f) <= eps && abs(a - b) <= eps)
         break;
     end
      
    a = b;
    fa = fb;
    b = x;
    fb = f;
    
    if (i>=2)
       xdif(i) = abs(xvect(i-1) - x);
    else
       xdif(i) = x;
    end
       
    fx = feval(fun,x);
    
end
it_cnt = i - 1;     
end