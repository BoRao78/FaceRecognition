clear all; close all; clc;

fprintf(1,'Loading data ... \n');
%load '/data/AR_database_60_43';
load 'Data_AR_100_60_43_label';
addpath(genpath(pwd));

train_x = train_data_r'; 
test_x = test_data_r'; 

%train_x = double(NewTrain_DAT') / 255;    % transfer uint8 to double
%test_x  = double(NewTest_DAT')  / 255;
%train_y = double(train_y);
%test_y  = double(test_y);

%%  Train a 150 hidden unit RBM and visualize its weights
          
dbn.sizes = 150;   % number of hidden unit HX
opts.numepochs =   5;            % number of epoches HX
opts.batchsize =   10;             % number of samples each batch,  HX
opts.momentum  =   0;            
opts.alpha     =   1;

fprintf(1,'Setting DBN ... \n');
dbn = dbnsetup(dbn, train_x, opts);

fprintf(1,'Training DBN ... \n');
tic
dbn = dbntrain(dbn, train_x, opts);
toc
figure; 
 
visualize(dbn.rbm{1}.W', 1,60,43);   %  Visualize the RBM weights
% view = view_all(dbn);  %  Visualize all RMB weights
fprintf(1,'Computing features using DBN ... \n');
train_x_feature = dbnout(dbn,train_x,100); % Computing train feature using RBM, Gibbs Sampling number =100, HX
test_x_feature = dbnout(dbn,test_x,100); % Computing test feature using RBM, Gibbs Sampling number =100, HX

%load 'mnist_uint8_new_train'; % Load data with labels, HX
labels=train_label;
%labels(labels==99) = 100; % Remap 99 to 100
inputData = train_x_feature';

% For debugging purposes, you may wish to reduce the size of the input data
% in order to speed up gradient checking. 
% Here, we create synthetic dataset using random data for testing

DEBUG = false; % Set DEBUG to true when debugging.
if DEBUG
    inputSize = 8;
    inputData = randn(8, 100);
    labels = randi(10, 100, 1);
end

inputSize = dbn.sizes(1,end); % inputSize equals to the last layer (considering multi-layers), HX
numClasses = 100;     % Number of classes (MNIST images fall into 10 classes)

lambda = 1e-4; % Weight decay parameter

% Randomly initialise theta
theta = 0.005 * randn(numClasses * inputSize, 1);

%%======================================================================
%% STEP 2: Implement softmaxCost
%
%  Implement softmaxCost in softmaxCost.m. 
fprintf(1,'Training Softmax ... \n');
[cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, inputData, labels);
                                     
%%======================================================================
%% STEP 3: Gradient checking
%
%  As with any learning algorithm, you should always check that your
%  gradients are correct before learning the parameters.
% 

if DEBUG
    numGrad = computeNumericalGradient( @(x) softmaxCost(x, numClasses, ...
                                    inputSize, lambda, inputData, labels), theta);

    % Use this to visually compare the gradients side by side
    disp([numGrad grad]); 

    % Compare numerically computed gradients with those computed analytically
    diff = norm(numGrad-grad)/norm(numGrad+grad);
    disp(diff); 
    % The difference should be small. 
    % In our implementation, these values are usually less than 1e-7.

    % When your gradients are correct, congratulations!
end

%%======================================================================
%% STEP 4: Learning parameters
%
%  Once you have verified that your gradients are correct, 
%  you can start training your softmax regression code using softmaxTrain
%  (which uses minFunc).
options.maxIter = 100;
softmaxModel = softmaxTrain(inputSize, numClasses, lambda, ...
                            inputData, labels, options);
%save('softmaxModel','softmaxModel');                          
% Although we only use 100 iterations here to train a classifier for the 
% MNIST data set, in practice, training for more iterations is usually
% beneficial.

%%======================================================================
%% STEP 5: Testing
%
%  You should now test your model against the test images.
%  To do this, you will first need to write softmaxPredict
%  (in softmaxPredict.m), which should return predictions
%  given a softmax model and the input data.

%load test_x_feature_200_200;

fprintf(1,'Testing DBN using Softmax ... \n');
%load mnist_uint8_new_test;
labels=test_label;
%labels(labels==99) = 100; % Remap 99 to 100
inputData = test_x_feature';




% You will have to implement softmaxPredict in softmaxPredict.m


[pred] = softmaxPredict(softmaxModel, inputData);
acc = mean(labels(:) == pred(:));
fprintf('Accuracy: %0.3f%%\n', acc * 100);

%% cost_AS= misClassCost(labels, pred',C_GG,C_GI,C_IG,impostClass)  % For cost-sensitive learning HX
% 
% [pred] = softmaxPredict_CS(softmaxModel, inputData, C_GG,C_GI,C_IG,impostClass);
% acc = mean(labels(:) == pred(:));
% fprintf('Accuracy: %0.3f%%\n', acc * 100);
% cost_CS = misClassCost(labels, pred',C_GG,C_GI,C_IG,impostClass)

%% Accuracy is the proportion of correctly classified images
% After 100 iterations, the results for our implementation were:
%
% Accuracy: 92.200%
%
% If your values are too low (accuracy less than 0.91), you should check 
% your code for errors, and make sure you are training on the 
% entire data set of 60000 28x28 training images 
% (unless you modified the loading code, this should be the case)



