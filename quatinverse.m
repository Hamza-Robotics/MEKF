function [qinv] = quatinverse(q)


qinv=[q(1),-q(2),-q(3),-q(4)];
qinv=(qinv);
qinv=qinv/(norm(qinv)^2);

end

