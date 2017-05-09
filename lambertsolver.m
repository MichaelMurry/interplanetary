function [ vo, vf ] = lambertsolver( ro, rf, dto, mu )
%lambertsolver.m Solves Lambert's Problem through Universal Variables
%Formulation. This is solver is intended for our solar system only
%   Inputs:
%        ro = initial position vector w.r.t the Sun
%        rf = final position vector w.r.t the Sun
%       dto = desired transfer time
%         m = gravitational parameter [km^3/s^2]
%   Outputs:
%        vo = Transfer ellipse initial velocity vector w.r.t the sun
%        vf = Transfer ellipse final velocity vector w.r.t the sun

%% Initialize

% If TOF = 0, stop computing
if dto == 0
    vo = Inf;
    vf = Inf;
    return
end

% Calculate delta nu
nu1 = atan2(ro(2), ro(1));
nu2 = atan2(rf(2), rf(1));
dnu = nu2 - nu1;
if dnu < 0
    dnu = dnu + 2*pi;
end

% Determine trajectory type
if dnu < pi
    DM = 1;
else
    DM = -1;
end

% Calculate variable A
A = DM*sqrt(norm(ro)*norm(rf)*(1 + cos(dnu)));

% Break statement for trajectoresi parallel to Earth
if dnu == 0 && A == 0
    display('Trajectory can not be computed')
end

% Pick initial psi values
psi = 0;
c2 = 1/2;
c3 = 1/6;

% Define upper and lower range
psi_hi = 4*pi^2;
psi_lo = -4*pi;

% Define starting time
dt = 0;

%% Compute
timer = 1;
while abs(dt-dto) > 10^-6
    
    y = norm(ro) + norm(rf) + A*(psi*c3 - 1)/sqrt(c2);
    
    if (A > 0)&&(y < 0)
        count = 1;
        while (count < 100)&&(y < 0)
            psi = 0.8*(1.0/c3)*( 1.0 - (norm(ro) + norm(rf))*sqrt(c2)/A);
            
            if (psi > 1e-6)
                
                c2 = (1-cos(sqrt(psi)))/psi;
                c3 = (sqrt(psi)-sin(sqrt(psi)))/sqrt(psi^3);
                
            elseif (psi < -1e-6)
                
                c2 = (1 - cosh(sqrt(-psi)))/psi;
                c3 = (sinh(sqrt(-psi)) - sqrt(-psi))/sqrt((-psi)^3);
            else
                c2 = 0.5;
                c3 = 1/6;
            end
            
            if abs(c2) > 1e-7
                y = norm(ro)+norm(rf)+A*(psi*c3-1)/sqrt(c2);
            else
                y = ro + rf;
            end
            
            count = count + 1;
        end
    end
    
    chi = sqrt(y/c2);
    dt = (chi^3*c3 + A*sqrt(y))/sqrt(mu);
    
    if dt <= dto
        psi_lo = psi;
    else
        psi_hi = psi;
    end
    
    psi = (psi_hi + psi_lo)/2;
    
    if psi > 10^-6
        c2 = (1 - cos(sqrt(psi)))/psi;
        c3 = (sqrt(psi) - sin(sqrt(psi)))/sqrt(psi^3);
    else if (psi < -10^-6)
            c2 = (1 - cosh(sqrt(-psi)))/psi;
            c3 = (sinh(sqrt(-psi)) - sqrt(-psi))/(sqrt(-psi^3));
        else
            c2 = 1/2;
            c3 = 1/6;
        end
    end
    
    if timer > 1000
        disp('WARNING: Too many iterations - While loop terminated')
        break
    end
    
    timer = timer + 1;
end

if timer > 1000
    vo = Inf;
    vf = Inf;
    return
end

f = 1 - y/norm(ro);
gdot = 1 - y/norm(rf);
g = A*sqrt(y/mu);

%% Output
vo = (rf - f*ro)/g;
vf = (gdot*rf - ro)/g;

end
