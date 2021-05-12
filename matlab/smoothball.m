function Smoothball 
    [t,x]=ode45(@flights,[0,6.299],[0,175,0,125]); 
    %initial velocity = 215.06 feet/sec = 146.63 m/h @ 35.54 degrees 
    plot(x(:,1),x(:,3)); 
    title('Smooth Ball Model');
    xlabel('X'); 
    ylabel('Y');
    grid on 
end

function xprime=flights(t,x) 
    %Parameters 
    C_d=.25; 
    r=.002378; 
    A=.25*pi*(1.75/12)^2; 
    m=(1.5/(16*32.2)); 
    %D =((1/2)*C_d*r*A*V^2 %Square of the velocity is in the equation, therefore
    D =((1/2)*C_d*r*A); 
    xprime=zeros(2,1); 
    %X 
    xprime(1)=x(2); 
    xprime(2)=-(D/m)*x(2)^2; 
    %Y 
    xprime(3)=x(4); 
    xprime(4)=-32.2-(D/m)*x(4)^2; 
end