function [RegistrationParameters]=Powell(handles)
e=0.1;
X0=[0 0 0];
D=[1 0 0;0 1 0;0 0 1];
num=0;
while(num<200)
    num=num+1;
    d1=D(1,:);%d1为矩阵D的第一行，初始搜索方向
    [X1,fX1]=OneDimSearch(X0,d1,handles);
    d2=D(2,:);%d2为矩阵D的第二行，初始搜索方向
    [X2,fX2]=OneDimSearch(X1,d2,handles);
    d3=D(3,:);%d3为矩阵D的第三行，初始搜索方向，三维搜索故有三个方向
    [X3,fX3]=OneDimSearch(X2,d3,handles);
    fX0=PV(X0(1),X0(2),-X0(3),handles);
    Diff=[fX1-fX0 fX2-fX1 fX3-fX2];
    [maxDiff,m]=max(Diff);%max函数的用法，返回maxdiff为向量Diff的最大元素，m为最大元素的序号
    d4=X3-X0;
    temp1=X3-X0;
    Conditon1=sum(temp1.*temp1);
    if Conditon1<=e
        break
    end
    [X4,fX4,landa]=OneDimSearch(X0,d4,handles);
    X0=X4;
    temp2=X4-X3;
    Conditon2=sum(temp2.*temp2);
    if Conditon2<=e
        X3=X4;
        break
    end
    temp3=sqrt((fX4-fX0)/(maxDiff+eps));
    if(abs(landa)>temp3)
        D(4,:)=d4;
        for i=m:3
            D(i,:)=D(i+1,:);
        end
    end
end
RegistrationParameters(1)=-X3(1);
RegistrationParameters(2)=-X3(2);
RegistrationParameters(3)=-X3(3);
RegistrationParameters(4)=fX3;


function [Y,fY,landa]=OneDimSearch(X,direction,handles)
%在一维的方向上采用的是0.618法
%a,b为搜索区间的两个端点，e为允许的误差
a=-5;
b=5;
e=0.0001;
c=a+0.382*(b-a);
d=a+0.618*(b-a);
Fc=Fx(c,X,direction,handles);
Fd=Fx(d,X,direction,handles);
while(b-a>=e)
    if Fc>Fd
        Fc=Fd;
        a=c;
        c=d;
        d=a+0.618*(b-a);
        Fd=Fx(d,X,direction,handles);
    else
        Fd=Fc;
        b=d;
        d=c;
        c=a+0.382*(b-a);
        Fc=Fx(c,X,direction,handles);
    end
end
Y=X+((b+a)/2)*direction;
landa=(b+a)/2;
fY=-Fx(landa,X,direction,handles);

function [fx]=Fx(x,X,direction,handles)
fx=-PV(X(1)+direction(1)*x,X(2)+direction(2)*x,-(X(3)+direction(3)*x),handles);






    
    
