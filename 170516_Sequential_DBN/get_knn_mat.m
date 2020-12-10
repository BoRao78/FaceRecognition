function knn_mat = get_knn_mat( train_data_m, lie, k )
%delete get_i_image
[n,c]=size(train_data_m);
N=c/lie;
knn_mat=zeros(k+1,N);
for i=1:N
%     this_x=get_i_image(train_data_m,i,lie);
    this_x=train_data_m(:,(i-1)*lie+1:i*lie);
    x_m=repmat(this_x,1,N);
    
if lie==1 && n==1 %---------new
    dist=(train_data_m-x_m).^2; %if the trainfeature of an image is a number
elseif lie==1 
    dist=sum((train_data_m-x_m).^2); %every image is a column vector
elseif n==1
     dist=sum(reshape((train_data_m-x_m).^2, lie, N)); %every image is a row vector
else
    diff2=sum((train_data_m-x_m).^2); %every image minus the i-th image, then square all the elements, sum by column
    dist=sum(reshape(diff2,lie, N));
    %b=reshape(a,hang,lie): b(:,1)=a(1:hang), reshape the matrix by column
end
    
    [m_dis, index]=sort(dist);
    knn_mat(:,i)=index(1:k+1)';
end
knn_mat(1,:)=[];