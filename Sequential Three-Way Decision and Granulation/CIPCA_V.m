function V=CIPCA_V(train_data_c, P)
%   P.num_train
num_train=P.num_train;

X=train_data_c;
R=X'*X;
[V1,D1]=eig(R);
[D_sort,Dindex]=sort(diag(D1),'descend');  
V2=V1(:,Dindex(1:size(R,1)));
%D2=D1(:,Dindex(1:size(R,1)));
V=X*V2; 
for j=1:num_train
    V_u(:,j)=V(:,j)/normest(V(:,j));
end
V=V_u;
