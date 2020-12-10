load dbn_35
 load ../data/mnist_uint8;
start=30;
last=35;
number=last-start;
y=dbnout(dbn,double(train_x(start:last,:)/255),100);
y=dbnreconstruct(dbn,y,100);


for i=1:number+1
    figure(i);
     subplot(2,1,1);
imshow(reshape(y(i,:),28,28));


subplot(2,1,2);
imshow(reshape(train_x(start+i-1,:),28,28))
end

err=sum((y-double(train_x(start:last,:))/255).^2,2)


