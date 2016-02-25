
 x1=input("ENTER VALUE OF X1:")
 x2=input("ENTER VALUE OF X2:")
 a=input("Coefficient of x^3:")
 b=input("Coefficient of x^2:")
 c=input("Coefficient of x:")
 d=input("Coefficient of constant:") 
 p= [a,b,c,d]
 polyout(p,'x')
 [x3,iteration]=processing(p,x1,x2)
 
 
