% Brute force changes due to individual variables and graph them as well (if wanted)

% Brute is the recallable function and is not responsible for state management
function Brute 
    rpm=3500; % rpm
    convR=rpm * 0.10472; % radians per second
    launchAngle=13; % degrees
    ballSpeed=190; % mph
    vx=(ballSpeed*cosd(launchAngle)); 
    vy=(ballSpeed*sind(launchAngle));

    [t,x]=ode45(@flightg, [0,8.3], [0,vx,0,vy]); 
end