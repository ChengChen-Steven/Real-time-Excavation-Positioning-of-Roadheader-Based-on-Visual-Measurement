clear;clc;clf;
threshold=230;
filename='A87V0064.jpg'
RGB=imread(filename);
G=RGB(:,:,2);
[v1,v2]=size(G)

G(G<threshold)=0;
G(G>=threshold)=1;
count_1=sum(sum(G))
format long
I=[1,1140,2016,3200,4056,4760];
C=zeros(2,5);
S=zeros(1,5);

%for i=1:5
%        Ym=0;Xm=0;
%        S(i)=sum(sum(G(:,(I(i)+1):I(i+1)))); 
%        for s=1:v1
%            for k=(I(i)+1):I(i+1)
%                Ym=Ym+G(s,k)*s;
%                Xm=Xm+G(s,k)*k;
%           end
%        end
%        C(1,i)=Ym/S(i);
%        C(2,i)=Xm/S(i);
%end


C

G1=sum(G);
G2=sum(G(:,2:1140)');
G3=sum(G(:,1141:2016)');
G4=sum(G(:,2017:3200)');
G5=sum(G(:,3201:4056)');
G6=sum(G(:,4057:4760)');

    Y=0;X=0;
    S=sum(sum(G(:,2:1140))); 
    for k=2:1140
        X=X+G1(k)*k;
    end
    for s=1:3456
        Y=Y+s*G2(s);
    end
    C(1,1)=Y/S;
    C(2,1)=X/S;

    Y=0;X=0;
    S=sum(sum(G(:,1141:2016))); 
    for k=1141:2016
        X=X+G1(k)*k;
    end
    for s=1:3456
        Y=Y+s*G3(s);
    end
    C(1,2)=Y/S;
    C(2,2)=X/S;

    Y=0;X=0;
    S=sum(sum(G(:,2017:3200))); 
    for k=2017:3200
        X=X+G1(k)*k;
    end
    for s=1:3456
        Y=Y+s*G4(s);
    end
    C(1,3)=Y/S;
    C(2,3)=X/S;    

Y=0;X=0;
    S=sum(sum(G(:,3201:4056))); 
    for k=3201:4056
        X=X+G1(k)*k;
    end
    for s=1:3456
        Y=Y+s*G5(s);
    end
    C(1,4)=Y/S;
    C(2,4)=X/S;


Y=0;X=0;
    S=sum(sum(G(:,4057:4760))); 
    for k=4057:4760
        X=X+G1(k)*k;
    end
    for s=1:3456
        Y=Y+s*G6(s);
    end
    C(1,5)=Y/S;
    C(2,5)=X/S;