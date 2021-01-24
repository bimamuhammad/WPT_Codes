clear
close all

format long

d = 6.25E-3;
sR = 15E-3;%E-3;
N = 10;

w=1E-3;%E-3;
l=1E-3;%E-3;

theta = N*2*pi;
n=1000;
dtheta = pi/2:theta/n:theta+pi/2;
dtheta1 = 0:theta/n:theta;

r = (sR + (d .* dtheta)/(2*pi));
C = sR*theta + (d * theta^2)/(4*pi);
sA = 2*(l*w + C*l + C*w);

mu= 4*pi*1E-7;

Rel  = C/(mu*sA);

L = N^2 / Rel;
%L = N / Rel;plot
figure
plot(160E-3+r.*cos(dtheta),r.*sin(dtheta))
hold on

dtheta1 = 0:theta/n:theta;
r = (sR + (d .* dtheta1)/(2*pi));
grid on

plot(r.*sin(dtheta1),r.*cos(dtheta1));
hold off