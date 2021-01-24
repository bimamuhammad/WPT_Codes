clear

d = 200E-3; %height
n= 2780; %no of points
N = 10; %no of turns
mu = 4*pi*1E-7; %Permeability
I = 1; %Current
sR = 25E-3;
w = 5E-3;

gy = 0;
gx = 0;
gz = d;

dtheta =  N*2*pi / n;
teta = 0:dtheta:(N*2*pi);


%|i             j             k|
%|rcos(theta)dtheta             |
%||

drx = @(r, theta, gy, gz) gz*r*sin(theta)*dtheta - w*(r*sin(theta) - gy); %dl x R
dry = @(r, theta, gx, gz) gz*r*cos(theta)*dtheta - w*(r*cos(theta) - gx); %dl x R
drz = @(r, theta, gx, gy) (gx*sin(theta) - gy*cos(theta))*r*dtheta;%dl x R

arch_Rad = @(sR, theta, delR) (sR + (delR * theta / (2*pi)));
arch_Length = @(sR, theta, delR) (sR*theta + (delR * theta^2 / (4*pi)));

Rdist = @(r, theta, gx, gy, gz) sqrt((r*cos(theta) - gx)^2 + (r*sin(theta) - gy)^2 + gz^2);

b = @(I, P) (mu *I*P)/(4*pi);

dRx=0;
dRy=0;
dRz=0;
R=0;
delR = 5E-3;
P= 0;

for i=1:n
    r = arch_Rad(sR, teta(i), delR);
    
    dRxi = drx(r, teta(i), gy, gz);
    dRyi = dry(r, teta(i), gx, gz);
    dRzi = drz(r, teta(i), gx, gy);
    Ri = Rdist(r, teta(i), gx, gy, gz);
    
    %dRx = dRx + dRxi;
    %dRy = dRy + dRyi;
    %dRz = dRz + dRzi;
    %R = R + Ri;
    P = P + sqrt(dRxi^2 + dRyi^2 + dRzi^2)/Ri^3;
end



B = b(I, P);
disp(['B field at ', num2str(d), ' m is ', num2str(B)])


