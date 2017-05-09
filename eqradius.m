function [ r_0 ] = eqradius( Planet )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Description: This function defines the equatorial radius of the planet
%   of interest
%   Inputs:
%       planet = string variable of the target planet
%   Outputs
%       r_0 = equatorial radius [km]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select equatorial radius
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch Planet
    case 'Sun'
        r_0 = 696000;
    case 'Mercury'
        r_0 = 2439.7;
    case 'Venus'
        r_0 = 6051.8;
    case 'Earth'
        r_0 = 6373.1363;
    case 'Moon'
        r_0 = 1737.4;
    case 'Mars'
        r_0 = 3396.19;
    case 'Jupiter'
        r_0 = 71492;
    case 'Saturn'
        r_0 = 60268.0;
    case 'Uranus'
        r_0 = 25559;
    case 'Neptune'
        r_0 = 24764;
    case 'Pluto'
        r_0 = 1195;
end

end

