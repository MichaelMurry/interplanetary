function [ RIJK, VIJK ] = coe2rv( COE, mu )
% COE2RV.m converts classical orbital elements to mean position and
% velocity vectors
%   Inputs:
%       orb = orbital element structure
%   Outputs:
%      R = [Ri, Rj, Rk] (radius vector)
%      V = [Vi, Vj, Vk] (velocity vector)
%% Initialize

semi = COE.a;
e    = COE.e;
i    = COE.i;
node = COE.RAAN;
arg  = COE.PI-COE.RAAN;
true = COE.v;

%% Compute
p = semi*(1-e^2);  % p = semi-latus rectum

RPQW(1) = p*cos(true) / (1+e*cos(true));
RPQW(2) = p*sin(true) / (1+e*cos(true));
RPQW(3) = 0;

VPQW(1) = -sqrt(mu/p) * sin(true);
VPQW(2) =  sqrt(mu/p) * (e+cos(true));
VPQW(3) =  0;

RIJK = rot3(-node)*rot1(-i)*rot3(-arg)*RPQW';
VIJK = rot3(-node)*rot1(-i)*rot3(-arg)*VPQW';
end

