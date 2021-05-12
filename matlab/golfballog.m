function Golfball 
    [t,x]=ode45(@flightg,[0,8.3],[0,175,0,75,0,0]); 
    plot3(x(:,1),x(:,5),x(:,3),'-ob'); 
    title('Golf Ball Model');
    xlabel('X (feet)');
    ylabel('Y (feet)');
    zlabel('Z (feet)');
    grid on 
    hold on 
end

function xprime=flightg(t,x) 
    %Parameters 
    V=20;
    C_d=.15; 
    r=.002378; 
    A=.25*pi*(1.75/12)^2; 
    m=(1.5/(16*32.2)); 
    D =((1/2)*C_d*r*A*V^2) ;
    %Square of the velocity is in the equation, therefor D =((1/2)*C_d*r*A); 
    %Magnus 
    s=.000005; 
    M=(s/m); 
    W_I=-100; 
    W_J=0; 
    W_K=110; 
    xprime=zeros(2,1); 
    %X 
    xprime(1)=x(2); 
    xprime(2)=-(D/m)*x(2)^2+M*(W_J*x(6)-W_K*x(4)); 
    %Y 
    xprime(3)=x(4); 
    xprime(4)=-32.2-(D/m)*x(4)^2+M*(W_K*x(2)-W_I*x(6));
    %Z
    xprime(5)=x(6); 
    xprime(6)=-(D/m)*x(6)^2+M*(W_I*x(4)-W_J*x(2));
end