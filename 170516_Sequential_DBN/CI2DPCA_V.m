
function V=CI2DPCA_V(train_data_m, P)
% P.lie P.num_train
% the others of P are unnecessary

% % hang=P.hang;
lie=P.lie;
% % C_GG=P.C_GG;
% % C_GI=P.C_GI;
% % C_IG=P.C_IG;
% % C_II=P.C_II;
% % impostClass=P.impostClass;
% % cost_m=P.cost_m;
num_train=P.num_train;
% % num_test=P.num_test;

% Compute the cost-sensitive 2D covariance matrix
     Gt = zeros(lie, lie);
     for i=1:num_train
         for j=1:num_train
             diff=train_data_m(:,(i-1)*lie+1:i*lie)-train_data_m(:,(j-1)*lie+1:j*lie);
             cov=diff'*diff;
             Gt=Gt+cov;         
         end
     end
     
[V1,D1]=eig(Gt);
[D_sort,Dindex]=sort(diag(D1),'descend');  
V=V1(:,Dindex(1:size(D1,1)));

% P.low_2DPCA_dim=5;
% X=V(:,1:P.low_2DPCA_dim);       % Cost Sensitive 2D principal component
% train_feature=[];
% for i=1:num_train
%     train_feature=[train_feature train_data_m(:,(i-1)*lie+1:i*lie)*X];
% end
% % test_feature=[];
% % for i=1:num_test
% %     test_feature=[test_feature test_data_m(:,(i-1)*lie+1:i*lie)*X];
% % end
% 
% 
% %Show original image and the reconstructed image (select No. 5 image for example)
% i=5;
% 
% recon=train_feature(:,(i-1)*P.low_2DPCA_dim+1:i*P.low_2DPCA_dim)*X';
% figure(3);
% imshow(recon)
% orgin=train_data_m(:,(i-1)*lie+1:i*lie);
% figure(4);
% imshow(orgin)
% pause


     