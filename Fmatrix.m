function [phi] = Fmatrix(dt,w)
wx=[0 w(3) -w(2);
   -w(3) 0 w(1);
    w(2) -w(1) 0];

w=norm(w);

phi11=eye(3)+wx*sin(w*dt)/w+wx*wx*(1-cos(w*dt))/w^2;
phi12=-(eye(3)*dt+wx*(1-cos(w*dt))/w^2+wx*wx*(w*dt-sin(w*dt))/w^3);
phi=[phi11 phi12;zeros(3) eye(3)];





end

