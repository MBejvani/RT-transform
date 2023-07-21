clear,clc
dt=.004;dx=10;
tmax=2;xmax=1200;f0 = 20;
[w0,~]=ricker(dt,f0);
[w,tw]=ricker(dt,f0/3);
%%
x=0:dx:xmax;
t=0:dt:tmax;
nx = length(x);
nt = length(t);
amat0=zeros(nt,nx);
%% hyperbolas
t0 = linspace(.2,tmax,25);nt0=length(t0);
v = t0.^2*300+800;
for i=1:nt0
    amat0=event_hyp(amat0,t,x,t0(i),xmax/2,v(i),1);
end 
%%
v0=30;
x1=0;
x2=xmax/2;
x3=xmax;
t1=0;
amat=zeros(nt,nx);
%% dipping events
mm=7;
for u=1:mm
    t1a=x2/(v0+u*1.5*mm);aaa = (1.1-1/u)*1/mm/2;
    amat= amat+event_dip(amat,t,x,[t0(1) t1a],[x2-(u-1)*mm x1],aaa)+ ...
        event_dip(amat,t,x,[t0(1) t1a],[x2+u*mm x3],aaa);
end
disp('just about done')
amat0=sectconv(amat0,t,w0,tw);
amat=sectconv(amat,t,w,tw);

S = amat+amat0;
AS = agc(S,.5);
save('d','dt','dx','S')
%%
imagesc(x,t,AS)
axis square