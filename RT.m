clear,clc
load d
[M, N] = size(S);
minvel=.99/(dt*M/dx);
v=minvel:15:2000;nv=length(v);
n0=61;
m0=50;
sh=1;
D = zeros(size(S));
for l=[nv:-1:1,1:nv];
    for m=m0+1:M
        n = round(v(l)*dt*(m-m0)/dx);
        if sh<nv
            n2 = n0-n;if n2<=0;tr(m) =0; else
            tr(m) = S(m,n2);D(m,n2) = 1;end
        else
            n1 = n0+n;if n1>N;tr(m) = 0;else
            tr(m) = S(m,n1);D(m,n1) = 1;end
        end   
    end
    sh=sh+1;
    k(:,sh) = tr;
end

imagesc(k); colormap gray
