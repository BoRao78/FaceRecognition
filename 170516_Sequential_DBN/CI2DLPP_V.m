
function V=CI2DLPP_V(train_data_m, P)
% P.simmat  P.lie  P.num_train
% P.hang P.num_test is unnecessary
% delete get_i_image

% hang=P.hang;
lie=P.lie;
% C_GG=P.C_GG;
% C_GI=P.C_GI;
% C_IG=P.C_IG;
% C_II=P.C_II;
% impostClass=P.impostClass;
% cost_m=P.cost_m;

num_train=P.num_train;
num_test=P.num_test;

S=P.simmat;
S=(S+S')/2;
ADA=zeros(P.lie,P.lie);
ASA=zeros(P.lie,P.lie);
for i=1:P.num_train
    Ai=train_data_m(:,(i-1)*lie+1:i*lie);    
    Di=sum(S(i,:));
    ADA=ADA+Ai'*Di*Ai;
end



for i=1:P.num_train
    Ai=train_data_m(:,(i-1)*lie+1:i*lie);    
    for j=1:P.num_train
        Aj=train_data_m(:,(j-1)*lie+1:j*lie);     
        ASA=ASA+Ai'*S(i,j)*Aj;
    end
end
% ADA
% ASA
 ALA=ADA-ASA;
%  G=ADA\ALA;

G=ASA\ALA;

[V1,D1]=eig(G);
[D_sort,Dindex]=sort(diag(D1),'descend'); 
V=V1(:,Dindex(1:size(D1,1)));



% P.low_2DPCA_dim=40;
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
%Show original image and the reconstructed image (select No. 5 image for example)
% i=5;
% P.low_2DPCA_dim
% recon=train_feature(:,(i-1)*P.low_2DPCA_dim+1:i*P.low_2DPCA_dim)*pinv(X);
% figure;
% imshow(recon)
% orgin=train_data_m(:,(i-1)*lie+1:i*lie);
% figure;
% imshow(orgin)
% pause


     