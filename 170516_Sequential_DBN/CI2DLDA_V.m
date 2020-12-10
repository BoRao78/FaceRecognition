
function V=CI2DLDA_V(train_data_m, train_data_c, train_label, P)
% P.hang   P.lie  P.num_person
% P is unnecessary
num_person=P.num_person;

hang=P.hang;
lie=P.lie;
% C_GG=P.C_GG;
% C_GI=P.C_GI;
% C_IG=P.C_IG;
% C_II=P.C_II;
% impostClass=P.impostClass;
% cost_m=P.cost_m;
% num_train=P.num_train;
% num_test=P.num_test;


%% Computing Sb matirx
   
  
   Ni=zeros(num_person,num_person);
   person_label= unique(train_label);
   Ni_index=cell(1,num_person);   
   mean_Ni=zeros(hang,lie*num_person);
   
   Sb=zeros(lie,lie);
   for i=1:num_person
       Ni_index{1,i}=find(train_label==person_label(i));
       Ni(i,i)=length(Ni_index{1,i});    
       this_mean_Ni_c=mean(train_data_c(:,Ni_index{1,i}),2);
       mean_Ni(:,(i-1)*lie+1:i*lie)=get_data_c2m(this_mean_Ni_c,lie);       
   end
   for i=1:num_person
       for j=1:num_person
           diff_m=mean_Ni(:,(i-1)*lie+1:i*lie)-mean_Ni(:,(j-1)*lie+1:j*lie);
           this_matrix=Ni(i,i)*Ni(j,j)*(diff_m'*diff_m);
           %this_matrix=diff_m'*diff_m;
           Sb=Sb+this_matrix;
       end
   end
 
   %% Computing Sw matirx
   Sw=zeros(lie,lie);
   for k=1:num_person
       mean_Ak=mean_Ni(:,(k-1)*lie+1:k*lie);
     %  scost=sum(cost_m(k,:));
       this_matrix=zeros(lie,lie);     
           
           for j=1:Ni(k,k)               
               Aj=train_data_m(:,(Ni_index{1,k}(j)-1)*lie+1:Ni_index{1,k}(j)*lie);
               this_matrix=this_matrix+(Aj-mean_Ak)'*(Aj-mean_Ak);
           end
     
       Sw=Sw+this_matrix;
   end
   %  temp2=Sw*Sb-(Sw*Sb)'
%    temp2=inv(Sw)*Sb-(Sw\Sb)
%    pause
   [V,D]=eig(Sw\Sb);  
%   [V,D]=eig((0.0001*eye(P.lie))+Sw\Sb);
%  [V,D]=eig(Sb-Sw);
%    temp1=V(:,1)'*V(:,2)
%    pause  
   [D_sort,Dindex]=sort(diag(D),'descend');  
   temp=V(:,Dindex(1:size(Sw,1)));
   V=temp;
  
   %% Feature extraction and testing
%    X=V(:,P.start_dim:P.start_dim+low_dim-1);
%    train_feature=[];
%    for i=1:num_train
%        this_feature=train_data_m(:,(i-1)*lie+1:i*lie)*X;
%        train_feature=[train_feature this_feature];
%    end
%    clear this_feature;
%    test_feature=[];
%    for i=1:num_test
%        this_feature=test_data_m(:,(i-1)*lie+1:i*lie)*X;
%        test_feature=[test_feature this_feature];
%    end


%    temp=X*X'
%    pause
%    im=get_i_image(train_feature,1,low_dim)*pinv(X);
%    imshow(im);
   
   

   
 
   