function product = quadprod(q1,q2)

product = [q1(1)*q2(1) - q1(2)*q2(2) - q1(3)*q2(3) - q1(4)*q2(4);
           q1(1)*q2(2) + q2(1)*q1(2) + q1(3)*q2(4) - q2(3)*q1(4);
           q1(1)*q2(3) + q2(1)*q1(3) - q1(2)*q2(4) + q2(2)*q1(4);
           q1(1)*q2(4) + q2(1)*q1(4) + q1(2)*q2(3) - q2(2)*q1(3)];
