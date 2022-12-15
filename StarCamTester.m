clear all;
clc;
map=StarmapGenerator(100000);

C1_R=eul2rotm([0,0,0]);
C2_R=eul2rotm([0,0,pi/2],'XYZ');
C3_R=eul2rotm([0,0,-pi],'XYZ');
C4_R=eul2rotm([0,0,-pi/2],'XYZ');
C5_R=eul2rotm([0,-pi/2,0],'XYZ');
C6_R=eul2rotm([0,pi/2,0],'XYZ');

Cam1=StarCamera(C1_R,70,map);
Cam2=StarCamera(C2_R,70,map);
Cam3=StarCamera(C3_R,70,map);
Cam4=StarCamera(C4_R,70,map);
Cam5=StarCamera(C5_R,70,map);
Cam6=StarCamera(C6_R,70,map);
%%
clc
pose= [rand,rand,rand];
q1=(Cam1.DevanportQ(pose)')';
q2=(Cam2.DevanportQ(pose)')';
q3=(Cam3.DevanportQ(pose)')';
q4=(Cam4.DevanportQ(pose)')';
q5=(Cam5.DevanportQ(pose)')';
q6=(Cam6.DevanportQ(pose)')';

qs=[q1,q2,q3,q4,q5,q6];
AverageQuaternion(qs)'
eul2quat(pose)




%%
Cam1.line("red")
Cam2.line("green")
Cam3.line("blue")
Cam4.line("cyan")
Cam5.line("magenta")
Cam6.line("yellow")
    grid on

    pbaspect([1 1 1])
    l=1.5;
    xlim([-l l])
    ylim([-l l])
    zlim([-l l])
    view(3)

%%


function [Qavg]=avg_quaternion_markley(Q)
% Form the symmetric accumulator matrix
A = zeros(4,4);
M = size(Q,1);
for i=1:M
    q = Q(i,:)';
    if(q(1)<0) % handle the antipodal configuration
		q = -q;
	end
    A = q*q'+A; % rank 1 update
end
% scale
A=(1.0/M)*A;
% Get the eigenvector corresponding to largest eigen value
[Qavg, Eval] = eigs(A,1);
end


function [AvQ]=stupidAverage(q)

standard_q=q(:,1)

for i =1:length(q)
if dot(standard_q,q(:,1))<1/2
    q(:,1)=q(:,1)*-1;
end

q
end
AvQ= mean(q,2)
end


        
function [AvQ]=AvQuat( Q)
    M=zeros(4,4);
    for i=1:length(Q)
        q=flip(Q(:,i)/norm(Q(:,i)));
        M=q*q'+M;
    end
    M=(1/length(Q))*M;
    [V,D]=eigs(M,1);
    AvQ=flip(V);
end






function [Star_Base]=StarmapGenerator(stars)
Star_Base=zeros(3,stars);
for i=1:stars
    v=[rand*randi([-5 5],1);rand*randi([-5 5],1);rand*randi([-5 5],1)];
Star_Base(:,i)=v/norm(v);
end 
end 