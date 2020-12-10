%load dbn_AR_100
%load dbn_AR_last30_100
load dbn_STL_400
load stlSampledPatches_firstChannel;
start=30;
last=35;
number=last-start;
%train_x=NewTrain_DAT';
y=dbnout(dbn,double(train_x(start:last,:)),1000);
y=dbnreconstruct(dbn,y,1000);


for i=1:number+1
    figure(i);
     subplot(2,1,1);
imshow(reshape(y(i,:),8,8));


subplot(2,1,2);
imshow(reshape(train_x(start+i-1,:),8,8))
end

err=sum((y-double(train_x(start:last,:))/255).^2,2)


