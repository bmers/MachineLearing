function divimag=char_div(I)
[y,x]=size(I);
blacksum=sum(~I);
k=1;
for i=1:x-1
    if  ((blacksum(1,i)<=4)&&(blacksum(1,i+1)>4))||((i==1)&&blacksum(1,i)>4)
            divimag(k)=i;
            k=k+1;
    elseif ((blacksum(1,i)>4)&&(blacksum(1,i+1)<=4))||((i==x-1)&&blacksum(1,i)>4)
                divimag(k)=i+1;
                k=k+1;
    end
end
k=k-1;
% if k>14
%     divimag=[divimag(1) divimag(6:end)];
% end