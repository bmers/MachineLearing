function [PY2,PY1,PX2,PX1]=Pre_Process(I)
[y,x,z]=size(I);
myI=double(I);
Y_threshlow=5;
X_firrectify=5;
%%%=============================���з���y��������ͳ��=========================
Blue_y=zeros(y,1);
for i=1:y
    for j=1:x
        if((myI(i,j,1)<=48)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=200)&&(myI(i,j,3)>=80)))  
           Blue_y(i,1)= Blue_y(i,1)+1;     % ��ɫ���ص�ͳ��                    
        end  
    end       
end
%%%y������ȷ��
[temp MaxY]=max(Blue_y);% Y����������ȷ�� temp(������):�������У������ۻ����ص� MaxY�����������У�:������������ࡿ
PY1=MaxY;%�����������и���PY1
while ((Blue_y(PY1,1)>=Y_threshlow)&&(PY1>1))%�ҵ�ͼƬ�ϱ߽�
    PY1=PY1-1;
end
%PY1���洢�����ϱ߽�ֵ
PY2=MaxY;
while ((Blue_y(PY2,1)>=Y_threshlow)&&(PY2<y))%��ֵΪ5
    PY2=PY2+1;
end
%%%=============================���з���x��������ͳ��=========================
 Blue_x=zeros(1,x);             % ��һ��ȷ��X����ĳ�������
 X_threshhigh=(PY2-PY1)/11;
for j=1:x
    for i=PY1:PY2
        if((myI(i,j,1)<=65)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=160)&&(myI(i,j,3)>=90)))%������82�޸ĳ�90.��ΪͼƬ20090504809   
         Blue_x(1,j)= Blue_x(1,j)+1;               
        end  
    end       
end
[temp,MaxX]=max(Blue_x);
PX1=MaxX-6*(PY2-PY1);
if  PX1<=1
    PX1=1;
end
while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))%��ֵ
      PX1=PX1+1;
end %ȷ����X���������   
PX2=MaxX+6*(PY2-PY1);
if  PX2>=x
    PX2=x;
end
while ((Blue_x(1,PX2)<=X_threshhigh)&&(PX2>PX1))%��ֵ
       PX2=PX2-1;
end
Y_firrectify=fix((PY2-PY1)/5);%�ʵ��������ֵ������ȷ��ת
PY1=PY1-Y_firrectify;%�Գ������������,����
PY2=PY2+Y_firrectify;%�Գ������������,����
% IY=I(PY1:PY2,:,:);%��Y�����ͼƬ��ȡ
PX1=PX1-X_firrectify;% �Գ������������
PX2=PX2+X_firrectify;% �Գ������������
if(PX1<1)
    PX1=1;
end
if(PY1<1)
    PY1=1;
end
if(PX2>x)
    PX2=x;
end
if(PY2>y)
    PY2=y;
end