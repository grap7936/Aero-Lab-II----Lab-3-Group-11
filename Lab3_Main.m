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

%% Task 1 -- Plot of NACA 0021 and NACA 2421 using 50 panels
% NACA 0021
m = 0/100;
p = 0/10;
t = 21/100;
% NACA 2421
m2 = 4/100;
p2 = 4/10;
t2 = 15/100;

c = 1;
N = 50;

[x_b, y_b, x_c, y_c] =  NACA_Airfoils(m,p,t,c,N);
[x_b2, y_b2, x_c2, y_c2] =  NACA_Airfoils(m2,p2,t2,c,N);

figure();
subplot(2, 1, 1);
plot(x_b, y_b, "-xb", "LineWidth",1.5)
hold on 
plot(x_c, y_c, "--g", "LineWidth",1.5)
axis equal % implement correcting dimensions so that MATLAB does not stretch the y-axis
xlim([0 c]) % set correct graph dimensions
ylim([-0.2*c 0.2*c])
grid on
xlabel('X - Coordinates');
ylabel('Y - Coordinates');
title("NACA 0012 Airfoil")
legend('Airfoil', 'Camberline')

subplot(2, 1, 2);
plot(x_b2, y_b2, "-xr", "LineWidth",1.5)
hold on;
plot(x_c2, y_c2, "--g", "LineWidth",1.5)
axis equal % implement correcting dimensions so that MATLAB does not stretch the y-axis
xlim([0 c]) % set correct graph dimensions
ylim([-0.2*c 0.2*c])
grid on
xlabel('X - Coordinates');
ylabel('Y - Coordinates');
title("NACA 2421 Airfoil");
legend('Airfoil', 'Camberline')

print('task1', '-dpng', '-r500');

clc
clear

%% Task 2 -- 
% Define test variables:
i = 1;
m = 0/100;
p = 0/10;
t = 21/100;
c = 1;
CL_old = 0;
error = 1.5; 
N_exact = 500;

alpha = 12; % [deg]
v_inf = 50; % [m/s]
Numerical_Plot = 1; % variable to turn on numerical plots for vortex panel method

% Call numerical function to get point distribution
[x_b, y_b] =  NACA_Airfoils(m,p,t,c,N_exact);


% Call vortex panel method code to get output plot
[CL_accurate] = Vortex_Panel(x_b, y_b, v_inf, alpha);
N = 2; 
while error > 1

alpha = 12; % [deg]
v_inf = 50; % [m/s]
Numerical_Plot = 1; % variable to turn on numerical plots for vortex panel method

% Call numerical function to get point distribution
[x_b, y_b] =  NACA_Airfoils(m,p,t,c,N);


% Call vortex panel method code to get output plot
[CL(i)] = Vortex_Panel(x_b, y_b, v_inf, alpha);

% error = abs((CL(i)- CL_accurate)/(CL_accurate)) * 100;
error = abs((CL_accurate- CL(i))/(CL(i))) * 100;
if error > 1
    N = N+1;
    CL_old = CL(i);
    i = i + 1;
end
end
N_vec = 1:length(CL);
disp(['Number of total panels: ', num2str(2*(length(N_vec)))])

figure();
plot(N_vec, CL,"LineWidth",1.5);
xlabel('Number of Panels on Upper and Lower Surface');
ylabel('Sectional Coefficient of Lift');
title('Convergence of CL With Respect To Number of Panels')
grid on 

Results_Table = table( ...
    N_exact, CL_accurate, ...
    N_vec(end), CL(end), error(end), ...
    'VariableNames', {'N_exact', 'CL_exact', 'N_predicted', 'CL_predicted', 'Percent_Error'});
disp(Results_Table)

%% Task 3
% Define test variables:
m = 2/100;
p = 4/10;
t = 12/100;
c = 1;
N_req = N_vec(end);
[alpha_L0, cl] = Thin_Airfoil_Theory(m, p, t, c, N_req, alpha);
