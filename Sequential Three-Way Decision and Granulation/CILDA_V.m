function V=CILDA_V(train_data_c, train_label, P)
% P.hang, P.lie, P.num_person
%
%% Computing Sb matirx   
%fprintf('-----Computing Sb matirx...----\n');
   mean_all=mean(train_data_c,2);
   Ni=zeros(P.num_person,P.num_person);
   mean_Ni=zeros(P.hang*P.lie,P.num_person);
   person_label= unique(train_label);
   Ni_index=cell(1,P.num_person);
   for i=1:P.num_person
       Ni_index{1,i}=find(train_label==person_label(i));
       Ni(i,i)=length(Ni_index{1,i});       
       mean_Ni(:,i)=mean(train_data_c(:,Ni_index{1,i}),2);
   end

   mean_matrix=mean_Ni-repmat(mean_all,1,P.num_person);
   
   Sb=mean_matrix*Ni*mean_matrix';  
   
   
%% Computing Sw matirx
%fprintf('-----Computing Sw matirx...----\n');
   Sw=zeros(P.hang*P.lie,P.hang*P.lie);
   for i=1:P.num_person
       xi=train_data_c(:,Ni_index{1,i});    
       mean_matrix=xi-repmat(mean_Ni(:,i),1,Ni(i,i));
       this_Sw=mean_matrix*mean_matrix';   
       Sw=Sw+this_Sw;          
   end   
   
   [Vn,Dn]=eig((0.00001*eye(P.hang*P.lie)+Sw)\Sb);
  
   [D_sort,Dindex]=sort(diag(Dn),'descend');
  
   V=Vn(:,Dindex(1:end));
