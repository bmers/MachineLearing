function [PY2,PY1,PX2,PX1]=Pre_Process2(I)
i1=rgb2gray(I);%�ҶȻ�
i2=edge(i1,'roberts');%��Ե���
% i2=edge(i1,'canny');%��Ե���
% imshow(i2);
se=[1;1;1];%�и�ʴ���ӣ���ʴ���ӵ���״����Ҫ
i3=imerode(i2,se);%�˸�ʴ�ɽ��ǳ��������������Ϣ��ʴ��
% figure,imshow(i3);
se1=strel('rectangle',[25,25]);%���αջ�����
i4=imclose(i3,se1);%�ջ����� ��Ҫѡ��������
% figure,imshow(i4);
i5=bwareaopen(i4,1500);%����ͨ�����С��1500���ص�����ɾ�����˷�����Ϊ�˰ѳ��������������ɾ��
% figure,imshow(i5);

[y,x,z]=size(i5);
i6=double(i5);
Y1=zeros(y,1);

%�����γ�ͳ�ƣ��ҳ�����1��������
for ii = 1:y
tt = [diff(find(i6(ii,:)==1)) 2];
lianxu=max(diff([0 find(tt~=1)]));
Y1(ii,1)=lianxu;
end

% %ͳ��ÿ��1�ĸ���
% for ii=1:y%ͳ��ÿһ�е�����ֵΪ1�ĸ���
%     for jj=1:x
%         if(i6(ii,jj,1)==1)
%             Y1(ii,1)=Y1(ii,1)+1;
%         end
%     end
% end

[temp,MaxY]=max(Y1);%tempΪY1�����ֵ��MaxYΪ�����ڵ�����
% figure,plot(1:y,Y1);
PY1=MaxY;
while((Y1(PY1,1)>=(temp*0.4))&&(PY1>1))%�����ϱ߽�   %(Y1(PY1,1)>=50
    PY1=PY1-1;
end
PY2=MaxY;
while((Y1(PY2,1)>=(temp*0.4))&&(PY2<y))%�����±߽�
    PY2=PY2+1;
end

X1=zeros(1,x);
for jj=1:x%ͳ��ÿһ�е�����ֵΪ1�ĸ�����ֻͳ�Ƴ������±߽�֮���������
    for ii=PY1:PY2
        if(i6(ii,jj,1)==1)
            X1(1,jj)=X1(1,jj)+1;
        end
    end
end
% figure,plot(1:x,X1);

PX1=1;
while((X1(1,PX1)<15)&&(PX1<x))%������߽�
    PX1=PX1+1;
end
PX2=x;
while((X1(1,PX2)<15)&&(PX2>PX1))%�����ұ߽�
    PX2=PX2-1;
end
PX1=PX1-1;
PX2=PX2+1;
X_firrectify=10;
Y_firrectify=fix((PY2-PY1));%�ʵ��������ֵ������ȷ��ת
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