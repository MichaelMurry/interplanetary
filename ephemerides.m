function [ COE ] = ephemerides( JD, planet )
%ephemerides.m - Computes planetary ephemerides
%   Inputs:
%       JD = Juilian Date
%       planet = Selects which empherides data to use
%   Outputs:
%       COE.L = mean longitude of the planet [rad]
%       COE.a = semimjaor axis of the orbit [km]
%       COE.e = eccentricity of the orbit
%       COE.i = inclination of the orbit [rad]
%       COE.RAAN = longitude of the ascending node [rad]
%       COE.PI = longitude of the perihelion [rad]

%% Initialize
AU = 1.49597870691e8;

switch planet
    case 'Venus'
        L.a0 = 181.979801;
        L.a1 = 58517.8156760;
        L.a2 = 0.00000165;
        L.a3 = -0.000000002;
        
        a.a0 = 0.72332982;
        a.a1 = 0;
        a.a2 = 0;
        a.a3 = 0;
        
        e.a0 = 0.00677188;
        e.a1 = -0.000047766;
        e.a2 = 0.0000000975;
        e.a3 = 0.00000000044;
        
        i.a0 = 3.394662;
        i.a1 = -0.0008568;
        i.a2 = -0.00003244;
        i.a3 = 0.000000010;
        
        RAAN.a0 = 76.679920;
        RAAN.a1 = -0.2780080;
        RAAN.a2 = -0.00014256;
        RAAN.a3 = -0.000000198;
        
        PI.a0 = 131.563707;
        PI.a1 = 0.0048646;
        PI.a2 = -0.00138232;
        PI.a3 = -0.000005332;
        
    case 'Earth'
        L.a0 = 100.466449;
        L.a1 = 35999.3728519;
        L.a2 = -0.00000568;
        L.a3 = 0;
        
        a.a0 = 1.000001018;
        a.a1 = 0;
        a.a2 = 0;
        a.a3 = 0;
        
        e.a0 = 0.01670862;
        e.a1 = -0.000042037;
        e.a2 = -0.0000001236;
        e.a3 = 0.00000000004;
        
        i.a0 = 0;
        i.a1 = 0.0130546;
        i.a2 = -0.00000931;
        i.a3 = -0.00000034;
        
        RAAN.a0 = 174.873174;
        RAAN.a1 = -0.2410908;
        RAAN.a2 = 0.00004067;
        RAAN.a3 = -0.000001327;
        
        PI.a0 = 102.937348;
        PI.a1 = 0.3225557;
        PI.a2 = 0.00015026;
        PI.a3 = 0.000000478;
        
    case 'Mars'
        L.a0 = 355.433275;
        L.a1 = 19140.2993313;
        L.a2 = 0.00000261;
        L.a3 = -0.000000003;
        
        a.a0 = 1.523679342;
        a.a1 = 0;
        a.a2 = 0;
        a.a3 = 0;
        
        e.a0 = 0.09340062;
        e.a1 = 0.000090483;
        e.a2 = -0.0000000806;
        e.a3 = -0.00000000035;
        
        i.a0 = 1.849726;
        i.a1 = -0.0081479;
        i.a2 = -0.00002255;
        i.a3 = -0.000000027;
        
        RAAN.a0 = 49.558093;
        RAAN.a1 = -0.2949846;
        RAAN.a2 = -0.00063993;
        RAAN.a3 = -0.000002143;
        
        PI.a0 = 336.060234;
        PI.a1 = 0.4438898;
        PI.a2 = -0.00017321;
        PI.a3 = 0.000000300;
        
    case 'Jupiter'
        L.a0 = 34.351484;
        L.a1 = 3034.9056746;
        L.a2 = -0.00008501;
        L.a3 = 0.000000004;
        
        a.a0 = 5.202603191;
        a.a1 = 0.0000001913;
        a.a2 = 0;
        a.a3 = 0;
        
        e.a0 = 0.04849485;
        e.a1 = 0.000163244;
        e.a2 = -0.0000004719;
        e.a3 = -0.00000000197;
        
        i.a0 = 1.303270;
        i.a1 = -0.0019872;
        i.a2 = 0.00003318;
        i.a3 = 0.000000092;
        
        RAAN.a0 = 100.464441;
        RAAN.a1 = 0.1766828;
        RAAN.a2 = 0.00090387;
        RAAN.a3 = -0.000007032;
        
        PI.a0 = 14.331309;
        PI.a1 = 0.2155525;
        PI.a2 = 0.00072252;
        PI.a3 = -0.000004590;
        
    case 'Saturn'
        L.a0 = 50.077471;
        L.a1 = 1222.1137943;
        L.a2 = 0.00021004;
        L.a3 = -0.000000019;
        
        a.a0 = 9.554909596;
        a.a1 = -0.0000021389;
        a.a2 = 0;
        a.a3 = 0;
        
        e.a0 = 0.05550862;
        e.a1 = -0.000346818;
        e.a2 = -0.0000006456;
        e.a3 = 0.00000000338;
        
        i.a0 = 2.488878;
        i.a1 = 0.0025515;
        i.a2 = -0.00004903;
        i.a3 = 0.000000018;
        
        RAAN.a0 = 113.665524;
        RAAN.a1 = -0.2566649;
        RAAN.a2 = -0.00018345;
        RAAN.a3 = 0.000000357;
        
        PI.a0 = 93.056787;
        PI.a1 = 0.5665496;
        PI.a2 = 0.00052809;
        PI.a3 = 0.000004882;
        
    case 'Pluto'
        L.a0 = 238.92903833;
        L.a1 = 145.20780515;
        L.a2 = 0;
        L.a3 = 0;
        
        a.a0 = 39.48211675;
        a.a1 = -0.00031596;
        a.a2 = 0;
        a.a3 = 0;
        
        e.a0 = 0.24882730;
        e.a1 = 0.00005170;
        e.a2 = 0;
        e.a3 = 0;
        
        i.a0 = 17.14001206;
        i.a1 = 0.00004818;
        i.a2 = 0;
        i.a3 = 0;
        
        RAAN.a0 = 110.30393684;
        RAAN.a1 = -0.01183482;
        RAAN.a2 = 0;
        RAAN.a3 = 0;
        
        PI.a0 = 224.06891629;
        PI.a1 = -0.04062942;
        PI.a2 = 0;
        PI.a3 = 0;
end
%% Compute
T = (JD - 2451545)/36525;

% mean longitude of the planet
COE.L = (L.a0 + L.a1*T + L.a2*T^2 + L.a3*T^3)*pi/180;

% semimajor axis of the orbit
COE.a = (a.a0 + a.a1*T + a.a2*T^2 + a.a3*T^3)*AU;

% eccentricity of the orbit
COE.e = e.a0 + e.a1*T + e.a2*T^2 + e.a3*T^3;

% inclination of the orbit
COE.i = (i.a0 + i.a1*T + i.a2*T^2 + i.a3*T^3)*pi/180;

% longitude of the ascending node
COE.RAAN = (RAAN.a0 + RAAN.a1*T + RAAN.a2*T^2 + RAAN.a3*T^3)*pi/180;

% longitude of the perihelion
COE.PI = (PI.a0 + PI.a1*T + PI.a2*T^2 + PI.a3*T^3)*pi/180;

% mean anomaly of the orbit
COE.M = COE.L - COE.PI;

C_cen = (2*COE.e - COE.e^3/4 + 5/96*COE.e^5)*sin(COE.M)...
    + (5/4*COE.e^2 - 11/24*COE.e^4)*sin(2*COE.M)...
    + (13/12*COE.e^3 - 43/64*COE.e^5)*sin(3*COE.M)...
    + 103/96*COE.e^4*sin(4*COE.M)...
    + 1097/960*COE.e^5*sin(5*COE.M);

% true anomaly of the planet
COE.v = COE.M + C_cen;

end

