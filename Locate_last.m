function [py2,py1,px2,px1]=Locate_last(I)
[y,x,z]=size(I);
myI=double(I);
Blue_y=zeros(y,1);
Y_threshlow=5;
X_firrectify=3;
for i=1:y
    for j=1:x
        if((myI(i,j,1)<=48)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=200)&&(myI(i,j,3)>=80)))  
           Blue_y(i,1)= Blue_y(i,1)+1;     % ��ɫ���ص�ͳ��                    
        end  
    end       
end
[temp,MaxY]=max(Blue_y);
        if temp<=20
           msgbox('���ƶ�λ����','warning');
           pause;
        end
        py1=MaxY;
        while ((Blue_y(py1,1)>=Y_threshlow)&&(py1>1))%�ҵ�ͼƬ�ϱ߽�  %��ֵΪ5
             py1=py1-1;
        end   
        %PY1���洢�����ϱ߽�ֵ
        py2=MaxY;
        while ((Blue_y(py2,1)>=Y_threshlow)&&(py2<y))%��ֵΪ5
        py2=py2+1;
        end
X_threshhigh=(py2-py1)/15;%�����ֵ����Ҫ����������ȡ�Ĳ�ͼ������,�ʵ���߿ɿ����ţ�����Сͼ���ճɼ���̫��,ganrao
Blue_x=zeros(1,x);             % ��һ��ȷ��X����ĳ�������
for j=1:x
    for i=py1:py2
        if((myI(i,j,1)<=45)&&((myI(i,j,2)<=90)&&(myI(i,j,2)>=20))&&((myI(i,j,3)<=160)&&(myI(i,j,3)>=80)))      
            Blue_x(1,j)= Blue_x(1,j)+1;               
        end  
    end       
end
[temp,MaxX]=max(Blue_x);
          px1=MaxX-6*(py2-py1);
          if  px1<=1
              px1=1;
          end          
          while ((Blue_x(1,px1)<=X_threshhigh)&&(px1<x))%��ֵ
                px1=px1+1;
          end %ȷ����X���������   
          px2=MaxX+6*(py2-py1);
          if  px2>=x
              px2=x;
          end
          while ((Blue_x(1,px2)<=X_threshhigh)&&(px2>px1))%��ֵ
                px2=px2-1;
          end
% Y_firrectify=fix((PY2-PY1)/5);%�ʵ��������ֵ������ȷ��ת
% PY1=PY1-Y_firrectify;%�Գ������������,����
% PY2=PY2+Y_firrectify;%�Գ������������,����
% % IY=I(PY1:PY2,:,:);%��Y�����ͼƬ��ȡ
% PX1=PX1-X_firrectify;% �Գ������������
% PX2=PX2+X_firrectify;% �Գ������������
%  S=(py2-py1)*(px2-px1);
% if       S<=25000
%     threshold=50;
%     Y_secrectify=3;
%     X_secrectify=3;
% elseif S>25000&&S<=45000  
%     threshold=100;
%     Y_secrectify=-3;
%     X_secrectify=3;
% elseif S>45000&&S<=80000
%     threshold=200;
%     Y_secrectify=-3;
%     X_secrectify=3;
% elseif S>80000&&S<=150000
%     threshold=300;
%     Y_secrectify=-10;
%     X_secrectify=-10;
% elseif S>150000&&S<=400000
%     threshold=600;
%     Y_secrectify=-10;
%     X_secrectify=-10;
% else
%     threshold=1800;
%     Y_secrectify=-10;
%     X_secrectify=-10;
% end
Y_secrectify=15;
py1=py1+Y_secrectify;%�Գ�������Ľ�һ������
py2=py2-Y_secrectify;%�Գ�������Ľ�һ������
px1=px1+X_firrectify;%-X_secrectify;%�Գ�������Ľ�һ������
px2=px2;%+X_secrectify;%�Գ�������Ľ�һ������
if(px1<1)
    px1=1;
end
if(py1<1)
    py1=1;
end
if(px2>x)
    px2=x;
end
if(py2>y)
    py2=y;
end