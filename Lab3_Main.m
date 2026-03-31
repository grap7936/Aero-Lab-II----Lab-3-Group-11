%% ASEN 3802 -- Lab 3 -- Aerodynamics Lab
%% Summary: We will model a 4 digit NACA airfoil both numerically and with an equi-angular representation and then we will use 







%% Housekeeping
clc
clear
close all

%% Task 1 -- Numerical Representation of NAVA 4 digit airfoil

% Define test variables:
m = 4/100;
p = 4/10;
t = 15/100;
c = 100;
N = 50;

alpha = 3; % [deg]
v_inf = 50; % [m/s]
Numerical_Plot = 1; % variable to turn on numerical plots for vortex panel method

% % Call numerical function to get point distribution
 [x_b,y_b] =  NACA_Airfoils(m,p,t,c,N);
% 
% figure();
% plot(x_b, y_b, "r", "LineWidth",1.5)

% % Call vortex panel method code to get output plot
% [CL,CP,CIRC,X,Y] = Vortex_Panel_2(x_b,y_b,v_inf,alpha,Numerical_Plot);
