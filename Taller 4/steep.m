f = @(x1,x2) 100*(x2 - x1.^2).^2 + (1 - x1).^2;

gradiente1 = @(x1,x2) -400*(x2 - x1.^2) - 2*(1 - x1);
gradiente2 = @(x1,x2) 200*(x2 - x1.^2);

newton1 = @(x1,x2) (-x1+1)/(200*x1^2-200*x2+1);
newton2 = @(x1,x2) (200*x1^4-x1^2*x1+200*x2^2-400*x1^2-x2)/(200*x1^2-200*x2+1);

x1 = 1.2;
x2 = 1.2;
fprintf("Steepest\n")
for i=1:4000 
  grad1 =  gradiente1(x1,x2);
  grad2 =  gradiente2(x1,x2);

  pGrad1 = -grad1;
  pGrad2 = -grad2;
   
  if i == 2001
    fprintf("Newton\n")
    x1 = -1.2;
    x2 = 1;
  elseif i >= 2001
    pGrad1 = newton1(x1,x2);
    pGrad2 = newton2(x1,x2);
  end

  alpha = 1;
  c1 = 0.01;

  condicionIzq = f((x1+(alpha*pGrad1)),(x2+(alpha*pGrad2)));
  condicionDer = f(x1,x2) + (alpha*c1*((grad1*pGrad1)+(grad2*pGrad2)));

  while condicionIzq > condicionDer
    alpha = 0.9*alpha;
   
    condicionIzq = f((x1 + (alpha.*pGrad1)) ,(x2+(alpha.*pGrad2)));
    condicionDer = f(x1,x2) + (alpha.*c1.*((grad1.*pGrad1)+(grad2.*pGrad2)));
  end
    
  x1 = x1 + alpha.*pGrad1;
  x2 = x2 + alpha.*pGrad2;
  
  if mod(i,200) == 0
    fprintf("f(x1,x2):%f  alpha:%d  x1,x2:%f,%f \n",f(x1,x2),alpha,x1,x2)
  end
end