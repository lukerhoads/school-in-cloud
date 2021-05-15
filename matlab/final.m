function Golfball
    disp('Starting calculations...');
    rpm=2500; % rpm
    convR=rpm * 0.10472; % radians per second
    setGlobalR(convR);
    setGlobalCalls(0);
    launchAngle=13; % degrees
    ballSpeed=190; % mph
    vx=(ballSpeed*cosd(launchAngle)); 
    vy=(ballSpeed*sind(launchAngle)); 
       
    [t,x]=ode45(@flightg, [0,8.3], [0,vx,0,vy]); 
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
    g=9.8;
    
    % Air density
    p=1.225;
    
    % Drag coefficient
    C_d=.225;
    
    % Lift coefficient
    C_l=0.7*C_d;
    
    % Surface area (used for drag only)
    A=.25*pi*(1.75/12)^2; 
    crossA=0.00572;
    
    % Angular velocity and velocity
    av=getGlobalR;
    wHat=[0 0 av]; %vector in direction of axis of rotation
    %w=av*wHat;
    
    vx=(x(2)/3660)*(1609.34);
    vy=(x(4)/3660)*(1609.34);
    v=[vx, vy, 0];
    
    % Air resistance equation
    Fdx=((1/2)*C_d*p*A*vx^2);
    Fdy=((1/2)*C_d*p*A*vy^2);
        
    % Velocity square root, finding out original vector magnitude
    Velsq=sqrt((vx^2)+(vy^2));
    flightangle=atand(vy/vx); 
                    
    % Magnus equation   
    Mcbug=(1/2)*C_l*p*crossA^2; % wrong calculation, decided to hard code 
    % A might be off, its surface not cross section
    disp(Mcbug);
    Mc=0.00005;
    %Fm=(Mc*(cross(wHat,v)/abs(cross(wHat,v)))); % sane version
    ME=cross(wHat,v);
    Fm=(Mc*ME);
    
    Fmx=Fm(1);
    Fmy=Fm(2);
                        
    % Grid declare
    xprime=zeros(2,1);
    
    % X
    xprime(1)=x(2);
    xprime(2)=-(Fdx/m)+(Fmx/m);
    % Y
    xprime(3)=x(4);
    xprime(4)=-g-(Fdy/m)+(Fmy/m);
    
    if mod(getGlobalCalls, 120) == 0
        setGlobalR(0.96*getGlobalR); % only run this on a per second basis (or just get brysons air time and distribute) 7 seconds
    end
    
    setGlobalCalls(getGlobalCalls+1);
end

function setGlobalR(val)
    global rpm;
    rpm = val;
end

function r = getGlobalR
    global rpm;
    r = rpm;
end

% Tried using call count method, but it changes based on vars so super hard
% to predict.
function setGlobalCalls(val)
    global calls;
    calls = val;
end

function c = getGlobalCalls
    global calls;
    c = calls;
end