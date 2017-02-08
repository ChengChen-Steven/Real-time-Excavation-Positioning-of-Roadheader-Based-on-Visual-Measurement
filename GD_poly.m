%%1.按照拍摄结果，直接作图；
%这里RealValue就相当于我原本激光发射器本身的形心点，但事实上，激光发射器本身形心点的坐标是无意义的，有意义的是其对应多项式的系数矩阵；
clf;
RealValue=[1000,600,400,600,1000;500,1000,1500,2000,2500];
RVM=[RealValue(2,:)/1000;RealValue(1,:)/100];%M=modified
N=5;
%pr means plot real
pr=polyfit(RVM(1,:),RVM(2,:),N-1);%用N-1操作的话，是完美的符合原值；
%下面仅是画图；
format long
xrv=0:0.001:3;
yrv=polyval(pr,xrv);
xr=1000*xrv;
yr=100*yrv;
plot(xr,yr,'--k')
axis([0,3000,0,2000]);
set(gca,'ydir','reverse');

pause(5)

%现在处理对于之前的结果
%先用V4的结果；C=calculated
C=[1000.654013015184, 600.970026064292, 401.013927576602, 600.970026064292, 1000.986291614741; ...
   500.977404193782, 1000.981320590790, 1501.008077994429, 2000.981320590791, 2500.667438134236];
CM=[C(2,:)/1000;C(1,:)/100];%M=modify
N=5;
%pr means plot real
pc=polyfit(CM(1,:),CM(2,:),N-1);%用N-1操作的话，是完美的符合原值；、
%下面仅是画图；
format long
xcv=0:0.001:3;
ycv=polyval(pc,xcv);
xc=1000*xcv;
yc=100*ycv;
plot(xc,yc,'-b');
hold on
plot(xr,yr,'--k');
axis([0,3000,0,2000]);
set(gca,'ydir','reverse');

pause(5)


%%之后核心思想??所有的值满足MECE原则（卧槽这里可以装个逼），全部化标（所有全部划归到）；

%%2.左右关系的平移实现；
%pr认为激光发射点是理想的情形（正如本例原来已知的形心是非常对称的点），也就是这里平移使对称轴位于y轴后的式子，x奇数项的系数为0；
%但有一个逻辑关系要清楚，就是实际情况的激光发射点也不是完全理想的，也是要实测的。本例稍微理想化了；
t=(N-1)/2;
dpr=polyder(pr);
rpr=roots(dpr);
xr0=rpr(t)
dRVM=RVM(1,:)-xr0;%采用第一种方法，将x修改后，重新运算得系数；
dpr=polyfit(dRVM,RVM(2,:),N-1)
RealValue(2,:)=RealValue(2,:)-1000*xr0;%将RealValue矩阵改变为平移后的矩阵；
%曲线的顶点[xr0,dpr(N)];注意，这里dpr(N)=4,即，少乘了100的倍数；
%现在平移xr0个单位即为dpr啊！

dpc=polyder(pc);
rpc=roots(dpc);
xc0=rpc(t)
dCM=CM(1,:)-xc0;%采用第一种方法，将x修改后，重新运算得系数；
dpc=polyfit(dCM,CM(2,:),N-1)
C(2,:)=C(2,:)-1000*xc0;%将C矩阵改变为平移后的矩阵；
%%曲线的顶点[xc0,dpc(N)];注意，这里dpr(N)=4.01,即，少乘了100的倍数；
%现在平移xc0个单位即为dpc啊！


%%3.远近问题的缩放实现；
%GD_zoom;
%zoom begins;
t=(N-1)/2;
zoom_x=zeros(t,1);
zoom_y=zeros(2,1);
for i=1:t
    zoom_x(i)=(C(2,N-i+1)-C(2,i))/(RealValue(2,N-i+1)-RealValue(2,i));
end
Xzoom=1/mean(zoom_x);
zoom_y(1)=(C(1,1)-C(1,t+1))/(RealValue(1,1)-RealValue(1,t+1));
zoom_y(2)=(C(1,N)-C(1,t+1))/(RealValue(1,N)-RealValue(1,t+1));
Yzoom=1/mean(zoom_y);

C(1,:)=C(1,:)*Yzoom;%C(1,:)是缩放后的纵坐标值；
C(2,:)=C(2,:)*Xzoom;%C(2,:)是缩放后的横坐标值；

xr0=xr0;%引入缩放后的标准图的平移距离；
xc0=xc0*Xzoom;%引入缩放后的实测图的平移距离；

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%缺一个远近距离的位置转化关系（缩放情况与距离比例的反映）；

%%4.上下问题的对应实现；
yr0=dpr(1,N)
yc0=dpc(1,N)*Yzoom



%%4.5再次呈现经变换后的图形；（还没画完，函数怎么变换要想清楚%%%%%%%%%%%%%%%%%%%%%%%%%%%%）
format long
xrv=0:0.001:3;
yrv=polyval(pr,xrv);
xr=1000*xrv;
yr=100*yrv;

xcv=0:0.001:3;
ycv=polyval(pc,xcv);
xc=1000*xcv;
yc=100*ycv;

plot(xr,yr,'--k')
hold on
plot(xc,yc,'-b');
axis([-1500,1500,0,2000]);
set(gca,'ydir','reverse');

%%5.计算误差
%奇数次数项系数趋近于0，所以先只考虑绝对误差，之后再说；
rel_err1=zeros(3,(N-1)/2);%注意,位置发生了变化;
for i=1:t
    rel_err1(1,i)=dpc(2*i);%第二行是激光成像点的值；
    rel_err1(2,i)=dpr(2*i);%第一行是激光发射点的值；
    rel_err1(3,i)=rel_err1(1,i)-rel_err1(2,i);%第三行是前两行的误差绝对值；误差=测量值（成像值）-真实值（发射值）；
end
%偶数次数项系数是有值的，第三行绝对误差，第四行相对误差；
rel_err2=zeros(4,(N-1)/2);%注意,位置发生了变化;
for i=1:t
    rel_err2(1,i)=dpc(2*i-1);%第二行是激光成像点的值；
    rel_err2(2,i)=dpr(2*i-1);%第一行是激光发射点的值；
    rel_err2(3,i)=rel_err2(1,i)-rel_err2(2,i);%第三行是前两行的误差绝对值；误差=测量值（成像值）-真实值（发射值）；
    rel_err2(4,i)=rel_err2(3,i)/rel_err2(2,i);%第四行是误差相对值;
end
rel_err1
rel_err2

%x的意义，和a0的意义，对之后指导工程有关系；

    

   


