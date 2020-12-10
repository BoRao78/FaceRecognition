%% Step 1: one step
clear
close all
load /data/PIE/Pose05_60x60new
data_m=data_m/150;
data_c=data_c/150;
%data_c, data_label, data_m, hang, lie, max_dim, num_each_person

op.k =3;  op.s =1;
P.a=0.3;  P.c=0.05; 
P.k=5;  P.t=10; %LPP
P.hang=hang;P.lie=lie;

M=20;NG=10;I=20; NI=NG;

%% get_train_test_data
    c=max(data_label);
    randdata=randperm(c);
    rand_class_train=randdata(1:M);
    rand_class_test=randdata(1+M:I+M);
    
    Gtrain_data=[];Gtest_data=[];Gtrain_label=[];Gtest_label=[];   
    Gtrain_data_c=[];Gtest_data_c=[];
    imageID=randperm(num_each_person);        

for i=1:M        
        class_i=rand_class_train(i);
        this_data_m=data_m(:,(class_i-1)*num_each_person*lie+1:class_i*num_each_person*lie);
        this_data_c=data_c(:,(class_i-1)*num_each_person+1:class_i*num_each_person);
        this_data_c_rand=this_data_c(:,imageID);
        
    for j=1:NG
        Gtrain_data=[Gtrain_data  this_data_m(:,(imageID(j)-1)*lie+1: imageID(j)*lie)];
    end
    
    for k=NG+1:num_each_person
        Gtest_data=[Gtest_data  this_data_m(:,(imageID(k)-1)*lie+1: imageID(k)*lie)];
    end
        
        Gtrain_data_c=[Gtrain_data_c this_data_c_rand(:,1:NG)];
        Gtest_data_c=[Gtest_data_c this_data_c_rand(:,NG+1:num_each_person)];
        Gtrain_label=[Gtrain_label class_i*ones(1,NG)];
        Gtest_label=[Gtest_label class_i*ones(1,num_each_person-NG)];   
 
end

Itrain_data=[];Itest_data=[];Itrain_label=[];Itest_label=[]; 
Itrain_data_c=[]; Itest_data_c=[];

for i=1:I        
        class_i=rand_class_test(i);
        this_data_m=data_m(:,(class_i-1)*num_each_person*lie+1:class_i*num_each_person*lie);
        this_data_c=data_c(:,(class_i-1)*num_each_person+1:class_i*num_each_person);
        this_data_c_rand=this_data_c(:,imageID);
        
    for j=1:NI
        Itrain_data=[Itrain_data  this_data_m(:,(imageID(j)-1)*lie+1: imageID(j)*lie)];
    end
    
    for k=NI+1:num_each_person
        Itest_data=[Itest_data  this_data_m(:,(imageID(k)-1)*lie+1: imageID(k)*lie)];
    end
        
        Itrain_data_c=[Itrain_data_c this_data_c_rand(:,1:NI)];
        Itest_data_c=[Itest_data_c this_data_c_rand(:,NI+1:num_each_person)];
        Itrain_label=[Itrain_label class_i*ones(1,NI)];
        Itest_label=[Itest_label class_i*ones(1,num_each_person-NI)];   
 
end

   train_data=[Itrain_data Gtrain_data];
   train_data_c=[Itrain_data_c Gtrain_data_c];
   Itrain_label=zeros(1,I*NI);
   Gtrain_label=ones(1,M*NG);
   train_label=[Itrain_label Gtrain_label];

   test_data=[Itest_data Gtest_data];
   test_data_c=[Itest_data_c Gtest_data_c];
   Itest_label=zeros(1,I*(num_each_person-NI));
   Gtest_label=ones(1,M*(num_each_person-NG));
   test_label=[Itest_label Gtest_label];

%% ---------vectors--------------------------
  train_data_m=train_data;
  test_data_m=test_data;
  P.num_train=size(train_label,2);
  P.num_test=size(test_label,2);
  P.knn_mat = get_knn_mat( train_data_m, lie, P.k );  
  P.simmat=get_simmat( train_data_m,P);  % P.num_train, P.t,P.knn_mat,P.lie
  P.num_person=2;

%    V1=CIPCA_V(train_data_c, P);  %P.num_train
%    V2=CILDA_V(train_data_c, train_label, P); %P.hang,lie,num_person
%    V3=CILPP_V(train_data_c, P);  %P.hang,lie,simmat

   V4=CI2DPCA_V(train_data_m, P); %P.lie P.num_train
   V5=CI2DLDA_V(train_data_m, train_data_c, train_label, P); % P.hang   P.lie  P.num_person
   V6=CI2DLPP_V(train_data_m, P); % P.simmat  P.lie  P.num_train
   
%% recon figure data
 recon_dim1=[1 2 3 4 5 6 9 13 21 29 37 45 49 53 57 60]; %number of dimensionality 
 recon_dim2=[1 5 9 13 17 21 25 29 33 37 41 45 49 53 57 60];
 recon_dim3=[1 5 9 13 17 21 25 29 33 37 41 45 49 53 57 60];
  
 point=8;% blank interval
 column=1000*ones(P.hang,point);   %blank interval between two images in each row
 line=1000*ones(point,(P.lie+point)*size(recon_dim1,2));  %blank interval between two methods
 im1=[];im2=[];im3=[];

      
for dim_i=1:size(recon_dim1,2)
    
%2DPCA     
P.dim=recon_dim1(dim_i);   
      [train_feature4, test_feature4] = All2D_feature( train_data_m,test_data_m,V4,P);
      % P.num_train, P.num_test, P.lie, P.dim
     this_im4=train_feature4(:,1:P.dim)*pinv(V4(:,1:P.dim));
     this_im4=mat2gray(this_im4);
     im1=[im1 column this_im4];    
     
%2DLDA  
P.dim=recon_dim2(dim_i);  
      [train_feature5, test_feature5] = All2D_feature( train_data_m,test_data_m,V5,P);
      this_im5=train_feature5(:,1:P.dim)*pinv(V5(:,1:P.dim));
      this_im5=mat2gray(this_im5);
      im2=[im2 column this_im5];  
      
%2DLPP 
P.dim=recon_dim3(dim_i);  
      [train_feature6, test_feature6] = All2D_feature( train_data_m,test_data_m,V6,P);
      this_im6=train_feature6(:,1:P.dim)*pinv(V6(:,1:P.dim));
      this_im6=mat2gray(this_im6);
      im3=[im3 column this_im6];  
      
end
%%
 im_all=[im1;line;line;line;im2;line;line;line;im3;];
 imshow(im_all);
% text_size=17;
text(545,72,'(a)');
% text(276,154,'(b)','FontSize',text_size);  
text(545,154,'(b)')
text(545,238,'(c)');