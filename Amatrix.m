function [A] = Amatrix(wx, wy, wz,Ts)
%AMATRIX Summary of this function goes here
%   Detailed explanation goes here


wx = wx ;
wy = wy ;
wz = wz ;

W = [0, -wx, -wy, -wz;
     wx, 0, wz, -wy;
     wy, -wz, 0, wx;
     wz, wy, -wx, 0];

A = 1/2*W;

A = (eye(4)+A*Ts);

end

