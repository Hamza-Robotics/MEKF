function H=y(q)
q1=q(1);
q2=q(2);
q3=q(3);
q4=q(4);



H=[1/q1,    0,    0, -q4/q1^2;
   0, 1/q1,    0, -q3/q1^2;
   0,    0, 1/q1, -q2/q1^2]

end