%% ASEN 3802 -- Lab 3 -- Aerodynamics Lab

%% Summary: 
% Task 1:  models a 4 digit NACA airfoil both numerically and with an equi-angular representation. 
% Task 2: Uses vortex panel code provided to find the coefficient of lift for different NACA airfoil
% cases. Also, we will analyze where the coefficient of lift converges based on the number of panels
% used, N.
% Task 3: Using thin airfoil theory equations, the effects of airfoil thickness on overall lift will
% be evaluated.

%% Author(s): Graeme Appel, McKenna Coakley, Jake Wzientek, Cullen Watz

%% Last Revised: 3/31/2026




%% Housekeeping
clc
clear
close all

%% Task 1 -- Numerical Representation of NAVA 4 digit airfoil

% Define test variables:
m = 0/100;
p = 0/10;
t = 21/100;
c = 1;
N = 200;

m2 = 4/100;
p2 = 4/10;
t2 = 15/100;

alpha = 12; % [deg]
v_inf = 50; % [m/s]
Numerical_Plot = 1; % variable to turn on numerical plots for vortex panel method

% Call numerical function to get point distribution
[x_b, y_b] =  NACA_Airfoils(m,p,t,c,N);
[x_b2, y_b2] =  NACA_Airfoils(m2,p2,t2,c,N);

figure();
subplot(2, 1, 1);
plot(x_b, y_b, "b.", "LineWidth",1.5)
axis equal % implement correcting dimensions so that MATLAB does not stretch the y-axis
xlim([0 c]) % set correct graph dimensions
ylim([-0.2*c 0.2*c])
grid on
xlabel('X - Coordinates');
ylabel('Y - Coordinates');
title("NACA 0012")

subplot(2, 1, 2);
plot(x_b2, y_b2, "r.", "LineWidth",1.5)
axis equal % implement correcting dimensions so that MATLAB does not stretch the y-axis
xlim([0 c]) % set correct graph dimensions
ylim([-0.2*c 0.2*c])
grid on
xlabel('X - Coordinates');
ylabel('Y - Coordinates');
title("NACA 2421")


% Call vortex panel method code to get output plot
[CL] = Vortex_Panel(x_b, y_b, v_inf, alpha);







