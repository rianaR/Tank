m=5;
g=9.81;
Te=1/1000;
v0=50;

x0=0;
y0=1;
theta0=%pi/6;
v0x=v0*cos(theta0);
v0y=v0*sin(theta0);


X0=[x0;y0;v0x;v0y;theta0];
X=[X0];
Xp=X0;
Xs=Xp;

K=0;

i=1;

while (Xs(2) > 0)
    if (Xp(5) < 0) then
        K=100;
    end
    Xs(1)=0.5*K*cos(Xp(5))*(2*i-1)*Te*Te+v0x*Te+Xp(1);
    Xs(2)=0.5*(-m*g+K*sin(Xp(5)))*(2*i-1)*Te*Te+v0y*Te+Xp(2);
    Xs(3)=K*cos(Xp(5))*Te+Xp(3);
    Xs(4)=(-m*g+K*sin(Xp(5)))*Te+Xp(4);
    Xs(5)=atan(Xs(4)/Xs(3));
    X=[X,Xs];
    Xp=Xs;
    i=i+1;
end

X
x=X(1,:);
y=X(2,:);
plot2d(x,y)

