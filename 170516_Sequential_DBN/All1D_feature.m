function [train_feature, test_feature] = All1D_feature( train_data_c,test_data_c,V,P)
% P.dim_1D
  
W=V(:,1:P.dim_1D);
% [wr,wc]=size(W)
% [tr,tc]=size(train_data_c)
train_fea=W'*train_data_c;
test_fea=W'*test_data_c;
train_feature=real(train_fea); % train_fea: complex data
test_feature=real(test_fea);  % test_fea: complex data
