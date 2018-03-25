function [py2,py1,px2,px1]=Locate_last(I)
[y,x,z]=size(I);
myI=double(I);
Blue_y=zeros(y,1);
Y_threshlow=5;
X_firrectify=3;
for i=1:y
    for j=1:x
        if((myI(i,j,1)<=48)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=200)&&(myI(i,j,3)>=80)))  
           Blue_y(i,1)= Blue_y(i,1)+1;     % 蓝色象素点统计                    
        end  
    end       
end
[temp,MaxY]=max(Blue_y);
        if temp<=20
           msgbox('车牌定位出错','warning');
           pause;
        end
        py1=MaxY;
        while ((Blue_y(py1,1)>=Y_threshlow)&&(py1>1))%找到图片上边界  %阈值为5
             py1=py1-1;
        end   
        %PY1：存储车牌上边界值
        py2=MaxY;
        while ((Blue_y(py2,1)>=Y_threshlow)&&(py2<y))%阈值为5
        py2=py2+1;
        end
X_threshhigh=(py2-py1)/15;%这个数值很重要。决定了提取的彩图的质量,适当提高可抗干扰，但是小图会照成剪裁太多,ganrao
Blue_x=zeros(1,x);             % 进一步确定X方向的车牌区域
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
          while ((Blue_x(1,px1)<=X_threshhigh)&&(px1<x))%阈值
                px1=px1+1;
          end %确定出X方向车牌起点   
          px2=MaxX+6*(py2-py1);
          if  px2>=x
              px2=x;
          end
          while ((Blue_x(1,px2)<=X_threshhigh)&&(px2>px1))%阈值
                px2=px2-1;
          end
% Y_firrectify=fix((PY2-PY1)/5);%适当扩大这个值可以正确旋转
% PY1=PY1-Y_firrectify;%对车牌区域的修正,向上
% PY2=PY2+Y_firrectify;%对车牌区域的修正,向下
% % IY=I(PY1:PY2,:,:);%在Y方向对图片截取
% PX1=PX1-X_firrectify;% 对车牌区域的修正
% PX2=PX2+X_firrectify;% 对车牌区域的修正
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
py1=py1+Y_secrectify;%对车牌区域的进一步修正
py2=py2-Y_secrectify;%对车牌区域的进一步修正
px1=px1+X_firrectify;%-X_secrectify;%对车牌区域的进一步修正
px2=px2;%+X_secrectify;%对车牌区域的进一步修正
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