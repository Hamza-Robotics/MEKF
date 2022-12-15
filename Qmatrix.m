function [Q] = Qmatrix(dt)
sigu=1;
sigv=100000;


Q=[((sigv^2)*dt+(1/3)*(sigu^2)*dt^3)*eye(3)  -((1/2)*(sigu^2)*dt^2)*eye(3);
((-1/2)*(sigu^2)*dt^2)*eye(3)  ((sigu^2)*dt)*eye(3)];



end

