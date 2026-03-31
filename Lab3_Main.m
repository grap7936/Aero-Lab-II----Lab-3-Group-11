%% ASEN 3802 -- Lab 3 -- Aerodynamics Lab
%% Summary: We will model a 4 digit NACA airfoil both numerically and with an equi-angular representation and then we will use 







%% Housekeeping
clc
clear
close all

%% Starting Values
NACA = 0021;

% Ensure NACA is treated as a 4-digit code with leading zeros preserved
NACA_string = sprintf('%04d', NACA);

% Calculate the maximum camber 
m = str2double(NACA_string(1)) / 100;

% Calculate the location of maximum camber 
p = str2double(NACA_string(2)) / 10;

% Calculate the thickness ratio 
t = str2double(NACA_string(3:4)) / 100;