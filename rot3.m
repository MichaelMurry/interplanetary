function [ T ] = rot3( a )
%ROTZ.m Computes the rotation matrix about the Z axis
%   Inputs:
%       a = angle [rad]
%   Output:
%       T = rotation matrix [rad]

T = [ cos(a) sin(a) 0;
      -sin(a) cos(a) 0;
      0 0 1];
  
end

