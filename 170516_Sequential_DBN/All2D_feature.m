function [train_feature, test_feature] = All2D_feature( train_data_m,test_data_m,V,P)
% P.num_train, P.num_test, P.lie, P.dim
num_train=P.num_train;
num_test=P.num_test;
lie=P.lie;
X=V(:,1:P.dim);       % Cost Sensitive 2D principal component
train_feature=[];
for i=1:num_train
    train_feature=[train_feature train_data_m(:,(i-1)*lie+1:i*lie)*X];
end
test_feature=[];
for i=1:num_test
     test_feature=[test_feature test_data_m(:,(i-1)*lie+1:i*lie)*X];
end
train_feature=real(train_feature); % train_fea: complex data
test_feature=real(test_feature);  % test_fea: complex data


% Show original image and the reconstructed image (select No. 5 image for example)
% i=5;
% 
% recon=train_feature(:,(i-1)*P.low_2DPCA_dim+1:i*P.low_2DPCA_dim)*X';
% figure(1);
% imshow(recon)
% orgin=train_data_m(:,(i-1)*lie+1:i*lie);
% figure(2);
% imshow(orgin)
