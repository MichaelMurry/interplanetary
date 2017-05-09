function BParams = bplane2( target_planet, v_inf_in, ...
    v_inf_out )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Description: This function computes the B-Plane paramters given excess
%   velocity entering and leaving a planet. The function also computes the
%   turn angle, altitude and radius of periapse
%   Inputs:
%       target_planet = string variable of the target planet
%       V_inf_in = excess velocity into the target planet [km/s^2]
%       V_inf_out = excess velocity out of the target planet [km/s^2]
%       Planet
%   Outputs
%       rp = radius of peraispse [km]
%       hp = altitude of periaspse [km]
%       psi = turn angle [rad]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
% Define the gravitational parameter of target planet [km^3/s^2]
mu = gparam(target_planet);

% Calculate v_inf_in unit vector S
BParams.S_hat = (v_inf_in/norm(v_inf_in))';

% Calculate the unit vector h
BParams.h_hat = cross(v_inf_in, v_inf_out)/...
    (norm(cross(v_inf_in, v_inf_out)));

% Calcululate the unit vector B
BParams.B_hat = cross(BParams.S_hat, BParams.h_hat);

% Define unit vector in the z-direction of the ecliptic coordinate system
BParams.k_hat = [0 0 1];

% Calculate vector T that is normal to ecliptic plane normal and B-plane
BParams.T_hat = cross(BParams.S_hat, BParams.k_hat)/ ...
    norm(cross(BParams.S_hat, BParams.k_hat));

% Calculate turn angle [rad]
BParams.psi = acos(dot(v_inf_in, v_inf_out)/...
    (norm(v_inf_in)*norm(v_inf_out)));

% Calculate the unit vector R
BParams.R_hat = cross(BParams.S_hat, BParams.T_hat);

% Calculate radius of periapse
BParams.rp = mu/norm(v_inf_in)^2*(1/(cos((pi-BParams.psi)/2)) - 1);

% Calculate B-plane magnitude
BParams.B_mag = mu/norm(v_inf_in)^2*...
    sqrt((1+norm(v_inf_in)^2*BParams.rp/mu)^2-1);

% Calculate the angle between T and B
if dot(BParams.B_hat, BParams.R_hat) < 0
    BParams.theta = 2*pi - acos(dot(BParams.T_hat,BParams.B_hat));
else
    BParams.theta = acos(dot(BParams.T_hat, BParams.B_hat));
end

% Calculate B vector
BParams.B_vec = BParams.B_mag*BParams.B_hat;

% Calculate BT
BParams.BT = dot(BParams.B_vec, BParams.T_hat);

% Calculate BR
BParams.BR = dot(BParams.B_vec, BParams.R_hat);

% Define target planet' equitorial radius [km]
BParams.r_0 = eqradius(target_planet);

% Compute alittude of periapse
BParams.hp = BParams.rp - BParams.r_0;

end

