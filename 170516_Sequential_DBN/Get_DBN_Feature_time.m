train_x = train_data_r(:,1:train_num * class_num)';
test_x = test_data_r(:,1:test_num * class_num)';
train_label_time = train_label(:,1:train_num * class_num);
test_label_time = test_label(:,1:test_num * class_num);

m1 = size(train_x,1);
m2 = size(test_x,1);
k = 10; 
ID = randperm(m1);
train_x = train_x(ID(1:k*m1/80),:);
train_label_time = train_label_time(:,(ID(1:k*m1/80)));
ID = randperm(m2);
test_x = test_x(ID(1:k*m2/80),:);
test_label_time = test_label_time(:,(ID(1:k*m2/80)));

%%  Train a 150 hidden unit RBM and visualize its weights
          
dbn.sizes = 169;   % number of hidden unit HX   %%%%%%%%%% attention %%%%%%%%%
opts.numepochs =   now_dim;            % number of epoches HX
opts.batchsize =   8;             % number of samples each batch,  HX
opts.momentum  =   0;            
opts.alpha     =   0.005;

%fprintf(1,'Setting DBN ... \n');
dbn = dbnsetup(dbn, train_x, opts);

%fprintf(1,'Training DBN ... \n');
%tic
printflag = 0;
dbn = dbntrain(dbn, train_x, opts,printflag);
%toc
%figure; 
 
%visualize(dbn.rbm{1}.W', 1,hang,lie);   %  Visualize the RBM weights
% view = view_all(dbn);  %  Visualize all RMB weights
%fprintf(1,'Computing features using DBN ... \n');
train_feature_time = dbnout(dbn,train_x,100); % Computing train feature using RBM, Gibbs Sampling number =100, HX
test_feature_time = dbnout(dbn,test_x,100); % Computing test feature using RBM, Gibbs Sampling number =100, HX
