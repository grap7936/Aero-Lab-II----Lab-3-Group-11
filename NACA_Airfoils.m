

function [x_b,y_b] =  NACA_Airfoils(m,p,t,c,N)

% Goal/Purpose: Modeling a 4 digit NACA airfoil representation numerically by converting 4 digit
% inputs into relevant variables and finding discrete x and y coordinates for the top and bottom of
% the airfoil using numerically derived equations

% Inputs:
% 1.) m = max airfoil camber. This is the 1st digit (leftmost) of the 4 digit NACA airfoil
% representation and represents the max camber of the chord in percentage of the chord.
% 2.) p = location of max camber. This is the 2nd digit from the left of the 4 digit NACA airfoil
% representation and represents the location of the max camber (measured from the leading edge) in
% 1/10 of the chord.
% 3.) t = max airfoil thickness. This is the last 2 digits of the 4 digit NACA airfoil
% representation and represents the maximum thickness of the airfoil in percent of the chord.
% 4.) c = total chord length of the airfoil
% 5.) N= # of employed panels for vortex panel method over each surface

% Outputs: 
% 1.) x_b = vector containing the x-location of all airfoil boundary points
% 2.) y_b = vector containing the y-location of all airfoil boundary points




%% Define Thickness Distribution of Airfoil



%% Define Camber Line Distribution




%% Define zeta using derivative of piecewise function of camber line distribution




%% Define X and Y locations over the upper and lower surfaces

x_u = x - y_t*sin(zeta); % x-coordinates over the upper surface
x_L = x + y_t*sin(zeta); % x-coordinates over the lower surface

y_u = y_c + y_t*sin(zeta); % y-coordinates over the upper surface
y_L = y_c - y_t*sin(zeta); % y-coordinates over the lower surface





end
