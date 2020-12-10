

% clear
% load dbn_200;
% load ../data/mnist_uint8;
% addpath('../util');
% train_x = double(train_x) / 255;    % transfer uint8 to double
% test_x  = double(test_x)  / 255;
% train_y = double(train_y);
% test_y  = double(test_y);
% 
% train_x_feature = dbnout(dbn,train_x,100);
% save('train_x_feature_200_100','train_x_feature');
% 
% 1111111111111
% clear
% load dbn_200;
% load ../data/mnist_uint8;
% addpath('../util');
% train_x = double(train_x) / 255;    % transfer uint8 to double
% test_x  = double(test_x)  / 255;
% train_y = double(train_y);
% test_y  = double(test_y);
% 
% train_x_feature = dbnout(dbn,train_x,200);
% save('train_x_feature_200_200','train_x_feature');



clear
load dbn_200;
load ../data/mnist_uint8;
addpath('../util');
train_x = double(train_x) / 255;    % transfer uint8 to double
test_x  = double(test_x)  / 255;
train_y = double(train_y);
test_y  = double(test_y);

test_x_feature = dbnout(dbn,test_x,100);
save('test_x_feature_200_100','test_x_feature');

1111111111111
clear
load dbn_200;
load ../data/mnist_uint8;
addpath('../util');
train_x = double(train_x) / 255;    % transfer uint8 to double
test_x  = double(test_x)  / 255;
train_y = double(train_y);
test_y  = double(test_y);

test_x_feature = dbnout(dbn,test_x,200);
save('test_x_feature_200_200','test_x_feature');



