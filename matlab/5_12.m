function Golfball
    disp('Starting calculations...');
    rpm=2500; % rpm
    convR=rpm * 0.10472; % radians per second
    setGlobalR(convR);
    launchAngle=13; % degrees
    ballSpeed=190; % mph
    vx=(ballSpeed*cosd(launchAngle)); 
    vy=(ballSpeed*sind(launchAngle)); 
    
    [t,x]=ode45(@flightg, [0,8.3], [0,vx,0,vy]); % launch angle and ball speed (in degrees and mph)
    plot(x(:,1),x(:,3)); 
    title('Golf Ball Model');
    xlabel('X (meters)');
    ylabel('Y (meters)');
    grid on
    hold on
end

function xprime=flightg(t,x)
    %Parameters
                     
    % Mass
    m=0.04593; 
    
    % Gravity 
    g=9.80;
    
    % Air density
    p=1.225;
    
    % Angular velocity and velocity
    setGlobalR(0.96*(getGlobalR/60));
    av = getGlobalR;
    %disp(av);
    
    vx=(x(2)/3660)*(1609.34);
    vy=(x(4)/3660)*(1609.34);
    %disp(vx);
    %disp(vy);
    
    % Drag
    C_d=.225;
    
    % Lift
    C_l=0.7*C_d;
    
    % Surface area
    A=.25*pi*(1.75/12)^2; 
    
    % Air resistance equation
    Fdx=((1/2)*C_d*p*A*vx^2);
    Fdy=((1/2)*C_d*p*A*vy^2);
    
    % Spin ratios
    Vrx=av*vx;
    Vry=av*vy;
        
    % Square root of sum of squares of velocity and angular velocity (magnus cross prod solution)
    Vrsqx=sqrt((av^2)+(vx^2));
    Vrsqy=sqrt((av^2)+(vy^2));
    
    % Magnus equation 
    % Fmx=((1/2)*C_l*p*A*((av + vx)/Vrsqx)); % this is point of error
    % Fmy=((1/2)*C_l*p*A*((av + vy)/Vrsqy)); 
    
    % Magnus equation (no error)
    Fmx=((1/2)*C_l*p*A*(Vrx/abs(Vrx)));  % this is always the same value because last term equals one
    Fmy=((1/2)*C_l*p*A*(Vry/abs(Vry))); 
    %disp(Fmx);
    %disp(Fmy);
    
    % Grid declare
    xprime=zeros(2,1);
    
    % X
    xprime(1)=x(2);
    xprime(2)=-(Fdx/m)+(Fmx/m);
    % Y
    xprime(3)=x(4);
    xprime(4)=-g-(Fdy/m)+(Fmy/m);
end

function setGlobalR(val)
    global rpm;
    rpm = val;
end

function r = getGlobalR
    global rpm;
    r = rpm;
end