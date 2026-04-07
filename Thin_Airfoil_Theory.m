
function [alpha_L0, cl] = Thin_Airfoil_Theory(m, p, t, c, N_ideal, alpha)

% Goal/Purpose: Find zero lift angle of attack using thin airfoil theory and computing equation 4.61
% in anderson. Note that we already have dz/dx from previous derivation input piecewise into our
% NACA_Airfoils function. Then, simply solve for theta from the equation: x = (c/2)(1-cos(theta))
% and plug this in for theta and numerically integrate.

% Inputs: 
% 2.) m = max airfoil camber. This is the 1st digit (leftmost) of the 4 digit NACA airfoil
% representation and represents the max camber of the chord in percentage of the chord.
% 3.) p = location of max camber. This is the 2nd digit from the left of the 4 digit NACA airfoil
% representation and represents the location of the max camber (measured from the leading edge) in
% 3.) t = max airfoil thickness. This is the last 2 digits of the 4 digit NACA airfoil
% representation and represents the maximum thickness of the airfoil in percent of the chord.
% 4.) c = chord length of given airfoil configuration
% 1/10 of the chord.
% 4.) N_ideal = ideal number of vortex panels to get within 1% error
% 5.) alpha = arbitrary input angle of attack value(s) in vector form 

% Outputs:
% 1.) alpha_L0 = zero lift angle of attack using thin airfoil theory



%% Define Thickness Distribution of Airfoil

for i = 1:N_ideal+1 

    theta_i = (i-1)*pi/N_ideal;             % goes from 0 to pi

    x(i) = c/2 + c/2 * cos(theta_i); % x: c → 0

end

% y_t = ((t * c)/0.2) * ((0.2969 .* sqrt(x./c)) -  (0.1260*(x./c)) - (0.3516 .* (x./c).^2) + (0.2843 .* (x./c).^3) - (0.1036 .* (x./c).^4)); % numerical equation

%% Define theta_0 in terms of x using chord line equation:

theta_0 =  acos( (1 - x.*(2/c)) );


%% Define dz/dx for each part of the piecewise function bounds w.r.t length x


for i = 1:length(x)
    if m == 0 || p == 0 % for if there are any symmetric airfoil components

      dz_dx(i) = 0;

    elseif x(i) >= 0 && x(i) < p*c  % 1st part of piecewise function

    dz_dx(i) = ((2*m)/p) - ((2*m)/(c*p^2))*x(i); % derivative of camber line distribution


    elseif x(i) >= p*c && x(i) <= c

    dz_dx(i) = (2*p*m)/(1-p)^2 -((2*m)/(c*(1-p)^2))*x(i); % derivative of camber line distribution

    else

    disp('Wrong x-value');

    end
end


%% Define zero lift angle of attack with equation 4.61 and numerically integrate

integrand = dz_dx.*(cos(theta_0) - 1);


alpha_L0 = (-1/pi)*cumtrapz(integrand); % computing alpha_L0 in [rad]

% loop through for a range of changing alpha values 
% Note: currently, the length of alpha as well as the length of x defined above in line 32 must be
% the same and I think this is wrong.
for i = 1:length(alpha) 

cl(i) = (2*pi)*(alpha(i) - alpha_L0(i)); % compute sectional lift coefficient with given alpha value

end

% recall that lift slope for each case is a = 2*pi


end