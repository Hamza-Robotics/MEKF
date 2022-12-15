classdef StarCamera
    %STARCAMERA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access=public)
        IsTurnedOn=1;
    end
    properties (Access=private)
        R
        fov
        Stars
    end
    
    methods
        function obj = StarCamera(R,fov,stars)
            %STARCAMERA Construct an instance of this class
            %   Detailed explanation goes here
            obj.R = R;
            obj.fov = fov;
            obj.Stars = stars;
        end
        
    end

    methods(Access=private)
        function [StarsInView,LocalStars]=ExtractMapInview(obj,Objective_pose)
                StarsInView=nan(3,length(obj.Stars));
                LocalStars=nan(3,length(obj.Stars));

                counter=1;
                camVec=obj.R*[1;0;0];
            for i=1:length(obj.Stars)
                angle=    rad2deg(acos(  dot(camVec,obj.Stars(:,i)) /   (norm(camVec)*norm(obj.Stars(:,i))) ) );
                if angle<(obj.fov/2)
                    StarsInView(:,counter)=(eul2rotm(Objective_pose))*obj.Stars(:,i);
                    a=0.09;
                    noise=([(-a+(a+a)*rand(1));+(-a+(a+a)*rand(1));+(-a+(a+a)*rand(1))]);
                    LocalStars(:,counter)=(obj.R*obj.Stars(:,i))+noise;
                    LocalStars(:,counter)=LocalStars(:,counter)/norm(LocalStars(:,counter));
                    counter=counter+1;
                end            
            end

            LocalStars=LocalStars(:,all(~isnan(LocalStars)));
            StarsInView=StarsInView(:,all(~isnan(StarsInView)));

        end

        function [Stars]=LocalStarsAlignBodyframe(obj,Locls)
                Stars=zeros(3,length(Locls));

                for i =1:length(Locls)

                Stars(:,i)=obj.R'*Locls(:,i);

                end

        end
        
        function [FOV_vector]=FOV_F(obj)
            def=100;
            Fov_=deg2rad(obj.fov);
            FOV_vector=zeros(3,def);
            for i=1:def
                theta=rand*randi([-5 5],1);
                v = obj.R*[1;Fov_*cos(theta);Fov_*sin(theta)];
                FOV_vector(:,i)=v/norm(v);
            end

        end

    
    end
    methods(Access=public)
        function [quaternion]=DevanportQ(obj,objective_pose)
            InertialStars =zeros(3,10);
            LocalStars=zeros(3,10);
            [InertialStars,LocalStars]=ExtractMapInview(obj,objective_pose);
            [LocalStars]=LocalStarsAlignBodyframe(obj,LocalStars);

            r=InertialStars;
            b= LocalStars;
            
            B=zeros(3,3);
            Z=zeros(3,1);
            
            for i=1:length(r)
                
                B=B+(1/length(r))*b(:,i)*r(:,i)';
                Z=Z+(1/length(r))*cross(b(:,i),r(:,i));
            end
            
            S=B+B';
            K=[trace(B) Z';
              Z S-eye(3)*trace(B)];
            
            [V,D]=eig(K,"matrix");
            [d,ind] = sort(diag(D));
            V=V(:,ind);

            quaternion= V(:,end);

        end
        function [output]=Alt_AttitudeDet(obj,objective_pose)
            [LocalStars,InertialStars]=ExtractMapInview(obj,objective_pose);
            [LocalStars_B]=LocalStarsAlignBodyframe(obj,LocalStars);
            quaternion=zeros(4,(length(LocalStars_B)-3));
            for i = 1:(length(LocalStars_B)-3)
                L=[InertialStars(:,i),InertialStars(:,i+1),InertialStars(:,i+3)];
                G=[LocalStars_B(:,i),LocalStars_B(:,i+1),LocalStars_B(:,i+3)];
                
                Rot=inv(G')*L';
                
                quaternion(:,i)=rotm2quat(Rot);
            end
            Q=quaternion(:,all(~isnan(quaternion)));

         M=zeros(4,4);
        for i=1:length(Q)
            M=(1/length(Q))*Q(:,i)*Q(:,i)'+M;
        end
        
        [V,D]=eig(M,"matrix");
        length(Q)
        [d,ind] = sort(diag(D));
        Ds = D(ind,ind);
        
        
        output= V(:,end);
        
        
            end    
        function [InertialStars,LocalStars_B]=debugfunction(obj,objective_pose)

            [LocalStars,InertialStars]=ExtractMapInview(obj,objective_pose);
            
            [LocalStars_B]=LocalStarsAlignBodyframe(obj,LocalStars);    
        end
        function []=line(obj,stringcolor)
            Fov_V=FOV_F(obj);
            hold on
             for i=1:length(Fov_V)
            v1=[Fov_V(1,i),Fov_V(2,i),Fov_V(3,i)];
            v2=[0,0,0];
            v=[v1;v2];
            plot3(v(:,1),v(:,2),v(:,3), stringcolor)
            plot3(v1(:,1),v1(:,2),v1(:,3),'k.')
            end
            hold off
        end
    end
end

