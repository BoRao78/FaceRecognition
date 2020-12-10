%% Step 1: one step
%clear; close all;
load /data/ar
%data_c, data_label, data_m, hang, lie, max_dim, num_each_person

class_num=100;
train_num=8;
test_num=num_each_person-train_num;
data_r=zeros(hang*lie,class_num*num_each_person);
train_data_r=zeros(hang*lie,class_num*train_num);
test_data_r=zeros(hang*lie,class_num*test_num);
train_label=zeros(1,class_num*train_num);
test_label=zeros(1,class_num*test_num);

for i=1:class_num*num_each_person
    for j=1:lie
        data_r((1:hang)+(j-1)*hang,i) = data_m(:,j+(i-1)*lie);
    end
end

for i=1:class_num
    ID=randperm(num_each_person);
    train_data_r(:,(1:train_num)+ (i-1)*train_num)=data_r(:,ID(1:train_num) + (i-1)*num_each_person);
    test_data_r(:,(1:test_num)+ (i-1)*test_num)=data_r(:,ID(train_num+1:num_each_person) + (i-1)*num_each_person);
    train_label((1:train_num)+ (i-1)*train_num)=data_label(ID(1:train_num) + (i-1)*num_each_person);
    test_label((1:test_num)+ (i-1)*test_num)=data_label(ID(train_num+1:num_each_person) + (i-1)*num_each_person);
end

%{
M=15;NG=8;I=20; NI=NG; %NG,NI:number of samples for granular feature extraction 

%% get_train_test_data

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

   train_data=[Itrain_data Gtrain_data];
   train_data_c=[Itrain_data_c Gtrain_data_c];
   train_data_r=zeros(hang*lie,(M+I)*NG);
   for i=1:(M+I)*NG
       for j=1:lie
        train_data_r(hang*(j-1)+1:hang*j,i)=train_data(:,i+j-1);
       end
   end
   %Itrain_label=zeros(1,I*NI);%???
   %Gtrain_label=ones(1,M*NG);
   train_label=[Itrain_label Gtrain_label];

   test_data=[Itest_data Gtest_data];
   test_data_c=[Itest_data_c Gtest_data_c];
   test_data_r=zeros(hang*lie,(M+I)*(num_each_person-NG));
   for i=1:(M+I)*(num_each_person-NG)
       for j=1:lie
        train_data_r(hang*(j-1)+1:hang*j,i)=train_data(:,i+j-1);
       end
   end
   %Itest_label=zeros(1,I*(num_each_person-NI));
   %Gtest_label=ones(1,M*(num_each_person-NG));
   test_label=[Itest_label Gtest_label];
   %}



   save('Data_AR_100_60_43_label','train_data_r','train_label','test_data_r','test_label')