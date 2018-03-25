function [PY2,PY1,PX2,PX1]=Pre_Process(I)
[y,x,z]=size(I);
myI=double(I);
Y_threshlow=5;
X_firrectify=5;
%%%=============================对行方向y进行像素统计=========================
Blue_y=zeros(y,1);
for i=1:y
    for j=1:x
        if((myI(i,j,1)<=48)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=200)&&(myI(i,j,3)>=80)))  
           Blue_y(i,1)= Blue_y(i,1)+1;     % 蓝色象素点统计                    
        end  
    end       
end
%%%y方向车牌确定
[temp MaxY]=max(Blue_y);% Y方向车牌区域确定 temp(最多点数):所有行中，最多的累积像素点 MaxY（最多点所在行）:该行中蓝点最多】
PY1=MaxY;%有最多蓝点的行付给PY1
while ((Blue_y(PY1,1)>=Y_threshlow)&&(PY1>1))%找到图片上边界
    PY1=PY1-1;
end
%PY1：存储车牌上边界值
PY2=MaxY;
while ((Blue_y(PY2,1)>=Y_threshlow)&&(PY2<y))%阈值为5
    PY2=PY2+1;
end
%%%=============================对列方向x进行像素统计=========================
 Blue_x=zeros(1,x);             % 进一步确定X方向的车牌区域
 X_threshhigh=(PY2-PY1)/11;
for j=1:x
    for i=PY1:PY2
        if((myI(i,j,1)<=65)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=160)&&(myI(i,j,3)>=90)))%这里由82修改成90.因为图片20090504809   
         Blue_x(1,j)= Blue_x(1,j)+1;               
        end  
    end       
end
[temp,MaxX]=max(Blue_x);
PX1=MaxX-6*(PY2-PY1);
if  PX1<=1
    PX1=1;
end
while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))%阈值
      PX1=PX1+1;
end %确定出X方向车牌起点   
PX2=MaxX+6*(PY2-PY1);
if  PX2>=x
    PX2=x;
end
while ((Blue_x(1,PX2)<=X_threshhigh)&&(PX2>PX1))%阈值
       PX2=PX2-1;
end
Y_firrectify=fix((PY2-PY1)/5);%适当扩大这个值可以正确旋转
PY1=PY1-Y_firrectify;%对车牌区域的修正,向上
PY2=PY2+Y_firrectify;%对车牌区域的修正,向下
% IY=I(PY1:PY2,:,:);%在Y方向对图片截取
PX1=PX1-X_firrectify;% 对车牌区域的修正
PX2=PX2+X_firrectify;% 对车牌区域的修正
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