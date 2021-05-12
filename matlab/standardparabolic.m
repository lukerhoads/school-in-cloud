function Classicball 
    %initial velocity = 215.06 feet/sec = 146.63 m/h @ 35.54 degrees 
    [t,x]=ode45(@flights,[0,7.763],[0,175,0,125,0,0]); 
    plot(x(:,1),x(:,3)); 
    title('Clasical Model') 
    xlabel('X') 
    ylabel('Y') 
    grid on 
end

function xprime=flights(t,x) 
    xprime=zeros(2,1); 
    %X 
    xprime(1)=x(2); 
    xprime(2)=0; 
    %Y 
    xprime(3)=x(4); 
    xprime(4)=-32.2; 
    %Z
    xprime(5)=x(6);
    xprime(6)=0;
end