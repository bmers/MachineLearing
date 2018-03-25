function Province_car=recog_word(hanzi,xiuzhenghanzi)
[y,x,z]=size(xiuzhenghanzi);
for k=1:7
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
Province_car=chepai;
if       Province_car==1
         Province_car='¹ð';
    elseif Province_car==2
         Province_car='´¨';
    elseif Province_car==3
         Province_car='Â³';
end