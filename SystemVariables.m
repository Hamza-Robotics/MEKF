clc;
system_Frequency=10;
Camera_Frequency=1;
timetorevolve=5*60;


%%
global Ts_System Ts_Camera ConstantO timetorevolve bias ComTs
timetorevolve=88*60;
bias=0.1;
Ts_System=1/system_Frequency;
Ts_Camera=1/Camera_Frequency;
ConstantO=2*pi/(timetorevolve);
ComTs=20;