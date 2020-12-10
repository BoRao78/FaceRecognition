% minist 
% clear
% load mnist_uint8_new_train;
% train_x=images;
% train_label=labels;
% train_label(train_label==0) = 10;
% clear images; clear labels;
% load mnist_uint8_new_test;
% test_x=images;
% test_label=labels;
% test_label(test_label==0) = 10;
% numClasses=10; hang=28;lie=28;
% save('mnist_train_test','train_x','test_x','train_label','test_label','numClasses','hang','lie');

% feret
clear
%load feret_28_28_m_c;
load c:\data\feret_10_10_m_c;
[train_data train_label test_data test_label] = get_train_test_data( data_c,data_label,0.8,num_each_person );
train_x=train_data;
test_x=test_data;
train_label=train_label';
test_label=test_label';
numClasses=200;% hang=128;lie=128;
save('c:\data\feret_train_test_10_10','train_x','test_x','train_label','test_label','numClasses','hang','lie');