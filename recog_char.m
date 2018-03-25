function char_recog=recog_char(hanzi,xiuzhenghanzi)
[y,x,z]=size(xiuzhenghanzi);
for k=1:5
sum=0;
for i=1:y
    for j=1:x
         if  hanzi(i,j,k)==xiuzhenghanzi(i,j)%Í³¼ÆºÚ°×
             sum=sum+1;
        end
    end
end
baifenbi(1,k)=sum/(x*y);
end
chepai= find(baifenbi>=max(baifenbi));
shibiehanzi=chepai;
if       shibiehanzi==1
         shibiehanzi='¹ğ';
    elseif shibiehanzi==2
         shibiehanzi='´¨';
%     elseif shibiehanzi==3
%          shibiehanzi='¾©';
%     elseif shibiehanzi==4
%          shibiehanzi='ËÕ';
%     elseif shibiehanzi==5
%          shibiehanzi='ÔÁ';
end