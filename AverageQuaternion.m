function [AvQ]=AverageQuaternion(Q)
[rows,cols]=size( Q ) ;
            M=zeros(4,4);
            for i=1:cols
                q=(Q(:,i)/norm(Q(:,i)));
                M=q*q'+M;
            end
            M=(1/length(Q))*M;
            [V,D]=eig(M,"matrix");
            [d,ind] = sort(diag(D));
            V=V(:,ind);
            AvQ=(V(:,end));

            
end