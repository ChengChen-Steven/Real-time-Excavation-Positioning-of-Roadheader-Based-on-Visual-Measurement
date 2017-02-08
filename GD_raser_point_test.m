clear;clc;clf;
%discrete the raser point photo
%step 1: RGB, drawing to digit
%��ȡͼ��
%A=imread('MidDisSmallFoc.jpg');
%A=imread('MidDisMidFoc.jpg');
%A=imread('MidDisLargeFoc.jpg');
A=imread('A87V0064.jpg');
%A=imread('Bookcase.jpg');

%step 2: RGB matrix size, pixel number, pixel value;
%R��R��R1�ǿ���������R2������ڽ�50��������С��50�Ĺ�0��
[a,b,c]=size(A)
R=A(:,:,1);R1=R;R1(R1>0)=1;R2=R;R2(R2<50)=0;R2(R2>=50)=1;
G=A(:,:,2);G1=G;G1(G1>0)=1;G2=G;G2(G2<50)=0;G2(G2>=50)=1;
G3=G;G3(G3<200)=0;G3(G3>=100)=1;G4=G;G4(G4<100)=0;G4(G4>=200)=1;G5=G;G5(G5<230)=0;G5(G5>=230)=1;
B=A(:,:,3);B1=B;B1(B1>0)=1;B2=B;B2(B2<50)=0;B2(B2>=50)=1;
%����R1��R2����������������R��ԭֵ��
number_pixel_1=[sum(sum(R1)),sum(sum(G1)),sum(sum(B1))]
number_pixel_2=[sum(sum(R2)),sum(sum(G2)),sum(sum(B2))]
value_pixel=[sum(sum(R)),sum(sum(G)),sum(sum(B))]
number_G=[sum(sum(G3)),sum(sum(G5)),sum(sum(G5))]

%step 3: R, G, B return to drawing separately
%R��G��B_single����ÿ�������ͼ��
Z=zeros(a,b);
R_single=zeros(a,b,3);G_single=zeros(a,b,3);B_single=zeros(a,b,3);
R_single(:,:,1)=R;R_single(:,:,2)=Z;R_single(:,:,3)=Z;
G_single(:,:,2)=G;G_single(:,:,1)=Z;G_single(:,:,3)=Z;
B_single(:,:,3)=B;B_single(:,:,1)=Z;B_single(:,:,2)=Z;

imshow(R_single/255,'border','tight','initialmagnification','fit');
set(gcf,'Position',[0,0,980,1280]) %set figure size
axis normal %full screen

pause(5)

imshow(G_single/255)
imshow(G_single/255,'border','tight','initialmagnification','fit');
set(gcf,'Position',[0,0,980,1280]) %set figure size
axis normal %full screen

pause(5)

imshow(B_single/255)
imshow(B_single/255,'border','tight','initialmagnification','fit');
set(gcf,'Position',[0,0,980,1280]) %set figure size
axis normal %full screen

pause(5)

%step 4: Analyze the digital data separately
%step 4.1: Extract the non-zero data and plot them separately
%start from R
%xRΪR��ÿ��Rֵ��Ӧ�����������г��֣�
%unique�ƺ�������200���㣬�����Ƚ�R3���Զ�
Rb=unique(R);
for i=1:length(Rb);
xR(i)=length(find(R==Rb(i)));
end
xR;
bar(Rb,xR)
%axis([0,260,0,5e4]);
%axis([0,260,0,2e3]);
axis([0,260,0,1e6]);
xlabel('Rֵ','FontSize',20)
ylabel('Rֵ�ֲ�','FontSize',20)
%subplot(3,1,1)
pause(5)

%then G
Gb=unique(G);
for i=1:length(Gb);
xG(i)=length(find(G==Gb(i)));
end
xG;
bar(Gb,xG)
%axis([0,260,0,5e4]);
%axis([0,260,0,2e3]);
axis([0,260,0,1e6]);
xlabel('Gֵ','FontSize',20)
ylabel('Gֵ�ֲ�','FontSize',20)
%subplot(3,1,2)
pause(5)

%then B
Bb=unique(B);
for i=1:length(Bb);
xB(i)=length(find(B==Bb(i)));
end
xB;
bar(Bb,xB)
%axis([0,260,0,5e4]);
%axis([0,260,0,2e3]);
axis([0,260,0,1e6]);
xlabel('Bֵ','FontSize',20)
ylabel('Bֵ�ֲ�','FontSize',20)
%subplot(3,1,3)


