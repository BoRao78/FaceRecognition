clear all; close all; clc;

% addpath('F:/matlab_code/matlab_pro/deep_learning_toolbox/util');
load ../data/mnist_uint8;
addpath('../util');

train_x = double(train_x) / 255;    % transfer uint8 to double
test_x  = double(test_x)  / 255;
train_y = double(train_y);
test_y  = double(test_y);

%%  ex1 train a 100 hidden unit RBM and visualize its weights
dbn.sizes = [100];               % number of hidden unit 
opts.numepochs =   2;            % number of epoches
%opts.batchsize = 100;
opts.batchsize = 28;             % size of image (row or coloum)
opts.momentum  =   0;            
opts.alpha     =   1;

for i=1:3
dbn = dbnsetup(dbn, train_x, opts);

dbn = dbntrain(dbn, train_x, opts);


figure; visualize(dbn.rbm{1}.W', 1);   %  Visualize the RMB weights
end




% %%  ex2 train a 100-100-100 DBN and use its weights to initialize a NN
% dbn.sizes = [100 100 100];
% opts.numepochs =   5;
% %opts.batchsize = 100;
% opts.batchsize = 28;
% opts.momentum  =   0;
% opts.alpha     =   1;
% dbn = dbnsetup(dbn, train_x, opts);
% dbn = dbntrain(dbn, train_x, opts);
% 
% nn = dbnunfoldtonn(dbn);
% 
% nn.alpha  = 1;
% nn.lambda = 1e-4;
% opts.numepochs =  10;
% opts.batchsize = 20;
% 
% nn = nntrain(nn, train_x, train_y, opts);
% [er, bad] = nntest(nn, test_x, test_y);
% 
% %disp([num2str(er * 100) '% error']);
% printf('%5.2f% error', 100 * er)
% figure; visualize(nn.W{1}', 1);
