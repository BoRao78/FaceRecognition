%% Step 1: one step
%clear;close all;
load /data/ar
%data_c, data_label, data_m, hang, lie, max_dim, num_each_person

op.k =3;  op.s =1;
P.a=0.3;  P.c=0.05; 
P.k=5;  P.t=10; %LPP
P.hang=hang;P.lie=lie;

cost_seting.C_10=20; % real '0', predict '1'
cost_seting.C_01=6;
cost_seting.C_B0=4;  % real '0', predict 'B'
cost_seting.C_B1=2;

cost_seting_b.C_10=1;
cost_seting_b.C_01=1;
cost_seting_b.C_B0=1;
cost_seting_b.C_B1=1;

M=15;NG=8;I=20; NI=NG; %NG,NI:number of samples for granular feature extraction 

%% get_train_test_data
max_dim=40; % Max Desicion Step
loop_num=3;
loop_err=zeros(6,max_dim); % 6: 3 method * 2 database
loop_cost=zeros(6,max_dim);
loop_P=zeros(6,max_dim);
loop_B=zeros(6,max_dim);
loop_N=zeros(6,max_dim);
loop_err_10=zeros(6,max_dim);
loop_err_01=zeros(6,max_dim);
loop_err_B0=zeros(6,max_dim);
loop_err_B1=zeros(6,max_dim);
% aaa=1:max_dim;
% test_cost=exp(0.05*aaa)/4-0.25;

for n_loop=1:loop_num
    n_loop
    
% get_train_test_data-------
    c=max(data_label);    % Number of persons
    randdata=randperm(c);  %sort in random for all people
    rand_class_train=randdata(1:M);  % M people for train(gallery subjects)  ???
    rand_class_test=randdata(M+1:M+I);   %I people for test(impostor)   ???
    
    Gtrain_data=[];Gtest_data=[];Gtrain_label=[];Gtest_label=[];   % G=Gallery
    Gtrain_data_c=[];Gtest_data_c=[];
    imageID=randperm(num_each_person);        

for i=1:M        
        class_i=rand_class_train(i);
        this_data_m=data_m(:,(class_i-1)*num_each_person*lie+1:class_i*num_each_person*lie);
        this_data_c=data_c(:,(class_i-1)*num_each_person+1:class_i*num_each_person);
        this_data_c_rand=this_data_c(:,imageID);% disorganize 14 images of each train person
        
    for j=1:NG
        Gtrain_data=[Gtrain_data  this_data_m(:,(imageID(j)-1)*lie+1: imageID(j)*lie)]; %totally M*NG
    end
    
    for k=NG+1:num_each_person
        Gtest_data=[Gtest_data  this_data_m(:,(imageID(k)-1)*lie+1: imageID(k)*lie)];
    end
        
        Gtrain_data_c=[Gtrain_data_c this_data_c_rand(:,1:NG)];
        Gtest_data_c=[Gtest_data_c this_data_c_rand(:,NG+1:num_each_person)];
        Gtrain_label=[Gtrain_label class_i*ones(1,NG)];
        Gtest_label=[Gtest_label class_i*ones(1,num_each_person-NG)];   
 
end

Itrain_data=[];Itest_data=[];Itrain_label=[];Itest_label=[];    %I=impostor
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
%以上把数据分为G、I两种人，train、test两种用途


   train_data=[Itrain_data Gtrain_data];
   train_data_c=[Itrain_data_c Gtrain_data_c];
   Itrain_label=zeros(1,I*NI);%???
   Gtrain_label=ones(1,M*NG);
   train_label=[Itrain_label Gtrain_label];

   test_data=[Itest_data Gtest_data];
   test_data_c=[Itest_data_c Gtest_data_c];
   Itest_label=zeros(1,I*(num_each_person-NI));
   Gtest_label=ones(1,M*(num_each_person-NG));
   test_label=[Itest_label Gtest_label];

%------------------------------------------------
  train_data_m=train_data;% ???
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
   
   err=zeros(6,max_dim);   cost=zeros(6,max_dim);
   PP=zeros(6,max_dim);   BB=zeros(6,max_dim);   NN=zeros(6,max_dim);
   err_10=zeros(6,max_dim);   err_01=zeros(6,max_dim);
   err_B0=zeros(6,max_dim);   err_B1=zeros(6,max_dim);
   
for low_dim=1:max_dim
% vectors and feature
    P.dim=low_dim;
    P.dim_1D=low_dim;

% % PCA
%       [train_feature1, test_feature1] = All1D_feature( train_data_c,test_data_c,V1,P);%P.dim_1D
%       [like_hood1, prior1]=ckNN_train(train_feature1', train_label', op); 
%       [result1, pred_label1]=ckNN_test(train_feature1', train_label', test_feature1', test_label', like_hood1, prior1, cost_seting, op);  
% %LDA   
%       [train_feature2, test_feature2] = All1D_feature( train_data_c,test_data_c,V2,P);
%       [like_hood2, prior2]=ckNN_train(train_feature2', train_label', op); 
%       [result2, pred_label2]=ckNN_test(train_feature2', train_label', test_feature2', test_label', like_hood2, prior2, cost_seting, op);     
% %LPP   
%       [train_feature3, test_feature3] = All1D_feature( train_data_c,test_data_c,V3,P);
%       [like_hood3, prior3]=ckNN_train(train_feature3', train_label', op); 
%       [result3, pred_label3]=ckNN_test(train_feature3', train_label', test_feature3', test_label', like_hood3, prior3, cost_seting, op);  
      
      
%2DPCA 
      [train_feature4, test_feature4] = All2D_feature( train_data_m,test_data_m,V4,P);
      % P.num_train, P.num_test, P.lie, P.dim
      train_feature4_c=get_data_m2c_all(train_feature4,P.dim);
      test_feature4_c=get_data_m2c_all(test_feature4,P.dim);
      [like_hood4, prior4]=ckNN_train(train_feature4_c', train_label', op); 
      [result4, pred_label4]=ckNN_test(train_feature4_c', train_label', test_feature4_c', test_label', like_hood4, prior4, cost_seting, op);       
%2DLDA  
      [train_feature5, test_feature5] = All2D_feature( train_data_m,test_data_m,V5,P);
      train_feature5_c=get_data_m2c_all(train_feature5,P.dim);
      test_feature5_c=get_data_m2c_all(test_feature5,P.dim);
      [like_hood5, prior5]=ckNN_train(train_feature5_c', train_label', op); 
      [result5, pred_label5]=ckNN_test(train_feature5_c', train_label', test_feature5_c', test_label', like_hood5, prior5, cost_seting, op); 
%2DLPP    
      [train_feature6, test_feature6] = All2D_feature( train_data_m,test_data_m,V6,P);
      train_feature6_c=get_data_m2c_all(train_feature6,P.dim);
      test_feature6_c=get_data_m2c_all(test_feature6,P.dim);
      [like_hood6, prior6]=ckNN_train(train_feature6_c', train_label', op); 
      [result6, pred_label6]=ckNN_test(train_feature6_c', train_label', test_feature6_c', test_label', like_hood6, prior6, cost_seting, op);  

      
%2DPCA       +2 cost_blind  
      [result1, pred_label1]=ckNN_test(train_feature4_c', train_label', test_feature4_c', test_label', like_hood4, prior4, cost_seting_b, op);       
      
%2DLDA     +2 cost_blind  
      [result2, pred_label2]=ckNN_test(train_feature5_c', train_label', test_feature5_c', test_label', like_hood5, prior5, cost_seting_b, op); 
      
%2DLPP      +2 cost_blind  
      [result3, pred_label3]=ckNN_test(train_feature6_c', train_label', test_feature6_c', test_label', like_hood6, prior6, cost_seting_b, op);      

% result1.total_cost result1.total_err result1.err_10 result1.err_01 result1.err_B1 result1.err_B0 result1.PP result1.NN result1.BB

      err(:,low_dim)=[result1.total_err; result2.total_err; result3.total_err; result4.total_err; result5.total_err; result6.total_err];
      cost(:,low_dim)=[result1.total_cost; result2.total_cost; result3.total_cost; result4.total_cost; result5.total_cost; result6.total_cost];     
      err_10(:,low_dim)=[result1.err_10; result2.err_10; result3.err_10; result4.err_10; result5.err_10; result6.err_10];
      err_01(:,low_dim)=[result1.err_01; result2.err_01; result3.err_01; result4.err_01; result5.err_01; result6.err_01];
      err_B0(:,low_dim)=[result1.err_B0; result2.err_B0; result3.err_B0; result4.err_B0; result5.err_B0; result6.err_B0];
      err_B1(:,low_dim)=[result1.err_B1; result2.err_B1; result3.err_B1; result4.err_B1; result5.err_B1; result6.err_B1];
      PP(:,low_dim)=[result1.PP; result2.PP; result3.PP; result4.PP; result5.PP; result6.PP];
      BB(:,low_dim)=[result1.BB; result2.BB; result3.BB; result4.BB; result5.BB; result6.BB];
      NN(:,low_dim)=[result1.NN; result2.NN; result3.NN; result4.NN; result5.NN; result6.NN];
end

  loop_err_10=loop_err_10+err_10;
  loop_err_01=loop_err_01+err_01;
  loop_err_B0=loop_err_B0+err_B0;
  loop_err_B1=loop_err_B1+err_B1;
  loop_err=loop_err+err;
  loop_cost=loop_cost+cost;
  loop_P=loop_P+PP;
  loop_N=loop_N+NN;
  loop_B=loop_B+BB;

end

this_loop_err_10=loop_err_10/n_loop;
this_loop_err_01=loop_err_01/n_loop;
this_loop_err_B0=loop_err_B0/n_loop;
this_loop_err_B1=loop_err_B1/n_loop;
this_loop_err=loop_err/n_loop;
this_loop_cost=loop_cost/n_loop;
this_loop_P=loop_P/n_loop;
this_loop_N=loop_N/n_loop;
this_loop_B=loop_B/n_loop;


save('thir_ar_TWD_vs_2D_01','this_loop_err_10','this_loop_err_01','this_loop_err_B0','this_loop_err_B1','this_loop_err','this_loop_cost','this_loop_P','this_loop_B','this_loop_N','max_dim','M','I','NG','NI','cost_seting')

