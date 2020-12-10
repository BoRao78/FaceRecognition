image=zeros(60,43);
for i=1:43
    image(:,i)=data_r((1:60)+(i-1)*60,1);
end
figure;
imshow(image);