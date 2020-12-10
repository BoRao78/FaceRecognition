
function V=CILPP_V(train_data_c, P)
%P.hang,lie,simmat


% C_GG=P.C_GG;
% C_GI=P.C_GI;
% C_IG=P.C_IG;
% C_II=P.C_II;
% impostClass=P.impostClass;
% cost_m=P.cost_m;

num_train=P.num_train;
num_test=P.num_test;
%ALA = get_2D_ALA( train_data_m,P);
W=P.simmat;
D=diag(sum(W));
L=D-W;
X=train_data_c;
% G=(X*D*X'+0.0000001*eye(P.hang*P.lie))\(X*L*X');
G=(X*D*X'+0.0000001*eye(P.hang*P.lie))\(X*W*X');


[V1,D1]=eig(G);
[D_sort,Dindex]=sort(diag(D1),'descend'); 
V=V1(:,Dindex(1:size(D1,1)));


% show eign face
% figure(5)
% imshow(get_data_c2m(V1(:,1)*255,P.lie))




     