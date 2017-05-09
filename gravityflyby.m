function [ psi, hp, rp ] = gravityflyby( target_planet, V_inf_in, ...
    V_inf_out )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Description: This function computes the turn angle and altitude of
%   closest approach to target planet given excess velocity in and out of
%   the target planet.
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the gravitational parameter of target planet [km^3/s^2]
mu = gparam(target_planet);

% Define target planet' equitorial radius [km]
r_0 = eqradius(target_planet);

% Compute turn angle [rad]
psi = acos(dot(V_inf_in{1,1}, V_inf_out{1,1})/...
    (norm(V_inf_in{1,1})*norm(V_inf_out{1,1})));

% Compute radius of periapse [km]
rp = mu/norm(V_inf_in{1,1})^2*(1/(cos((pi - psi)/2)) - 1);

% Compute alittude of periapse [km]
hp = rp - r_0;

end

