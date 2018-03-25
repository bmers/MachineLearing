function [PY2,PY1,PX2,PX1]=Pre_Process2(I)
i1=rgb2gray(I);%灰度化
i2=edge(i1,'roberts');%边缘检测
% i2=edge(i1,'canny');%边缘检测
% imshow(i2);
se=[1;1;1];%列腐蚀算子，腐蚀算子的形状很重要
i3=imerode(i2,se);%此腐蚀可将非车牌区域的噪声信息腐蚀掉
% figure,imshow(i3);
se1=strel('rectangle',[25,25]);%方形闭环算子
i4=imclose(i3,se1);%闭环运算 需要选择大的算子
% figure,imshow(i4);
i5=bwareaopen(i4,1500);%将连通域面积小于1500像素的区域都删除，此方法是为了把除车牌以外的区域都删除
% figure,imshow(i5);

[y,x,z]=size(i5);
i6=double(i5);
Y1=zeros(y,1);

%尝试游程统计，找出连续1个数最多的
for ii = 1:y
tt = [diff(find(i6(ii,:)==1)) 2];
lianxu=max(diff([0 find(tt~=1)]));
Y1(ii,1)=lianxu;
end

% %统计每行1的个数
% for ii=1:y%统计每一行的像素值为1的个数
%     for jj=1:x
%         if(i6(ii,jj,1)==1)
%             Y1(ii,1)=Y1(ii,1)+1;
%         end
%     end
% end

[temp,MaxY]=max(Y1);%temp为Y1的最大值，MaxY为其所在的行数
% figure,plot(1:y,Y1);
PY1=MaxY;
while((Y1(PY1,1)>=(temp*0.4))&&(PY1>1))%求车牌上边界   %(Y1(PY1,1)>=50
    PY1=PY1-1;
end
PY2=MaxY;
while((Y1(PY2,1)>=(temp*0.4))&&(PY2<y))%求车牌下边界
    PY2=PY2+1;
end

X1=zeros(1,x);
for jj=1:x%统计每一列的像素值为1的个数，只统计车牌上下边界之间的像素数
    for ii=PY1:PY2
        if(i6(ii,jj,1)==1)
            X1(1,jj)=X1(1,jj)+1;
        end
    end
end
% figure,plot(1:x,X1);

PX1=1;
while((X1(1,PX1)<15)&&(PX1<x))%求车牌左边界
    PX1=PX1+1;
end
PX2=x;
while((X1(1,PX2)<15)&&(PX2>PX1))%求车牌右边界
    PX2=PX2-1;
end
PX1=PX1-1;
PX2=PX2+1;
X_firrectify=10;
Y_firrectify=fix((PY2-PY1));%适当扩大这个值可以正确旋转
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