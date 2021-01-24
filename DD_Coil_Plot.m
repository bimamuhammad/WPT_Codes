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
dtheta = 0:theta/n:theta;
shift = pi/2;

r = (sR + (d .* (dtheta))/(2*pi));
C = sR*theta + (d * theta^2)/(4*pi);
sA = 2*(l*w + C*l + C*w);

mu= 4*pi*1E-7;

Rel  = C/(mu*sA);

L = N^2 / Rel;
%L = N / Rel;plot
X2=160E-3+r.*cos(dtheta+shift);
Y2=r.*sin(dtheta+shift);
figure('Name', 'Layer 1')
plot(X2,Y2);
hold on

shift = 0;
%dtheta1 = 0:theta/n:theta;
r = (sR + (d .* dtheta)/(2*pi));
grid on
X1=r.*cos(pi/2 - dtheta+shift);
Y1=r.*sin(pi/2 -dtheta+shift);
plot(X1,Y1);

plot([X1(end) X2(end)], [Y1(end) Y2(end)]); %Joining_Line
hold off


%Layer 2
%dtheta = 0:theta/n:theta;
%close all
shift = pi/2;
r = (sR + (d .* (dtheta))/(2*pi));
X2=160E-3+r.*cos(pi - dtheta+shift);
Y2=r.*sin(pi - dtheta+shift);
figure('Name', 'Layer 2')
%plot(X2,Y2);
hold on

shift = 0;
r = (sR + (d .* dtheta)/(2*pi));
grid on
X1=r.*cos(dtheta+shift-pi/2);
Y1=r.*sin(dtheta+shift-pi/2);
%plot(X1,Y1);

%plot([X1(end) X2(end)], [Y1(end) Y2(end)]); %Joining_Line
%hold off

PX = [X1 flip(X2) ];
PY = [Y1 flip(Y2) ];
scatter(PX, PY)
plot(PX, PY)


%% Layer 1 --> Drawing
% RHS
shift = pi/2;
r = (sR + (d .* (dtheta))/(2*pi));
X2=160E-3+r.*cos(dtheta+shift);
Y2=r.*sin(dtheta+shift);
% LHS
shift = 0;
r = (sR + (d .* dtheta)/(2*pi));
X1=r.*cos(pi/2 - dtheta+shift);
Y1=r.*sin(pi/2 -dtheta+shift);
PX = [X1 flip(X2) ];
PY = [Y1 flip(Y2) ];
figure('Name', 'Layer 1')
plot(PX, PY)
grid on
%% Layer 2 --> Drawing
% RHS
shift = pi/2;
r = (sR + (d .* (dtheta))/(2*pi));
X2=160E-3+r.*cos(pi - dtheta+shift);
Y2=r.*sin(pi - dtheta+shift);
% LHS
shift = 0;
r = (sR + (d .* dtheta)/(2*pi));
X1=r.*cos(dtheta+shift-pi/2);
Y1=r.*sin(dtheta+shift-pi/2);
PX = [X1 flip(X2) ];
PY = [Y1 flip(Y2) ];
figure('Name', 'Layer 2')
plot(PX, PY)
grid on

%% Layer 3 --> Drawing
% RHS
shift = pi/2;
r = (sR + (d .* (dtheta))/(2*pi));
X2=160E-3+r.*cos(dtheta+shift);
Y2=r.*sin(dtheta+shift);
% LHS
shift = 0;
r = (sR + (d .* dtheta)/(2*pi));
X1=r.*cos(pi/2 - dtheta+shift);
Y1=r.*sin(pi/2 -dtheta+shift);
PX = [X1 flip(X2) ];
PY = [Y1 flip(Y2) ];
figure('Name', 'Layer 3')
plot(PX, PY)
grid on