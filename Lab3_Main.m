%% ASEN 3802 -- Lab 3 -- Aerodynamics Lab

%% Summary: 
% Task 1:  models a 4 digit NACA airfoil both numerically and with an equi-angular representation. 
% Task 2: Uses vortex panel code provided to find the coefficient of lift for different NACA airfoil
% cases. Also, we will analyze where the coefficient of lift converges based on the number of panels
% used, N.
% Task 3: Using thin airfoil theory equations, the effects of airfoil thickness on overall lift will
% be evaluated.

%% Author(s): Graeme Appel, McKenna Coakley, Jake Wzientek, Cullen Watz

%% Last Revised: 4/7/2026




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
CL_old = 0;
error = 1.5; 
N = 1000;

alpha = 12; % [deg]
v_inf = 50; % [m/s]
Numerical_Plot = 1; % variable to turn on numerical plots for vortex panel method

% Call numerical function to get point distribution
[x_b, y_b] =  NACA_Airfoils(m,p,t,c,N);


% Call vortex panel method code to get output plot
[CL_accurate] = Vortex_Panel(x_b, y_b, v_inf, alpha);

N = 5; 
while error > 1 

alpha = 12; % [deg]
v_inf = 50; % [m/s]
Numerical_Plot = 1; % variable to turn on numerical plots for vortex panel method

% Call numerical function to get point distribution
[x_b, y_b] =  NACA_Airfoils(m,p,t,c,N);


% Call vortex panel method code to get output plot
[CL] = Vortex_Panel(x_b, y_b, v_inf, alpha);

error = abs((CL_accurate - CL)/(CL)) * 100;

if error > 1
    N = N+1;
    CL_old = CL;

end
end

figure();
plot(x_b, y_b, "r", "LineWidth",1.5)
axis equal % implement correcting dimensions so that MATLAB does not stretch the y-axis
xlim([0 c]) % set correct graph dimensions
ylim([-0.2*c 0.2*c])
grid on

disp(['Number of total panels: ', num2str(2*N)])


% Define test variables:
m = 2/100;
p = 4/10;
t = 12/100;
c = 1;

[alpha_L0, cl] = Thin_Airfoil_Theory(m, p, t, c, N, alpha);
