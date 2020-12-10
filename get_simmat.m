function simmat = get_simmat( train_data_m,P)
%P.num_train, P.t,P.knn_mat,P.lie
%delete get_i_image
lie_num=P.lie;
simmat=zeros(P.num_train,P.num_train);
for i=1:P.num_train
    for j=1:P.num_train
    if ismember(i,P.knn_mat(:,j))==1 || ismember(j,P.knn_mat(:,i))==1
%         Ai=get_i_image(train_data_m,i,P.lie);
%         Aj=get_i_image(train_data_m,j,P.lie);
        Ai=train_data_m(:,(i-1)*lie_num+1:i*lie_num);
        Aj=train_data_m(:,(j-1)*lie_num+1:j*lie_num);
        simmat(i,j)=exp(-norm(Ai-Aj)^2/P.t^2);
    end
    end
end



