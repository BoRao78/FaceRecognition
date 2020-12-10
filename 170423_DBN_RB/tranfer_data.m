clear

load ../data/mnist_uint8;
images=train_x';
for i=1:60000
    labels(i,1)=find(train_y(i,:)==1)-1;
end
save('mnist_uint8_new_train','images','labels');

clear
load ../data/mnist_uint8;
images = test_x';
for i=1:10000
    labels(i,1)=find(test_y(i,:)==1)-1;
end
save('mnist_uint8_new_test','images','labels');
