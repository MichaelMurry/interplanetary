clc; close all; clear all; format long g
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Michael Murry
% Date: 12/12/2012
% Description: Generates dates for a viable trajectory to Jupiter
% Notes:
%   Mission Segment 1 = Launch -> VGA
%   Mission Segment 2 = VGA -> EGA1
%   Mission Segment 3 = EGA1 -> MGA
%   Mission Segment 4 = MGA -> EGA2
%   Mission Segment 5 = EGA2 -> JOI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Constraints
C3_max = 20; % [km^2/s^2]
VGA_vinf_tol = .01;   % [km/s]
VGA_hp_min = 300;   % [km]
EGA1_vinf_tol = .01;  % [km/s]
EGA1_hp_min = 300;  % [km]
MGA_vinf_tol = .01;   % [km/s]
MGA_hp_min = 300;   % [km]
EGA2_vinf_tol = .01;  % [km/s]
EGA2_hp_min = 300;  % [km]

%% Event Dates
% Mission Segment 1
LAUNCH_TW_lo = 2460050;
LAUNCH_TW_hi = 2460100;
LAUNCH_TW =  LAUNCH_TW_lo:.5:LAUNCH_TW_hi;
% LAUNCH_TW = 2460083.5;
LAUNCH_TW = 2460091;

VGA_TW_lo = 2460200;
VGA_TW_hi = 2460250;
VGA_TW = VGA_TW_lo:.5:VGA_TW_hi;
% VGA_TW = 2460236.5;
VGA_TW = 2460239;

% Mission Segment 2
EGA1_TW_lo = 2460500;
EGA1_TW_hi = 2460600;
EGA1_TW = EGA1_TW_lo:.5:EGA1_TW_hi;
% EGA1_TW = 2460549.5;
EGA1_TW = 2460553.5;

% Mission Segment 3
MGA_TW_lo = 2460650;
MGA_TW_hi = 2460800;
MGA_TW = MGA_TW_lo:.5:MGA_TW_hi;
% MGA_TW = 2460718.5;
MGA_TW = 2460718.5;

% Mission Segment 4
EGA2_TW_lo = 2461350;
EGA2_TW_hi = 2461400;
EGA2_TW = EGA2_TW_lo:.5:EGA2_TW_hi;
% EGA2_TW = 2461366.5;
EGA2_TW = 2461368.5;

% Mission Segment 5
JOI_TW_lo = 2462450;
JOI_TW_hi = 2462650;
JOI_TW = JOI_TW_lo:.5:JOI_TW_hi;
% JOI_TW = 2462540.5;
JOI_TW = 2462518;
%% Search
count = 1;
track = 1;
h = waitbar(0, 'Searching...');
for ii = 1:length(LAUNCH_TW)
    waitbar(ii/length(LAUNCH_TW), h)
    for jj = 1:length(VGA_TW)
        % Lambert Solvert LAUNCH -> VGA
        [ ~, VGA_vinfin, TOF1, C3 ] = pcdata(LAUNCH_TW(ii), VGA_TW(jj), 'Earth', 'Venus', 0);
        
        % Convert VGA_vinfin into |VGA_vinfin|
        VGA_vinfin_mag = norm(VGA_vinfin{1,1}(:,1));
        
        % Check C3
        if C3 > C3_max
            continue
        end
        
        for kk = 1:length(EGA1_TW)
            % Lambert Solver VGA -> EGA1
            [ VGA_vinfout, EGA1_vinfin, TOF2, ~ ] = pcdata(VGA_TW(jj), EGA1_TW(kk), 'Venus', 'Earth', 0);
            
            % Convert VGA_vinfout and EGA1_vinfout into magnitudes
            VGA_vinfout_mag = norm(VGA_vinfout{1,1}(:,1));
            EGA1_vinfin_mag = norm(EGA1_vinfin{1,1}(:,1));
            
            % Compute VGA hp
            [ ~, VGA_hp, VGA_rp ] = gravityflyby('Venus', VGA_vinfin, VGA_vinfout);
            
            % Compute difference in VGA |vinf|
            VGA_dvinf = abs(VGA_vinfout_mag - VGA_vinfin_mag);
            
            % Check VGA |vinf| and hp
            if VGA_dvinf > VGA_vinf_tol || VGA_hp < VGA_hp_min
                continue
            end
            
            for mm = 1:length(MGA_TW)
                % Lambert Solver EGA1 -> MGA
                [ EGA1_vinfout, MGA_vinfin, TOF3, ~ ] = pcdata(EGA1_TW(kk), MGA_TW(mm), 'Earth', 'Mars', 0);
                
                % Convert EGA1_vinfout and MGA_vinfout into magnitudes
                EGA1_vinfout_mag = norm(EGA1_vinfout{1,1}(:,1));
                MGA_vinfin_mag = norm(MGA_vinfin{1,1}(:,1));
                
                % Compute EGA1 hp
                [ ~, EGA1_hp, EGA1_rp ] = gravityflyby('Earth', EGA1_vinfin, EGA1_vinfout);
                
                % Compute difference ein EGA1 |vinf|
                EGA1_dvinf = abs(EGA1_vinfout_mag - EGA1_vinfin_mag);
                
                % Check EGA1 |vinf| and hp
                if EGA1_dvinf > EGA1_vinf_tol || EGA1_hp < EGA1_hp_min
                    continue
                end
                
                for nn = 1:length(EGA2_TW)
                    % Lambert Solver MGA -> EGA2
                    [ MGA_vinfout, EGA2_vinfin, TOF4, ~ ] = pcdata(MGA_TW(mm), EGA2_TW(nn), 'Mars', 'Earth', 0);
                    
                    % Convert MGA_vinfout and EGA2_vinfin into magnitudes
                    MGA_vinfout_mag = norm(MGA_vinfout{1,1}(:,1));
                    EGA2_vinfin_mag = norm(EGA2_vinfin{1,1}(:,1));
                    
                    % Compute MGA hp
                    [ ~, MGA_hp, MGA_rp ] = gravityflyby('Mars', MGA_vinfin, MGA_vinfout);
                    
                    % Compute difference in MGA |vinf|
                    MGA_dvinf = abs(MGA_vinfout_mag - MGA_vinfin_mag);
                    
                    % Check MGA |vinf| and hp
                    if MGA_dvinf > MGA_vinf_tol || MGA_hp < MGA_hp_min
                        continue
                    end
                    
                    for pp = 1:length(JOI_TW)
                        % Lambert Solver EGA2 -> JOI
                        [ EGA2_vinfout, JOI_vinfin, TOF5, ~ ] = pcdata(EGA2_TW(nn), JOI_TW(pp), 'Earth', 'Jupiter', 0);
                        
                        % Convert EGA2_vinfout and JOI_vinfin into magnitudes
                        EGA2_vinfout_mag = norm(EGA2_vinfout{1,1}(:,1));
                        JOI_vinfin_mag = norm(JOI_vinfin{1,1}(:,1));
                        
                        % Compute EGA2 hp
                        [ ~, EGA2_hp, EGA2_rp ] = gravityflyby('Earth', EGA2_vinfin, EGA2_vinfout);
                        
                        % Compute difference in EGA2 |vinf|
                        EGA2_dvinf = abs(EGA2_vinfout_mag - EGA2_vinfin_mag);
                        
                        % Check MGA |vinf| and hp
                        if EGA2_dvinf > EGA2_vinf_tol || EGA2_hp < EGA2_hp_min
                            continue
                        end
                        
                        TOF = TOF1 + TOF2 + TOF3 + TOF4 + TOF5;
                        
                        Missions(count, :) = ...
                            [LAUNCH_TW(ii) VGA_TW(jj) EGA1_TW(kk) MGA_TW(mm) EGA2_TW(nn) JOI_TW(pp), 0 ...
                            C3 VGA_vinfin_mag VGA_vinfout_mag EGA1_vinfin_mag EGA1_vinfout_mag MGA_vinfin_mag MGA_vinfout_mag EGA2_vinfin_mag EGA2_vinfout_mag JOI_vinfin_mag 0 ...
                            VGA_hp EGA1_hp MGA_hp EGA2_hp 0 TOF/(365)];
                        count = count + 1;
                    end
                    
                    
                end
            end
        end
    end
end
delete(h)


