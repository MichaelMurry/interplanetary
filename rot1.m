function [ T ] = rot1( a )
%ROTx.m Computes the rotation matrix about the x axis
%   Inputs:
%       a = angle [rad]
%   Output:
%       T = rotation matrix [rad]

T = [ 1 0 0;
    0 cos(a) sin(a);
    0 -sin(a) cos(a)];

end