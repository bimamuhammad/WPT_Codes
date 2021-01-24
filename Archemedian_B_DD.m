clear
close all
clc
%%%%%%% ALL DISTANCE ARE IN METERS %%%%%%%%%%

%% Constants

w = 2.5E-3;
delR = 5E-3;
d = 350E-3; %height
Num = 10:1:5000;
N = 10; %no of turns
mu = 4*pi*1E-7; %Permeability
I = 1; %Current
sR = 25E-3; %Start radius
gy = 0;
gx = 0;
gz = d;
theta = (N*2*pi);
B = zeros(size(Num));

%% Functions
%coil Geometry
drx = @(r, theta, gy, gz, offsety, dtheta, shift) (gz*r*sin(theta)*dtheta - w*(offsety+r*sin(theta) - gy)); %dl x R
dry = @(r, theta, gx, gz, offsetx, dtheta) (w*dtheta*(offsetx+r*cos(theta) - gx)-gz*r*cos(theta)*dtheta); %dl x R
drz = @(r, theta, gx, gy, offsetx, offsety, dtheta) ((r*cos(theta)*dtheta)*(offsety+r*sin(theta) - gy) - (r*sin(theta)*dtheta)*(offsetx+r*cos(theta) - gx));%dl x R offsetz+

arch_Rad = @(sR, theta, delR) (sR + (delR * theta / (2*pi)));
arch_Length = @(sR, theta, delR) (sR*theta + (delR * theta^2 / (4*pi)));

Rdist = @(r, theta, gx, gy, gz, offsetx, offsety, offsetz) sqrt((offsetx+r*cos(theta) - gx)^2 + (offsety+r*sin(theta) - gy)^2 + (offsetz-gz)^2);

b = @(I, P) (mu *I*P)/(4*pi);

for p=1:length(Num)
    n= Num(p)/2; %no of points
    dtheta =  N*pi/n;
    %% Coil 1 -> Leftmost coil
    P= 0;
    offsetx = 0;
    offsety = 0;
    offsetz = 0;
    teta = (0:dtheta:theta-dtheta)-(pi/2); %for coil on LHS
    for i=1:n
        r = arch_Rad(sR, teta(i), delR);

        dRxi = drx(r, teta(i), gy, gz, offsety, dtheta);
        dRyi = dry(r, teta(i), gx, gz, offsetx, dtheta);
        dRzi = drz(r, teta(i), gx, gy, offsetx,offsety, dtheta);
        Ri = Rdist(r, teta(i), gx, gy, gz, offsetx, offsety,offsetz);
        P = P + sqrt(dRxi^2 + dRyi^2 + dRzi^2)/Ri^3;
    end
    B1 = b(I, P);
    %disp(['B field for Coil 1 at ', num2str(d), ' m is ', num2str(B1)])

    %% Coil 2 -> Rightmost coil
    %reinitialize P
    P= 0;
    offsetx = 0;
    offsety = 150E-3;
    offsetz = 0;
    teta1 = (3*pi/2) - 0:dtheta:theta+dtheta; %for coil on RHS
    for i=1:n
        r = arch_Rad(sR, teta1(i), delR);

        dRxi = drx(r, teta1(i), gy, gz, offsety, dtheta);
        dRyi = dry(r, teta1(i), gx, gz, offsetx, dtheta);
        dRzi = drz(r, teta1(i), gx, gy, offsetx,offsety, dtheta);
        Ri = Rdist(r, teta1(i), gx, gy, gz, offsetx,offsety,offsetz);
        P = P + sqrt(dRxi^2 + dRyi^2 + dRzi^2)/Ri^2;
    end
    B2 = b(I, P);
    %disp(['B field for Coil 2 at ', num2str(d), ' m is ', num2str(B2)])

    B(p)= B1+B2;
    %disp(['B field Total at ', num2str(d), ' m is ', num2str(B)])
end
%% Result Plots
plot(Num, B);
