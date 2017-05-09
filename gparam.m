function [ mu ] = gparam( Planet )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: This function provides the gravitational parameter given the
% name of the Planet
% Inputs:
%   Planet = Planet of interest
% Outputs:
%   mu = Gravitational Paramter [km^3/s^2]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select Gravitational Parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch Planet
    case 'Sun'
        mu = 132712440041.94;
    case 'Mercury'
        mu = 22.032e3;
    case 'Venus'
        mu = 324858.606837105;
    case 'Earth'
        mu = 398659.293629478;
    case 'Moon'
        mu = 4.9027779e3;
    case 'Mars'
        mu = 42828.3132893115;
    case 'Jupiter'
        mu = 126686536.751784;
    case 'Saturn'
        mu = 3.7931187e7;
    case 'Uranus'
        mu = 5.793939e6;
    case 'Neptune'
        mu = 6.836529e6;
    case 'Pluto'
        mu = 871;
end

end

