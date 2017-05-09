function [ T ] = rot2( a )
%ROTY.m Computes the rotation matrix about the Y axis
%   Inputs:
%       a = angle [rad]
%   Output:
%       T = rotation matrix [rad]

T = [ cos(a) 0 -sin(a);
      0 1 0;
      sin(a) 0 cos(a)];
  
end