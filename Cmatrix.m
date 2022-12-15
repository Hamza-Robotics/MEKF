function C = Cmatrix(w, x, y, z)

C = [4*w*x, 2*w^2 + 6*x^2 + 2*y^2 + 2*z^2 - 1,                             4*x*y,                             4*x*z;
     4*w*y,                             4*x*y, 2*w^2 + 2*x^2 + 6*y^2 + 2*z^2 - 1,                             4*y*z;
     4*w*z,                             4*x*z,                             4*y*z, 2*w^2 + 2*x^2 + 2*y^2 + 6*z^2 - 1];
