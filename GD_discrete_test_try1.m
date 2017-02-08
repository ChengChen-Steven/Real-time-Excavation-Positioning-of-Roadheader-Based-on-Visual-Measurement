%%threshold4 less

%GD_discrete_test
%R2=R2/255;
[v1,v2]=size(R2);
threshold2=20;
N=5; %激光点的书目（最后应该用U的size判定是否与之相等）
Sa=0;  %激光点的计算面积；
S=[];  %N个激光点的计算面积的和；S=[S,Sa]；
I=[];  %记录在哪个处是临界点；I=[I,i]；
I(1)=0;%I原则上要比S大1；
u=ones(1,v1);
threshold3=130;%激光点之间的列数距离估值的50%-80%;%取2*r或长轴长度即可吧；这里取130，考虑长轴最多128的样子；
U=ones(threshold3,v1);
threshold4=3000;%U*矩阵中threshold3列的积应大于的值，要自己测试得到；50%激光点设计面积（7854）的水平吧；%这个值不简单啊我擦，v2用4000没问题，v4就得3500；
threshold5=1.5*threshold2
%%%%%%为什么v4的时候，会出现中间点只有3500??因为圆形的话，渐变的效果更明显，边缘全部都被被threshold(1)给砍了；所以面积非常的小
%%%%%%imshow可以发现，此时中间点的右侧明显的不对劲，有点被大砍一刀的感觉；算法记录I的时候有问题；如果I记录有问题，那么对应的下一个值就应当有问题吧？但是好像误差显示的结果却没问题；
%%%%%%好像也没有不对劲，可能是显示的问题；
%%%%%%检查一下算法的bug；


for i=1:v2-1
    s=u*R2(:,i);
    if u*R2(:,i)>0 ...
        & u*R2(:,i+1)>0;    %%%%%%似乎改用&&比&节省时间；
          Sa=Sa+s;  %If-1
    else if u*R2(:,i)>0 ...
             & u*R2(:,i+1)==0 ...
                & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...   %%%%%其实觉得上限和下限没必要共用一个threshold4，完全可以分开，就比如，这行是threshold5，下一行是threshold4
                  & Sa>=threshold4;
                    Sa=Sa+s;%%%%%threshold5可以相对小一点
                      S=[S,Sa];I=[I,i];
                        Sa=0;  %IF-3
    %这里有个不大合理的地方，就是算法实际认为绝大多数情况下，激光是由强到弱或由弱到强渐变的，但实际上不一定是这样的，如果不是渐变的，而且恰好是在threshold前后不规则变化，如何处理？         
    %另外，就是threshold的选取一定有数学上面的关系，比如threshold3的选取，具体选怎么个程度，很关键；threshold4的选取，和threshold3、threshold2肯定是有关系的； 要保证严格，不能有漏洞。        
    else if u*R2(:,i)>0 ...
             & u*R2(:,i+1)==0 ...
               & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))>=threshold4;
                 Sa=Sa+s;  %If-2
        else if u*R2(:,i)>0 ...
                & u*R2(:,i+1)==0 ...
                  & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...
                    & Sa<threshold4 ...
                      & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))>=threshold4;%%%%%%%%%%%这里加上threshold3有不妥的地方，如果这最右侧的点离画幅的边线不够长怎么办！！！！！！！！！
                        Sa=Sa+s;  %IF-4
                else if u*R2(:,i)>0 ...%这个if基本上上在对付嘈杂点，可以认为这里的嘈杂点应当归0；%所以这里R2发生了变化！！！！注意！！！R2这里就变了啊！！！！
                          & u*R2(:,i+1)==0 ...
                            & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...
                              & Sa<threshold4 ...
                                & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4;
                                  Sa=0; R2(:,i)=zeros(v1,1); %IF-5  %修改了R2 !!!
                                  % Key
                                  % point，这里似乎应当将认为是嘈杂点？？？？？？？？但是好像不止这一列需要清理，可能前面的一些部分也需要啊
                     else if u*R2(:,i)==0 ...
                               & u*R2(:,i+1)>0;
                                   Sa=Sa;
                          else Sa=Sa+s;%%这里改了一下，应该没啥问题吧;
                          end
                    end
             end
        end
        end
    end
end
I

for v=1:v2
    R3(:,v)=R2(:,v2+1-v);
end
Sa=0;  %激光点的计算面积；
SS=[];  %N个激光点的计算面积的和；S=[S,Sa]；
J=[];  %记录在哪个处是临界点；I=[I,i]；
J(1)=0;%I原则上要比S大1；
u=ones(1,v1);
threshold3=130;%激光点之间的列数距离估值的50%-80%;%取2*r或长轴长度即可吧；这里取130，考虑长轴最多128的样子；
U=ones(threshold3,v1);

for i=1:v2-1
    s=u*R3(:,i);
    if u*R3(:,i)>0 ...
        & u*R3(:,i+1)>0;    %%%%%%似乎改用&&比&节省时间；
          Sa=Sa+s;  %If-1
    else if u*R3(:,i)>0 ...
             & u*R3(:,i+1)==0 ...
                & sum(sum(U*R3(:,i+1:i+threshold3)))<threshold4 ...   %%%%%其实觉得上限和下限没必要共用一个threshold4，完全可以分开，就比如，这行是threshold5，下一行是threshold4
                  & Sa>=threshold4;
                    Sa=Sa+s;%%%%%threshold5可以相对小一点
                      SS=[SS,Sa];J=[J,i];
                        Sa=0;  %IF-3
    %这里有个不大合理的地方，就是算法实际认为绝大多数情况下，激光是由强到弱或由弱到强渐变的，但实际上不一定是这样的，如果不是渐变的，而且恰好是在threshold前后不规则变化，如何处理？         
    %另外，就是threshold的选取一定有数学上面的关系，比如threshold3的选取，具体选怎么个程度，很关键；threshold4的选取，和threshold3、threshold2肯定是有关系的； 要保证严格，不能有漏洞。        
    else if u*R3(:,i)>0 ...
             & u*R3(:,i+1)==0 ...
               & Sa+sum(sum(U*R3(:,i+1:i+threshold3)))>=threshold4;
                 Sa=Sa+s;  %If-2
        else if u*R3(:,i)>0 ...
                & u*R3(:,i+1)==0 ...
                  & sum(sum(U*R3(:,i+1:i+threshold3)))<threshold4 ...
                    & Sa<threshold4 ...
                      & Sa+sum(sum(U*R3(:,i+1:i+threshold3)))>=threshold4;%%%%%%%%%%%这里加上threshold3有不妥的地方，如果这最右侧的点离画幅的边线不够长怎么办！！！！！！！！！
                        Sa=Sa+s;  %IF-4
                else if u*R3(:,i)>0 ...%这个if基本上上在对付嘈杂点，可以认为这里的嘈杂点应当归0；%所以这里R2发生了变化！！！！注意！！！R2这里就变了啊！！！！
                          & u*R3(:,i+1)==0 ...
                            & sum(sum(U*R3(:,i+1:i+threshold3)))<threshold4 ...
                              & Sa<threshold4 ...
                                & Sa+sum(sum(U*R3(:,i+1:i+threshold3)))<threshold4;
                                  Sa=0; R3(:,i)=zeros(v1,1); %IF-5  %修改了R2 !!!
                                  % Key
                                  % point，这里似乎应当将认为是嘈杂点？？？？？？？？但是好像不止这一列需要清理，可能前面的一些部分也需要啊
                     else if u*R3(:,i)==0 ...
                               & u*R3(:,i+1)>0;
                                   Sa=Sa; 
                          else Sa=Sa+s;%%这里改了一下，应该没啥问题吧;
                          end
                    end
             end
        end
        end
    end
end
I
for v=1:v2
    R2(:,v)=R3(:,v2+1-v);
end

Sa=0;  %激光点的计算面积；
SS=[];  %N个激光点的计算面积的和；S=[S,Sa]；
I=[];  %记录在哪个处是临界点；I=[I,i]；
I(1)=0;%I原则上要比S大1；
u=ones(1,v1);
threshold3=130;%激光点之间的列数距离估值的50%-80%;%取2*r或长轴长度即可吧；这里取130，考虑长轴最多128的样子；
U=ones(threshold3,v1);


for i=1:v2-1
    s=u*R2(:,i);
    if u*R2(:,i)>0 ...
        & u*R2(:,i+1)>0;    %%%%%%似乎改用&&比&节省时间；
          Sa=Sa+s;  %If-1
    else if u*R2(:,i)>0 ...
             & u*R2(:,i+1)==0 ...
                & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...   %%%%%其实觉得上限和下限没必要共用一个threshold4，完全可以分开，就比如，这行是threshold5，下一行是threshold4
                  & Sa>=threshold4;
                    Sa=Sa+s;%%%%%threshold5可以相对小一点
                      SS=[SS,Sa];I=[I,i];
                        Sa=0;  %IF-3
    %这里有个不大合理的地方，就是算法实际认为绝大多数情况下，激光是由强到弱或由弱到强渐变的，但实际上不一定是这样的，如果不是渐变的，而且恰好是在threshold前后不规则变化，如何处理？         
    %另外，就是threshold的选取一定有数学上面的关系，比如threshold3的选取，具体选怎么个程度，很关键；threshold4的选取，和threshold3、threshold2肯定是有关系的； 要保证严格，不能有漏洞。        
    else if u*R2(:,i)>0 ...
             & u*R2(:,i+1)==0 ...
               & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))>=threshold4;
                 Sa=Sa+s;  %If-2
        else if u*R2(:,i)>0 ...
                & u*R2(:,i+1)==0 ...
                  & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...
                    & Sa<threshold4 ...
                      & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))>=threshold4;%%%%%%%%%%%这里加上threshold3有不妥的地方，如果这最右侧的点离画幅的边线不够长怎么办！！！！！！！！！
                        Sa=Sa+s;  %IF-4
                else if u*R2(:,i)>0 ...%这个if基本上上在对付嘈杂点，可以认为这里的嘈杂点应当归0；%所以这里R2发生了变化！！！！注意！！！R2这里就变了啊！！！！
                          & u*R2(:,i+1)==0 ...
                            & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...
                              & Sa<threshold4 ...
                                & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4;
                                  Sa=0; R2(:,i)=zeros(v1,1); %IF-5  %修改了R2 !!!
                                  % Key
                                  % point，这里似乎应当将认为是嘈杂点？？？？？？？？但是好像不止这一列需要清理，可能前面的一些部分也需要啊
                     else if u*R2(:,i)==0 ...
                               & u*R2(:,i+1)>0;
                                   Sa=Sa; 
                          else Sa=Sa+s;%%这里改了一下，应该没啥问题吧;
                          end
                    end
             end
        end
        end
    end
end


I




%%%%%%%%%%%%%%%%分界线%%%%%%%%%%%%%%%%%%%

R14=R2;
R14(R14>0)=1;
count_4=sum(sum(R14))
IMG3=zeros(2000,3000);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R2;IMG(:,:,1)=IMG1;
imshow(IMG,'initialmagnification','fit');
title('经过列控制算法处理后的激光光斑图','fontsize',18)
pause(10)

I
JJ=sum(R14);
m1=I(1);m2=I(2);m3=I(3);m4=I(4);m5=I(5);m6=I(6);
mmm=[sum(JJ(m1+1:m2)),sum(JJ(m2+1:m3)),sum(JJ(m3+1:m4)),sum(JJ(m4+1:m5)),sum(JJ(m5+1:m6)),sum(JJ(m6+1:3000))]
sum(mmm)


n1=size(S,2);
%T=[];       %%%%%T为分化后的矩阵；可以有可以无，设成三维矩阵，需要右侧拓宽零矩阵，使得dimension一致；
C=[];%C为centroid表示形心的矩阵；
E=[];%E为误差矩阵；衡量相对误差；
St=[];%每个分化后矩阵的面积矩阵；
Sb=0;
ft3=floor(v1/threshold3);
II=zeros(ft3,n1);
SB=zeros(ft3,n1);
if n1==N   %要先采用threshold2处理每个矩阵的行和；
    for i=1:N
        z=0;
        for k=1:v1
            if sum(R2(k,(I(i)+1):I(i+1)))>=threshold2
                R2(k,(I(i)+1):I(i+1))=R2(k,(I(i)+1):I(i+1));
            else R2(k,(I(i)+1):I(i+1))=zeros(1,I(i+1)-I(i));
            end
        end
        for j=1:v1-1
            u=ones(I(i+1)-I(i),1);
            U=ones(I(i+1)-I(i),threshold3);
            s=sum(R2(j,(I(i)+1):I(i+1)));%%好像只走了i=1就结束了，看看为什么
            if sum(R2(j,(I(i)+1):I(i+1)))>0 ...
                    &sum(R2(j+1,(I(i)+1):I(i+1)))>0
                Sb=Sb+s;
            else if sum(R2(j,(I(i)+1):I(i+1)))>0 ...
                        &sum(R2(j+1,(I(i)+1):I(i+1)))==0 ...
                           &sum(sum(U*R2(j+1:j+threshold3,(I(i)+1):I(i+1))))<threshold4 ...
                              &Sb>=threshold4;
                          Sb=Sb+s;
                          z=z+1;
                          SB(z,i)=Sb;II(z,i)=j;
                          Sb=0;
                else if R2(j,(I(i)+1):I(i+1))*u>0 ...
                         & R2(j+1,(I(i)+1):I(i+1))*u==0 ...
                           & Sb+sum(sum(U*R2(j+1:j+threshold3,(I(i)+1):I(i+1))))>=threshold4;
                        Sb=Sb+s;  %If-2
        else if R2(j,(I(i)+1):I(i+1))*u>0 ...
                & R2(j+1,(I(i)+1):I(i+1))*u==0 ...
                  & sum(sum(U*R2(j+1:j+threshold3,(I(i)+1):I(i+1))))<threshold4 ...
                    & Sb<threshold4 ...
                      & Sb+sum(sum(U*R2(j+1:j+threshold3,(I(i)+1):I(i+1))))>=threshold4;%%%%%%%%%%%这里加上threshold3有不妥的地方，如果这最下侧的点离画幅的边线不够长怎么办！！！！！！！！！
                        Sb=Sb+s;  %IF-4
                else if R2(j,(I(i)+1):I(i+1))*u>0 ...%这个if基本上上在对付嘈杂点，可以认为这里的嘈杂点应当归0；%所以这里R2发生了变化！
                          & R2(j+1,(I(i)+1):I(i+1))*u==0 ...
                            & sum(sum(U*R2(j+1:j+threshold3,(I(i)+1):I(i+1))))<threshold4 ...
                              & Sb<threshold4 ...
                                & Sb+sum(sum(U*R2(j+1:j+threshold3,(I(i)+1):I(i+1))))<threshold4;
                                  Sb=0; 
                                  R2(j,(I(i)+1):I(i+1))=zeros(1,(1+I(i+1)-(I(i)+1))); %修改了R2 !!!
                                  % Key point，这里似乎应当将认为是嘈杂点
                     else if R2(j,(I(i)+1):I(i+1))*u==0 ...
                               & R2(j+1,(I(i)+1):I(i+1))*u>0;
                                   Sb=Sb;
                          else Sb=Sb+s;
                         end
                    end
            end
                    end
                end
            end
        end
    end
    
    IMG3=zeros(2000,3000);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R2;IMG(:,:,1)=IMG1;
    imshow(IMG,'initialmagnification','fit');
    title('经过行计算准入值和行控制算法处理后的激光光斑图','fontsize',18)
    pause(10)
    
    R15=R2;R15(R15>0)=1;count_5=sum(sum(R15))
    JJ1=sum(R15);
    m1=I(1);m2=I(2);m3=I(3);m4=I(4);m5=I(5);m6=I(6);
    mmmm=[sum(JJ1(m1+1:m2)),sum(JJ1(m2+1:m3)),sum(JJ1(m3+1:m4)),sum(JJ1(m4+1:m5)),sum(JJ1(m5+1:m6)),sum(JJ1(m6+1:3000))]
    sum(mmmm)
    
    for i=1:v2
    %Elapsed time is 0.017930 seconds.
    if sum(R2(:,i))>=threshold5%注意这里的threshold2是已经化标为0后的结果；
        R2(:,i)=R2(:,i);
    else R2(:,i)=zeros(v1,1);
    end
    
    end
    
    IMG3=zeros(2000,3000);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R2;IMG(:,:,1)=IMG1;
    imshow(IMG,'initialmagnification','fit');
    title('经过列计算准入值二次处理后的激光光斑图','fontsize',18)
    pause(10)
    
    R16=R2;
    R16(R16>0)=1;
    count_6=sum(sum(R16))

else
display('Something is wrong')
end
II
II(II>0)=1;

if sum(sum(II))==N        
    for i=1:N
        Ym=0;Xm=0;%Y方向的弯矩，行方向； X方向的弯矩，列方向；
        %T(:,:,i)=R2(:,(I(i)+1):I(i+1));%注意I要比S矩阵长度大一；            
        St(i)=sum(sum(R2(:,(I(i)+1):I(i+1)))); %T的面积;
        for j=1:v1
            for k=I(i)+1:I(i+1)
                Ym=Ym+R2(j,k)*j ; %Y方向弯矩；
                Xm=Xm+R2(j,k)*k ; %X方向弯矩；
            end
        end
        C(1,i)=Ym/St(i);%计算形心;
        C(2,i)=Xm/St(i);
    end
    format long
    display(C)
    display(St)%基于行&列处理后的矩阵R2
    display(S)%仅列处理后的结果
    display(SB)%在S基础上经过行处理后的结果（SB值应当等于St小于S）??最后用SB(St);
else
    display('Somewhere is wrong')  %这里其实应该继续讨论4个点和6个点的情形;
    
end


%下面计算误差
%RealValue=(1.0e+03)*[1,0.6,0.4,0.6,1;0.5,1,1.5,2,2.5];
%形心位置的误差
RealValue=[1000,600,400,600,1000;500,1000,1500,2000,2500];
for i=1:2
    for j=1:n1
   E(i,j)=(C(i,j)-RealValue(i,j))/RealValue(i,j);
    end
end
E

%只需要0.3秒
%问题，都是在R2基础上的变化，为什么会出现S普遍下雨St的结果;
%接上,sum(sum(R2))=23908,sum(sum(St))=23908,sum(S)=23775，前两者相等无可厚非，因为都是直接从矩阵加和得到的，为什么sum(S)小于之前的结果，哪些值被算法给“吞了”

%明天把Y方向的缩减算法也给做了。
%思考为什么GD_discrete比GD_pic_dig要多了很多值，因为讲道理计算次数应当多于前者。而且imread其实不占时间（0.14秒）

%画出点的位置

%C=roundn(C,-2)
C=[1000.63,600.98,401.24,599.33,1001.17;500.95,999.68,1501.01,2001.00,2500.62];
x_range=[0,v2];
y_range=[0,v1];
x_point=C(2,:);
y_point=C(1,:);
h=plot(x_point,y_point,'d')
set(h,'MarkerSize',10)

%text(x_point(1),y_point(1),['\rm', num2str(x_point(1),y_point(1))],'FontSize',12)


L={' 光斑1 (500.95,1000.63)',' 光斑2 (999.68,600.98)',' 光斑3 (1501.01,401.24)',' 光斑4 (2001.00,599.33)',' 光斑5 (2500.62,1001.17)'}; %5个标注


for ii=1:5
text(x_point(ii),y_point(ii),L{ii},'FontSize',13);  %利用十个点的坐标添加对应标注
%适当增加一些距离，让文字和点分开会美观一些
end
axis([x_range(1),x_range(2),y_range(1),y_range(2)])
set(gca,'ydir','reverse');
set(gca,'xaxislocation','top')
xlabel('横像素','FontSize',20)
ylabel('众像素','FontSize',20)
grid on
