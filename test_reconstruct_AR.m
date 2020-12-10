%load dbn_AR_100
%load dbn_AR_last30_100
load dbn_AR_2000_1000_500_30_eproach100
load 'C:\data\AR_database_60_43';
start=30;
last=35;
number=last-start;
train_x=NewTrain_DAT';
y=dbnout(dbn,double(train_x(start:last,:)/255),2000);
y=dbnreconstruct(dbn,y,2000);


for i=1:number+1
    figure(i);
     subplot(2,1,1);
imshow(reshape(y(i,:),60,43));


subplot(2,1,2);
imshow(reshape(train_x(start+i-1,:),60,43))
end

err=sum((y-double(train_x(start:last,:))/255).^2,2)


