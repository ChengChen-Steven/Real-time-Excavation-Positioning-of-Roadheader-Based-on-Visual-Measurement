clear;clc;clf;
threshold=100;
threshold2=20;
filename='LaserSamplev53.jpg'
%function [R2]=GD_pic_dig(filename,threshold,threshold2)

%��ʵthreshold2���Ժ�thresholdֱ���и�������ϵ���������ھ���threshold/255*r
Ro=imread(filename);%RGB�����ά����%Elapsed time is 0.144618 seconds.
R=Ro(:,:,1);%RGB���R����
max_R=max(R);
%IMG3=zeros(2000,3000);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R;IMG(:,:,1)=IMG1;
%imshow(IMG)

%Elapsed time is 0.003831 seconds.
%R1=R/255;%RGB��R����λ����
%R2�ǽ�һ�в�����threshold2����ֵ�ͣ��������㣻
[v1,v2]=size(R)
%Elapsed time is 0.000009 seconds.

%R11��ʼֵΪR
R11=R;%%%%%%%%%%%�����jb�ؼ���%%%%%%%Ԥ�ȶ�������С���Լ����ʱ�䣡��������

%����R�з�0Ԫ����Ŀ���ı���R����0Ԫ�ر�Ϊ1
R(R>0)=1;
count_1=sum(sum(R))

%R11��С��threshold����
R11(R11<threshold)=0;%%%%%%����ѭ���ķ���

%R12����С��threshold������R11��������0Ԫ�ر�Ϊ1���������threshold��Ԫ����Ŀ
R12=R11;
R12(R12>0)=1;
count_2=sum(sum(R12))

%��������Ԫ��ֵ׼��ֵ������R11ͼ��
IMG3=zeros(v1,v2);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R11;IMG(:,:,1)=IMG1;
imshow(uint8(IMG),'initialmagnification','fit');
title('����Ԫ�ؼ���׼��ֵ�����ļ�����ͼ','fontsize',18)
pause(10)

%��R11��λ�������[0��1]��
%R11=R11/255;

%%for j=1:v2%%%%%%%%%%%%%%Matlab����forѭ����whileѭ���ܲ���������������棻
        %if sum(R(:,j))<nouse%%series
    %R(:,j)=zeros(v1,1);%%series
    %else %%series
    %%for i=1:v1
      %%  if R(i,j)>=threshold
        %%    R11(i,j)=R(i,j)/255;%%%%%%%%%%���֪��R11�ľ����Сʱ���ȸ��������ˣ����������ʡ�ܶ�ռ䣡����
            %R10(i,j)=1;
       %% else R11(i,j)=0;
             %R10(i,j)=0; 
       %% end
   %% end
    %end%%series
%%end

%�½�R2=������׼��ֵ������R11��
for i=1:v2
    %Elapsed time is 0.017930 seconds.
    if sum(R11(:,i))>=threshold2*255%ע�������threshold2���Ѿ�����Ϊ0��Ľ����
        R2(:,i)=R11(:,i);
    else R2(:,i)=zeros(v1,1);
    end
end
%R2��ͼ��
IMG3=zeros(v1,v2);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R2;IMG(:,:,1)=IMG1;
imshow(uint8(IMG),'initialmagnification','fit');
title('�����м���׼��ֵ�����ļ�����ͼ','fontsize',18)
%����R2�з�0ֵ����Ŀ
R13=R2;
R13(R13>0)=1;
count_3=sum(sum(R13))

R2=R2/255;
        
%ΪRGB���R�ĵ�λɸѡ����
%����ʱ��
%tic;imread('LaserSamplev2.jpg');toc
%Elapsed time is 0.144618 seconds.
%imread��ʵ��ռ�ٶȣ�


