clear;clc;clf;
threshold=100;
threshold2=20;
filename='LaserSamplev53.jpg'
%function [R2]=GD_pic_dig(filename,threshold,threshold2)

%其实threshold2可以和threshold直接有个函数关系，比如现在就是threshold/255*r
Ro=imread(filename);%RGB后的三维矩阵；%Elapsed time is 0.144618 seconds.
R=Ro(:,:,1);%RGB后的R矩阵；
max_R=max(R);
%IMG3=zeros(2000,3000);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R;IMG(:,:,1)=IMG1;
%imshow(IMG)

%Elapsed time is 0.003831 seconds.
%R1=R/255;%RGB后R矩阵单位化；
%R2是将一列不满足threshold2的列值和，进行清零；
[v1,v2]=size(R)
%Elapsed time is 0.000009 seconds.

%R11初始值为R
R11=R;%%%%%%%%%%%这个贼jb关键了%%%%%%%预先定义矩阵大小会节约大量时间！！！！！

%计算R中非0元素数目，改变了R，非0元素变为1
R(R>0)=1;
count_1=sum(sum(R))

%R11中小于threshold清零
R11(R11<threshold)=0;%%%%%%不用循环的方法

%R12等于小于threshold清零后的R11；并将非0元素变为1，计算大于threshold的元素数目
R12=R11;
R12(R12>0)=1;
count_2=sum(sum(R12))

%画出经过元素值准入值处理后的R11图像
IMG3=zeros(v1,v2);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R11;IMG(:,:,1)=IMG1;
imshow(uint8(IMG),'initialmagnification','fit');
title('经过元素计算准入值处理后的激光光斑图','fontsize',18)
pause(10)

%将R11单位化，变成[0，1]间
%R11=R11/255;

%%for j=1:v2%%%%%%%%%%%%%%Matlab处理for循环和while循环很差，最好用数组运算代替；
        %if sum(R(:,j))<nouse%%series
    %R(:,j)=zeros(v1,1);%%series
    %else %%series
    %%for i=1:v1
      %%  if R(i,j)>=threshold
        %%    R11(i,j)=R(i,j)/255;%%%%%%%%%%如果知道R11的矩阵大小时候，先给他定义了！！这样会节省很多空间！！！
            %R10(i,j)=1;
       %% else R11(i,j)=0;
             %R10(i,j)=0; 
       %% end
   %% end
    %end%%series
%%end

%新建R2=经过列准入值处理后的R11；
for i=1:v2
    %Elapsed time is 0.017930 seconds.
    if sum(R11(:,i))>=threshold2*255%注意这里的threshold2是已经化标为0后的结果；
        R2(:,i)=R11(:,i);
    else R2(:,i)=zeros(v1,1);
    end
end
%R2的图像
IMG3=zeros(v1,v2);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R2;IMG(:,:,1)=IMG1;
imshow(uint8(IMG),'initialmagnification','fit');
title('经过列计算准入值处理后的激光光斑图','fontsize',18)
%计算R2中非0值的数目
R13=R2;
R13(R13>0)=1;
count_3=sum(sum(R13))

R2=R2/255;
        
%为RGB后的R的单位筛选矩阵；
%调用时候：
%tic;imread('LaserSamplev2.jpg');toc
%Elapsed time is 0.144618 seconds.
%imread其实不占速度；


