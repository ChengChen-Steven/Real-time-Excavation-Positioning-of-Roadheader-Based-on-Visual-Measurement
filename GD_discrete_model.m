%%threshold4 less

%GD_discrete_test
%R2=R2/255;
[v1,v2]=size(R2);
threshold2=20;
N=5; %��������Ŀ�����Ӧ����U��size�ж��Ƿ���֮��ȣ�
Sa=0;  %�����ļ��������
S=[];  %N�������ļ�������ĺͣ�S=[S,Sa]��
I=[];  %��¼���ĸ������ٽ�㣻I=[I,i]��
I(1)=0;%Iԭ����Ҫ��S��1��
u=ones(1,v1);
threshold3=130;%�����֮������������ֵ��50%-80%;%ȡ2*r���᳤�ȼ��ɰɣ�����ȡ130�����ǳ������128�����ӣ�
U=ones(threshold3,v1);
threshold4=3000;%U*������threshold3�еĻ�Ӧ���ڵ�ֵ��Ҫ�Լ����Եõ���50%�������������7854����ˮƽ�ɣ�%���ֵ���򵥰��Ҳ���v2��4000û���⣬v4�͵�3500��
threshold5=1.5*threshold2
%%%%%%Ϊʲôv4��ʱ�򣬻�����м��ֻ��3500??��ΪԲ�εĻ��������Ч�������ԣ���Եȫ��������threshold(1)�����ˣ���������ǳ���С
%%%%%%imshow���Է��֣���ʱ�м����Ҳ����ԵĲ��Ծ����е㱻��һ���ĸо����㷨��¼I��ʱ�������⣻���I��¼�����⣬��ô��Ӧ����һ��ֵ��Ӧ��������ɣ����Ǻ��������ʾ�Ľ��ȴû���⣻
%%%%%%����Ҳû�в��Ծ�����������ʾ�����⣻
%%%%%%���һ���㷨��bug��


for i=1:v2-1
    s=u*R2(:,i);
    if u*R2(:,i)>0 ...
        & u*R2(:,i+1)>0;    %%%%%%�ƺ�����&&��&��ʡʱ�䣻
          Sa=Sa+s;  %If-1
    else if u*R2(:,i)>0 ...
             & u*R2(:,i+1)==0 ...
                & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...   %%%%%��ʵ�������޺�����û��Ҫ����һ��threshold4����ȫ���Էֿ����ͱ��磬������threshold5����һ����threshold4
                  & Sa>=threshold4;
                    Sa=Sa+s;%%%%%threshold5�������Сһ��
                      S=[S,Sa];I=[I,i];
                        Sa=0;  %IF-3
    %�����и��������ĵط��������㷨ʵ����Ϊ�����������£���������ǿ������������ǿ����ģ���ʵ���ϲ�һ���������ģ�������ǽ���ģ�����ǡ������thresholdǰ�󲻹���仯����δ���         
    %���⣬����threshold��ѡȡһ������ѧ����Ĺ�ϵ������threshold3��ѡȡ������ѡ��ô���̶ȣ��ܹؼ���threshold4��ѡȡ����threshold3��threshold2�϶����й�ϵ�ģ� Ҫ��֤�ϸ񣬲�����©����        
    else if u*R2(:,i)>0 ...
             & u*R2(:,i+1)==0 ...
               & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))>=threshold4;
                 Sa=Sa+s;  %If-2
        else if u*R2(:,i)>0 ...
                & u*R2(:,i+1)==0 ...
                  & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...
                    & Sa<threshold4 ...
                      & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))>=threshold4;%%%%%%%%%%%�������threshold3�в��׵ĵط�����������Ҳ�ĵ��뻭���ı��߲�������ô�죡����������������
                        Sa=Sa+s;  %IF-4
                else if u*R2(:,i)>0 ...%���if���������ڶԸ����ӵ㣬������Ϊ��������ӵ�Ӧ����0��%��������R2�����˱仯��������ע�⣡����R2����ͱ��˰���������
                          & u*R2(:,i+1)==0 ...
                            & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...
                              & Sa<threshold4 ...
                                & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4;
                                  Sa=0; R2(:,i)=zeros(v1,1); %IF-5  %�޸���R2 !!!
                                  % Key
                                  % point�������ƺ�Ӧ������Ϊ�����ӵ㣿�����������������Ǻ���ֹ��һ����Ҫ��������ǰ���һЩ����Ҳ��Ҫ��
                     else if u*R2(:,i)==0 ...
                               & u*R2(:,i+1)>0;
                                   Sa=Sa;
                          else Sa=Sa+s;%%�������һ�£�Ӧ��ûɶ�����;
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
Sa=0;  %�����ļ��������
SS=[];  %N�������ļ�������ĺͣ�S=[S,Sa]��
J=[];  %��¼���ĸ������ٽ�㣻I=[I,i]��
J(1)=0;%Iԭ����Ҫ��S��1��
u=ones(1,v1);
threshold3=130;%�����֮������������ֵ��50%-80%;%ȡ2*r���᳤�ȼ��ɰɣ�����ȡ130�����ǳ������128�����ӣ�
U=ones(threshold3,v1);

for i=1:v2-1
    s=u*R3(:,i);
    if u*R3(:,i)>0 ...
        & u*R3(:,i+1)>0;    %%%%%%�ƺ�����&&��&��ʡʱ�䣻
          Sa=Sa+s;  %If-1
    else if u*R3(:,i)>0 ...
             & u*R3(:,i+1)==0 ...
                & sum(sum(U*R3(:,i+1:i+threshold3)))<threshold4 ...   %%%%%��ʵ�������޺�����û��Ҫ����һ��threshold4����ȫ���Էֿ����ͱ��磬������threshold5����һ����threshold4
                  & Sa>=threshold4;
                    Sa=Sa+s;%%%%%threshold5�������Сһ��
                      SS=[SS,Sa];J=[J,i];
                        Sa=0;  %IF-3
    %�����и��������ĵط��������㷨ʵ����Ϊ�����������£���������ǿ������������ǿ����ģ���ʵ���ϲ�һ���������ģ�������ǽ���ģ�����ǡ������thresholdǰ�󲻹���仯����δ���         
    %���⣬����threshold��ѡȡһ������ѧ����Ĺ�ϵ������threshold3��ѡȡ������ѡ��ô���̶ȣ��ܹؼ���threshold4��ѡȡ����threshold3��threshold2�϶����й�ϵ�ģ� Ҫ��֤�ϸ񣬲�����©����        
    else if u*R3(:,i)>0 ...
             & u*R3(:,i+1)==0 ...
               & Sa+sum(sum(U*R3(:,i+1:i+threshold3)))>=threshold4;
                 Sa=Sa+s;  %If-2
        else if u*R3(:,i)>0 ...
                & u*R3(:,i+1)==0 ...
                  & sum(sum(U*R3(:,i+1:i+threshold3)))<threshold4 ...
                    & Sa<threshold4 ...
                      & Sa+sum(sum(U*R3(:,i+1:i+threshold3)))>=threshold4;%%%%%%%%%%%�������threshold3�в��׵ĵط�����������Ҳ�ĵ��뻭���ı��߲�������ô�죡����������������
                        Sa=Sa+s;  %IF-4
                else if u*R3(:,i)>0 ...%���if���������ڶԸ����ӵ㣬������Ϊ��������ӵ�Ӧ����0��%��������R2�����˱仯��������ע�⣡����R2����ͱ��˰���������
                          & u*R3(:,i+1)==0 ...
                            & sum(sum(U*R3(:,i+1:i+threshold3)))<threshold4 ...
                              & Sa<threshold4 ...
                                & Sa+sum(sum(U*R3(:,i+1:i+threshold3)))<threshold4;
                                  Sa=0; R3(:,i)=zeros(v1,1); %IF-5  %�޸���R2 !!!
                                  % Key
                                  % point�������ƺ�Ӧ������Ϊ�����ӵ㣿�����������������Ǻ���ֹ��һ����Ҫ��������ǰ���һЩ����Ҳ��Ҫ��
                     else if u*R3(:,i)==0 ...
                               & u*R3(:,i+1)>0;
                                   Sa=Sa; 
                          else Sa=Sa+s;%%�������һ�£�Ӧ��ûɶ�����;
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

Sa=0;  %�����ļ��������
SS=[];  %N�������ļ�������ĺͣ�S=[S,Sa]��
I=[];  %��¼���ĸ������ٽ�㣻I=[I,i]��
I(1)=0;%Iԭ����Ҫ��S��1��
u=ones(1,v1);
threshold3=130;%�����֮������������ֵ��50%-80%;%ȡ2*r���᳤�ȼ��ɰɣ�����ȡ130�����ǳ������128�����ӣ�
U=ones(threshold3,v1);


for i=1:v2-1
    s=u*R2(:,i);
    if u*R2(:,i)>0 ...
        & u*R2(:,i+1)>0;    %%%%%%�ƺ�����&&��&��ʡʱ�䣻
          Sa=Sa+s;  %If-1
    else if u*R2(:,i)>0 ...
             & u*R2(:,i+1)==0 ...
                & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...   %%%%%��ʵ�������޺�����û��Ҫ����һ��threshold4����ȫ���Էֿ����ͱ��磬������threshold5����һ����threshold4
                  & Sa>=threshold4;
                    Sa=Sa+s;%%%%%threshold5�������Сһ��
                      SS=[SS,Sa];I=[I,i];
                        Sa=0;  %IF-3
    %�����и��������ĵط��������㷨ʵ����Ϊ�����������£���������ǿ������������ǿ����ģ���ʵ���ϲ�һ���������ģ�������ǽ���ģ�����ǡ������thresholdǰ�󲻹���仯����δ���         
    %���⣬����threshold��ѡȡһ������ѧ����Ĺ�ϵ������threshold3��ѡȡ������ѡ��ô���̶ȣ��ܹؼ���threshold4��ѡȡ����threshold3��threshold2�϶����й�ϵ�ģ� Ҫ��֤�ϸ񣬲�����©����        
    else if u*R2(:,i)>0 ...
             & u*R2(:,i+1)==0 ...
               & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))>=threshold4;
                 Sa=Sa+s;  %If-2
        else if u*R2(:,i)>0 ...
                & u*R2(:,i+1)==0 ...
                  & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...
                    & Sa<threshold4 ...
                      & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))>=threshold4;%%%%%%%%%%%�������threshold3�в��׵ĵط�����������Ҳ�ĵ��뻭���ı��߲�������ô�죡����������������
                        Sa=Sa+s;  %IF-4
                else if u*R2(:,i)>0 ...%���if���������ڶԸ����ӵ㣬������Ϊ��������ӵ�Ӧ����0��%��������R2�����˱仯��������ע�⣡����R2����ͱ��˰���������
                          & u*R2(:,i+1)==0 ...
                            & sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4 ...
                              & Sa<threshold4 ...
                                & Sa+sum(sum(U*R2(:,i+1:i+threshold3)))<threshold4;
                                  Sa=0; R2(:,i)=zeros(v1,1); %IF-5  %�޸���R2 !!!
                                  % Key
                                  % point�������ƺ�Ӧ������Ϊ�����ӵ㣿�����������������Ǻ���ֹ��һ����Ҫ��������ǰ���һЩ����Ҳ��Ҫ��
                     else if u*R2(:,i)==0 ...
                               & u*R2(:,i+1)>0;
                                   Sa=Sa; 
                          else Sa=Sa+s;%%�������һ�£�Ӧ��ûɶ�����;
                          end
                    end
             end
        end
        end
    end
end


I




%%%%%%%%%%%%%%%%�ֽ���%%%%%%%%%%%%%%%%%%%

R14=R2;
R14(R14>0)=1;
count_4=sum(sum(R14))
IMG3=zeros(2000,3000);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R2;IMG(:,:,1)=IMG1;
imshow(IMG,'initialmagnification','fit');
title('�����п����㷨�����ļ�����ͼ','fontsize',18)
pause(10)

I
JJ=sum(R14);
m1=I(1);m2=I(2);m3=I(3);m4=I(4);m5=I(5);m6=I(6);
mmm=[sum(JJ(m1+1:m2)),sum(JJ(m2+1:m3)),sum(JJ(m3+1:m4)),sum(JJ(m4+1:m5)),sum(JJ(m5+1:m6)),sum(JJ(m6+1:3000))]
sum(mmm)


n1=size(S,2);
%T=[];       %%%%%TΪ�ֻ���ľ��󣻿����п����ޣ������ά������Ҫ�Ҳ��ؿ������ʹ��dimensionһ�£�
C=[];%CΪcentroid��ʾ���ĵľ���
E=[];%EΪ�����󣻺��������
St=[];%ÿ���ֻ��������������
Sb=0;
ft3=floor(v1/threshold3);
II=zeros(ft3,n1);
SB=zeros(ft3,n1);
if n1==N   %Ҫ�Ȳ���threshold2����ÿ��������кͣ�
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
            s=sum(R2(j,(I(i)+1):I(i+1)));%%����ֻ����i=1�ͽ����ˣ�����Ϊʲô
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
                      & Sb+sum(sum(U*R2(j+1:j+threshold3,(I(i)+1):I(i+1))))>=threshold4;%%%%%%%%%%%�������threshold3�в��׵ĵط�����������²�ĵ��뻭���ı��߲�������ô�죡����������������
                        Sb=Sb+s;  %IF-4
                else if R2(j,(I(i)+1):I(i+1))*u>0 ...%���if���������ڶԸ����ӵ㣬������Ϊ��������ӵ�Ӧ����0��%��������R2�����˱仯��
                          & R2(j+1,(I(i)+1):I(i+1))*u==0 ...
                            & sum(sum(U*R2(j+1:j+threshold3,(I(i)+1):I(i+1))))<threshold4 ...
                              & Sb<threshold4 ...
                                & Sb+sum(sum(U*R2(j+1:j+threshold3,(I(i)+1):I(i+1))))<threshold4;
                                  Sb=0; 
                                  R2(j,(I(i)+1):I(i+1))=zeros(1,(1+I(i+1)-(I(i)+1))); %�޸���R2 !!!
                                  % Key point�������ƺ�Ӧ������Ϊ�����ӵ�
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
    title('�����м���׼��ֵ���п����㷨�����ļ�����ͼ','fontsize',18)
    pause(10)
    
    R15=R2;R15(R15>0)=1;count_5=sum(sum(R15))
    JJ1=sum(R15);
    m1=I(1);m2=I(2);m3=I(3);m4=I(4);m5=I(5);m6=I(6);
    mmmm=[sum(JJ1(m1+1:m2)),sum(JJ1(m2+1:m3)),sum(JJ1(m3+1:m4)),sum(JJ1(m4+1:m5)),sum(JJ1(m5+1:m6)),sum(JJ1(m6+1:3000))]
    sum(mmmm)
    
    for i=1:v2
    %Elapsed time is 0.017930 seconds.
    if sum(R2(:,i))>=threshold5%ע�������threshold2���Ѿ�����Ϊ0��Ľ����
        R2(:,i)=R2(:,i);
    else R2(:,i)=zeros(v1,1);
    end
    
    end
    
    IMG3=zeros(2000,3000);IMG(:,:,2)=IMG3;IMG(:,:,3)=IMG3;IMG1=R2;IMG(:,:,1)=IMG1;
    imshow(IMG,'initialmagnification','fit');
    title('�����м���׼��ֵ���δ����ļ�����ͼ','fontsize',18)
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
        Ym=0;Xm=0;%Y�������أ��з��� X�������أ��з���
        %T(:,:,i)=R2(:,(I(i)+1):I(i+1));%ע��IҪ��S���󳤶ȴ�һ��            
        St(i)=sum(sum(R2(:,(I(i)+1):I(i+1)))); %T�����;
        for j=1:v1
            for k=I(i)+1:I(i+1)
                Ym=Ym+R2(j,k)*j ; %Y������أ�
                Xm=Xm+R2(j,k)*k ; %X������أ�
            end
        end
        C(1,i)=Ym/St(i);%��������;
        C(2,i)=Xm/St(i);
    end
    format long
    display(C)
    display(St)%������&�д����ľ���R2
    display(S)%���д����Ľ��
    display(SB)%��S�����Ͼ����д����Ľ����SBֵӦ������StС��S��??�����SB(St);
else
    display('Somewhere is wrong')  %������ʵӦ�ü�������4�����6���������;
    
end


%����������
%RealValue=(1.0e+03)*[1,0.6,0.4,0.6,1;0.5,1,1.5,2,2.5];
%����λ�õ����
RealValue=[1000,600,400,600,1000;500,1000,1500,2000,2500];
for i=1:2
    for j=1:n1
   E(i,j)=(C(i,j)-RealValue(i,j))/RealValue(i,j);
    end
end
E

%ֻ��Ҫ0.3��
%���⣬������R2�����ϵı仯��Ϊʲô�����S�ձ�����St�Ľ��;
%����,sum(sum(R2))=23908,sum(sum(St))=23908,sum(S)=23775��ǰ��������޿ɺ�ǣ���Ϊ����ֱ�ӴӾ���Ӻ͵õ��ģ�Ϊʲôsum(S)С��֮ǰ�Ľ������Щֵ���㷨�������ˡ�

%�����Y����������㷨Ҳ�����ˡ�
%˼��ΪʲôGD_discrete��GD_pic_digҪ���˺ܶ�ֵ����Ϊ������������Ӧ������ǰ�ߡ�����imread��ʵ��ռʱ�䣨0.14�룩

%�������λ��

%C=roundn(C,-2)
C=[1000.63,600.98,401.24,599.33,1001.17;500.95,999.68,1501.01,2001.00,2500.62];
x_range=[0,v2];
y_range=[0,v1];
x_point=C(2,:);
y_point=C(1,:);
h=plot(x_point,y_point,'d')
set(h,'MarkerSize',10)

%text(x_point(1),y_point(1),['\rm', num2str(x_point(1),y_point(1))],'FontSize',12)


L={' ���1 (500.95,1000.63)',' ���2 (999.68,600.98)',' ���3 (1501.01,401.24)',' ���4 (2001.00,599.33)',' ���5 (2500.62,1001.17)'}; %5����ע


for ii=1:5
text(x_point(ii),y_point(ii),L{ii},'FontSize',13);  %����ʮ�����������Ӷ�Ӧ��ע
%�ʵ�����һЩ���룬�����ֺ͵�ֿ�������һЩ
end
axis([x_range(1),x_range(2),y_range(1),y_range(2)])
set(gca,'ydir','reverse');
set(gca,'xaxislocation','top')
xlabel('������','FontSize',20)
ylabel('������','FontSize',20)
grid on
