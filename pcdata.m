function [ vinf_out_P1, vinf_in_P2, TOF, C3 ] = ...
    pcdata( DD, AD, P1, P2, statusbar )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: This function calculates C3, excess velocity w.r.t departure
% and arrival planet
% Inputs:
%   DD = Array of Starting Departure date [Julian Date]
%   AD = Array of Ending Arrival date [Julian Date]
%   P1 = Name of departure planet
%   P2 = Name of target planet
% Outputs:
%   v_inf_P1 = Excess velocity w.r.t departure planet
%   v_inf_p2 = Excess velocity w.r.t arrival planet
%        TOF = Time of Flight Days
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute C3 and Excess Velocities
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sun's Gravitational Parameter [km^3/s^2]
mu_S = gparam('Sun');

if statusbar == 1 % Turn on status bar
    
    % Setup waitbar
    h = waitbar(0, 'CHOP CHOP!');
    % Loop through departure and arrival dates and find Lambert's solution
    for j = 1:length(DD)
        waitbar(j/length(DD), h);
        for k = 1:length(AD)
            % Calculate Time of Flight [Day]
            TOF(k,j) = (AD(k) - DD(j));
            
            % Calculate Departure Planet and Target Planet COE
            COE_P1 = ephemerides(DD(j), P1);
            COE_P2 = ephemerides(AD(k), P2);
            
            % Calculate P1 and P2 radius and velocity w.r.t the sun [km]
            [r_P1 v_P1] = coe2rv(COE_P1, mu_S);
            [r_P2 v_P2] = coe2rv(COE_P2, mu_S);
            
            % Calculate Lambert solution for transfer conic [km/s]
            [v_i v_f] = lambertsolver(r_P1, r_P2, TOF(k,j)*24*3600, mu_S);
            
            % Calculate/store vinf [km/s] and C3 [km^2/s^2]
            vinf_out_P1{k,j}(:,1) = v_i - v_P1;
            vinf_in_P2{k,j}(:,1) = v_f - v_P2;
            C3(k,j) = norm(vinf_out_P1{k,j}(:,1))^2;
        end
    end
    delete(h)
    
else % No Status Bar
    
    for j = 1:length(DD)
        for k = 1:length(AD)
            % Calculate Time of Flight [Day]
            TOF(k,j) = (AD(k) - DD(j));
            
            % Calculate Departure Planet and Target Planet COE
            COE_P1 = ephemerides(DD(j), P1);
            COE_P2 = ephemerides(AD(k), P2);
            
            % Calculate P1 and P2 radius and velocity w.r.t the sun [km]
            [r_P1 v_P1] = coe2rv(COE_P1, mu_S);
            [r_P2 v_P2] = coe2rv(COE_P2, mu_S);
            
            % Calculate Lambert solution for transfer conic [km/s]
            [v_i v_f] = lambertsolver(r_P1, r_P2, TOF(k,j)*24*3600, mu_S);
            
            % Calculate/store vinf [km/s] and C3 [km^2/s^2]
            vinf_out_P1{k,j}(:,1) = v_i - v_P1;
            vinf_in_P2{k,j}(:,1) = v_f - v_P2;
            C3(k,j) = norm(vinf_out_P1{k,j}(:,1))^2;
        end
    end
end
end

