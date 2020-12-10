function [ train_data train_label test_data test_label ] = get_train_test_data( input_matrix,input_label,ratio_train,num_each_person )
[n c]=size(input_matrix);
n_each_train=ceil(num_each_person*ratio_train);

train_data=[];test_data=[];train_label=[];test_label=[];
num_person=c/num_each_person;
for i=1:num_person
   
    index=randperm(num_each_person);
    
    this_train=input_matrix(:,(i-1)*num_each_person+index(1:n_each_train));
    this_test=input_matrix(:,(i-1)*num_each_person+index(n_each_train+1:end));
    
    this_train_label=input_label(:,(i-1)*num_each_person+index(1:n_each_train));
    this_test_label=input_label(:,(i-1)*num_each_person+index(n_each_train+1:end));
    
    train_data=[train_data this_train];
    test_data=[test_data this_test];
    train_label=[train_label this_train_label];
    test_label=[test_label this_test_label];
end
    
    


