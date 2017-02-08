%GD_poly_test
v1=2000;v2=3000;
RealValue=[1000,600,400,600,1000;500,1000,1500,2000,2500];
C=[1280,960,800,960,1280;1200,1600,2000,2400,2800;];

x_range=[0,v2];
y_range=[0,v1];
xr_point(1:5)=RealValue(2,:);
yr_point(1:5)=RealValue(1,:);
xr_point(6:10)=C(2,:);
yr_point(6:10)=C(1,:);
h=plot(xr_point(1:5),yr_point(1:5),'d')
hold on
h=plot(xr_point(6:10),yr_point(6:10),'o')
set(h,'MarkerSize',8)
legend('标准光斑','实测光斑')

LR={' 标准1',' 标准2',' 标准3',' 标准4',' 标准5',' 实测1 (1200,1280)',' 实测2 (1600,960)',' 实测3 (2000,800)',' 实测4 (2400,960)',' 实测5 (2800,1280)'}; %5个标注
%LC={' 光斑1 (500,1000)',' 光斑2 (1000,600)',' 光斑3 (1500,400)',' 光斑4 (2000,600)',' 光斑5 (2500,1000)',' 实测光斑1 (1200,1280)',' 实测光斑2 (1600,960)',' 实测光斑3 (2000,800)',' 实测光斑4 (2400,960)',' 实测光斑5 (2800,1280)'}; %5个标注

for ii=1:10
text(xr_point(ii),yr_point(ii),LR{ii},'FontSize',10);  %利用十个点的坐标添加对应标注

%适当增加一些距离，让文字和点分开会美观一些
end
axis([x_range(1),x_range(2),y_range(1),y_range(2)])
set(gca,'ydir','reverse');
set(gca,'xaxislocation','top')
xlabel('横像素','FontSize',20)
ylabel('众像素','FontSize',20)
grid on

pause(3)

%%%%%%%%%%%分界线%%%%%%%%%%


%test data listed below
%RealValue=[1000,600,400,600,1000;500,1000,1500,2000,2500];
%C=[1280,960,800,960,1280;1200,1600,2000,2400,2800];
%%1.按照拍摄结果，直接作图；
%这里RealValue就相当于我原本激光发射器本身的形心点，但事实上，激光发射器本身形心点的坐标是无意义的，有意义的是其对应多项式的系数矩阵；
clf;
RealValue=[1000,600,400,600,1000;500,1000,1500,2000,2500];
%平移坐标系到画幅中心
RealValue(1,:)=RealValue(1,:)-v1/2;
RealValue(2,:)=RealValue(2,:)-v2/2;
RealValue
RVM=[RealValue(2,:)/1000;RealValue(1,:)/100];%M=modified
N=5;
%pr means plot real
pr=polyfit(RVM(1,:),RVM(2,:),N-1);%用N-1操作的话，是完美的符合原值；
%下面仅是画图；
format long
xrv=RVM(1,1):0.005:RVM(1,5);
yrv=polyval(pr,xrv);
xr=1000*xrv;
yr=100*yrv;



%pause(3)

%现在处理对于之前的结果
%先用V4的结果；C=calculated
C=[1280,960,800,960,1280;1200,1600,2000,2400,2800];
%平移坐标系到画幅中心
C(1,:)=C(1,:)-v1/2;
C(2,:)=C(2,:)-v2/2;
C
CM=[C(2,:)/1000;C(1,:)/100];%M=modify
N=5;
%pr means plot real
pc=polyfit(CM(1,:),CM(2,:),N-1);%用N-1操作的话，是完美的符合原值；
%下面仅是画图；
format long
xcv=CM(1,1):0.005:CM(1,5);
ycv=polyval(pc,xcv);
xc=1000*xcv;
yc=100*ycv;
plot(xr,yr,'--k')

hold on 

axis([-1500,1500,-1000,1000]);
set(gca,'ydir','reverse');
plot(xc,yc,'-b');

hold on
xr_point(1:5)=1000*RVM(1,:);
yr_point(1:5)=100*RVM(2,:);
xr_point(6:10)=1000*CM(1,:);
yr_point(6:10)=100*CM(2,:);
h=plot(xr_point(1:5),yr_point(1:5),'d')

hold on
h=plot(xr_point(6:10),yr_point(6:10),'o')
set(h,'MarkerSize',8)
legend('标准曲线','实测曲线','标准光斑','实测光斑')

LR={' 标准1',' 标准2',' 标准3',' 标准4',' 标准5',' 实测1',' 实测2',' 实测3',' 实测4',' 实测5'}; %5个标注
%LC={' 光斑1 (500,1000)',' 光斑2 (1000,600)',' 光斑3 (1500,400)',' 光斑4 (2000,600)',' 光斑5 (2500,1000)',' 实测光斑1 (1200,1280)',' 实测光斑2 (1600,960)',' 实测光斑3 (2000,800)',' 实测光斑4 (2400,960)',' 实测光斑5 (2800,1280)'}; %5个标注

for ii=1:10
text(xr_point(ii),yr_point(ii),LR{ii},'FontSize',10);  %利用十个点的坐标添加对应标注

%适当增加一些距离，让文字和点分开会美观一些
end

set(gca,'xaxislocation','top')
xlabel('横像素','FontSize',20)
ylabel('众像素','FontSize',20)
grid on

clf
pause(3)

%%%%%%%%%%%%%%%%%%分界线%%%%%%%%%%%%%%%%%%%%%%%
%%%%%之后核心思想??所有的值满足MECE原则（卧槽这里可以装个逼），全部化标（所有全部划归到）；




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

CM(1,:)=CM(1,:)*Xzoom;
CM(2,:)=CM(2,:)*Yzoom;

%这时候坐标系变化，拟合的多项式结果也应该随之变化
%dpc1=polyfit(CM(1,:),CM(2,:),N-1)
pc=polyfit(CM(1,:),CM(2,:),N-1)%用N-1操作的话，是完美的符合原值；
CM=[C(2,:)/1000;C(1,:)/100]%M=modify




format long
xcv=CM(1,1):0.005:CM(1,5);
ycv=polyval(pc,xcv);
xc=1000*xcv;
yc=100*ycv;
plot(xr,yr,'--k')

hold on 

axis([-Xzoom*1500,Xzoom*1500,-Yzoom*1000,Yzoom*1000]);
set(gca,'ydir','reverse');
plot(xc,yc,'-b');

hold on
xr_point(1:5)=1000*RVM(1,:);
yr_point(1:5)=100*RVM(2,:);
xr_point(6:10)=1000*CM(1,:);
yr_point(6:10)=100*CM(2,:);
h=plot(xr_point(1:5),yr_point(1:5),'d')

hold on
h=plot(xr_point(6:10),yr_point(6:10),'o')
set(h,'MarkerSize',8)
legend('标准曲线','实测曲线','标准光斑','实测光斑')

LR={' 标准1',' 标准2',' 标准3',' 标准4',' 标准5',' 实测1',' 实测2',' 实测3',' 实测4',' 实测5'}; %5个标注
%LC={' 光斑1 (500,1000)',' 光斑2 (1000,600)',' 光斑3 (1500,400)',' 光斑4 (2000,600)',' 光斑5 (2500,1000)',' 实测光斑1 (1200,1280)',' 实测光斑2 (1600,960)',' 实测光斑3 (2000,800)',' 实测光斑4 (2400,960)',' 实测光斑5 (2800,1280)'}; %5个标注

for ii=1:10
text(xr_point(ii),yr_point(ii),LR{ii},'FontSize',10);  %利用十个点的坐标添加对应标注

%适当增加一些距离，让文字和点分开会美观一些
end

set(gca,'xaxislocation','top')
xlabel('横像素','FontSize',20)
ylabel('众像素','FontSize',20)
grid on

pause(30)


%%%%%%%%%%%%%%%%分界线%%%%%%%%%%%%%%

%%2.左右关系的平移实现；
%pr认为激光发射点是理想的情形（正如本例原来已知的形心是非常对称的点），也就是这里平移使对称轴位于y轴后的式子，x奇数项的系数为0；
%但有一个逻辑关系要清楚，就是实际情况的激光发射点也不是完全理想的，也是要实测的。本例稍微理想化了；
t=(N-1)/2;
dpr=polyder(pr);
rpr=roots(dpr);
%必须给rpr中N-1个根排序，取第t个根；
rpr=sort(rpr,'ascend')

xr0=rpr(t)
dRVM=RVM(1,:)-xr0;%采用第一种方法，将x修改后，重新运算得系数；
dpr1=polyfit(dRVM*1000,RVM(2,:)*100,N-1)
dpr=polyfit(dRVM,RVM(2,:),N-1)
RealValue(2,:)=RealValue(2,:)-1000*xr0;%将RealValue矩阵改变为平移后的矩阵；
%曲线的顶点[xr0,dpr(N)];注意，这里dpr(N)=4,即，少乘了100的倍数；
%现在平移xr0个单位即为dpr啊！

dpc=polyder(pc);
rpc=roots(dpc);
%必须给rpr中N-1个根排序，取第t个根；
rpc=sort(rpc,'ascend')

xc0=rpc(t)
dCM=CM(1,:)-xc0;%采用第一种方法，将x修改后，重新运算得系数；
dpc1=polyfit(dCM,CM(2,:),N-1)
dpc=polyfit(dCM,CM(2,:),N-1)
C(2,:)=C(2,:)-1000*xc0;%将C矩阵改变为平移后的矩阵；
%%曲线的顶点[xc0,dpc(N)];注意，这里dpr(N)=4.01,即，少乘了100的倍数；
%现在平移xc0个单位即为dpc啊！


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%缺一个远近距离的位置转化关系（缩放情况与距离比例的反映）；





%%4.上下问题的对应实现；
yr0=dpr(1,N)
yc0=dpc(1,N)



%%4.5再次呈现经变换后的图形；（还没画完，函数怎么变换要想清楚%%%%%%%%%%%%%%%%%%%%%%%%%%%%）
format long
xrv=-3:0.005:3;
yrv=polyval(pr,xrv);
xr=1000*xrv;
yr=100*yrv;

xcv=-3:0.005:3;
ycv=polyval(pc,xcv);
xc=1000*xcv;
yc=100*ycv;

plot(xr,yr,'--k')
hold on
plot(xc,yc,'-b');
axis([-1500,1500,-1000,1000]);
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

    