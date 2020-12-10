%% Step 1: one step
%clear; close all;
load /data/PIE/Pose05_60x60new
%data_c, data_label, data_m, hang, lie, max_dim, num_each_person
%hang=60;lie=60;
class_num=68;
new_num_person = 20;
data_c_d =zeros(hang*lie,new_num_person*class_num);
data_label_d = zeros(1,new_num_person*class_num);
data_m_d = zeros(hang,lie*new_num_person*class_num);
for i = 1:class_num
    ID = randperm(num_each_person);
    data_c_d(:,(1:new_num_person)+(i-1)*new_num_person) = data_c(:,ID(1:new_num_person)+(i-1)*num_each_person);
    data_label_d(1,(1:new_num_person)+(i-1)*new_num_person) = data_label(1,1+(i-1)*num_each_person);
    data_m_d=get_data_c2m_all(data_c_d,hang);
end
data_c = data_c_d;
data_m = data_m_d;
data_label = data_label_d;
num_each_person = new_num_person;

% data_m  convolution
convolu_hang = 40;
convolu_lie = 40;
convolu_step = 1;
convolu_num = (hang - convolu_hang + 1) * (lie - convolu_lie + 1);
data_con = zeros(convolu_hang,convolu_lie*num_each_person*class_num*convolu_num);
m = 0;
for k = 1:num_each_person*class_num
    for i = 1:hang - convolu_hang + 1
        for j = 1:lie - convolu_lie + 1
            data_con(:,(1:convolu_lie)+ m*convolu_lie) = data_m(i:i+convolu_hang-1,(j:j+convolu_lie-1)+(k-1)*lie);
            m = m+1;
        end
    end
end

num_each_person = num_each_person * convolu_num;
train_num= 10 * convolu_num;
test_num=num_each_person-train_num;
data_label_con = ones(1,class_num*num_each_person);
for i=1:class_num
    data_label_con(1,(1:num_each_person)+(i-1)*num_each_person) = i;
end


data_r=zeros(convolu_hang*convolu_lie,class_num*num_each_person);
train_data_r=zeros(convolu_hang*convolu_lie,class_num*train_num);
test_data_r=zeros(convolu_hang*convolu_lie,class_num*test_num);
train_label=zeros(1,class_num*train_num);
test_label=zeros(1,class_num*test_num);

for i=1:class_num*num_each_person
    for j=1:convolu_lie
        data_r((1:convolu_hang)+(j-1)*convolu_hang,i) = data_con(:,j+(i-1)*convolu_lie);
    end
end

for i=1:class_num
    ID=randperm(num_each_person);
    train_data_r(:,(1:train_num)+ (i-1)*train_num)=data_r(:,ID(1:train_num) + (i-1)*num_each_person);
    test_data_r(:,(1:test_num)+ (i-1)*test_num)=data_r(:,ID(train_num+1:num_each_person) + (i-1)*num_each_person);
    train_label((1:train_num)+ (i-1)*train_num)=data_label_con(ID(1:train_num) + (i-1)*num_each_person);
    test_label((1:test_num)+ (i-1)*test_num)=data_label_con(ID(train_num+1:num_each_person) + (i-1)*num_each_person);
end


fprintf(1,'Loading data ... \n');
%load '/data/AR_database_60_43';
%load 'Data_AR_100_60_43_label';
addpath(genpath(pwd));

class_num = 40;
num_image = (hang-convolu_hang+1)*(lie-convolu_lie+1);
image_train = 10;
image_test = 10;
train_num = num_image * image_train;
test_num = num_image * image_test;
hang = convolu_hang;
lie = convolu_lie;

train_x = train_data_r(:,1:train_num * class_num)';
test_x = test_data_r(:,1:test_num * class_num)';
train_label_x = train_label(:,1:train_num * class_num);
test_label_x = test_label(:,1:test_num * class_num);

%{
k1 = 10;
k2 = 11;
train_x = train_data_r(:,(1:train_num * class_num) + k1*train_num)';
test_x = test_data_r(:,(1:test_num * class_num) + k2*test_num)';
train_label_x = train_label(:,(1:train_num * class_num) + k1*train_num);
test_label_x = test_label(:,(1:test_num * class_num) + k2*test_num);
%}
%{
randID1 =randperm(1400);
randID2 =randperm(400);

train_x = train_data_r';
%train_x = whiten(train_x,1e-6);
train_x=train_x(randID1,:);
train_label=train_label(1,randID1);
test_x = test_data_r'; 
%test_x = whiten(test_x,1e-6);
test_x=test_x(randID2,:);
test_label=test_label(randID2);
%train_x = double(NewTrain_DAT') / 255;    % transfer uint8 to double
%test_x  = double(NewTest_DAT')  / 255;
%train_y = double(train_y);
%test_y  = double(test_y);
%}
%%  Train a 150 hidden unit RBM and visualize its weights
          
dbn.sizes = 169;   % number of hidden unit HX
opts.numepochs =   5;            % number of epoches HX
opts.batchsize =   10;             % number of samples each batch,  HX
opts.momentum  =   0;            
opts.alpha     =   0.005;

fprintf(1,'Setting DBN ... \n');
dbn = dbnsetup(dbn, train_x, opts);

fprintf(1,'Training DBN ... \n');
tic
dbn = dbntrain(dbn, train_x, opts);
toc
figure; 
 
visualize(dbn.rbm{1}.W', 1,hang,lie);   %  Visualize the RBM weights
% view = view_all(dbn);  %  Visualize all RMB weights
fprintf(1,'Computing features using DBN ... \n');
train_x_feature = dbnout(dbn,train_x,100); % Computing train feature using RBM, Gibbs Sampling number =100, HX
test_x_feature = dbnout(dbn,test_x,100); % Computing test feature using RBM, Gibbs Sampling number =100, HX

%load 'mnist_uint8_new_train'; % Load data with labels, HX
labels=train_label_x';
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
numClasses = class_num;     % Number of classes (MNIST images fall into 10 classes)

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

fprintf(1,'Testing DBN using Softmax ... \n');
%load mnist_uint8_new_test;
labels=test_label_x';
%labels(labels==99) = 100; % Remap 99 to 100
inputData = test_x_feature';


[pred] = softmaxPredict(softmaxModel, inputData);
acc = mean(labels(:) == pred(:));
fprintf('Accuracy: %0.3f%%\n', acc * 100);


for i = 1:class_num * image_test
    pred(1,(1:num_image)+(i-1)*num_image) = mode(pred(1,(1:num_image)+(i-1)*num_image)); 
end
acc = mean(labels(:) == pred(:));
fprintf('Image Combined Accuracy: %0.3f%%\n', acc * 100);


for i = 1:class_num
    pred(1,(1:test_num)+(i-1)*test_num) = mode(pred(1,(1:test_num)+(i-1)*test_num)); 
end
acc = mean(labels(:) == pred(:));
fprintf('Person Combined Accuracy: %0.3f%%\n', acc * 100);
