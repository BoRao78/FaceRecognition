clear
load feret_train_test;

delta=3;
patchsize=28;
step_hang=fix((hang-patchsize)/delta);
step_lie=fix((lie-patchsize)/delta);
num_train=50;
num_test=20;
%% train data
new_train_x=[];
new_train_label=[];
for index_train=1:num_train
    index_train
    this_train=train_x(:,index_train);
    this_label=train_label(index_train,1);
    this_image=get_data_c2m(this_train,lie);
    %imshow(this_image);
for i=0:step_hang
    for j=0:step_lie
        this_patch=this_image(i*delta+1:i*delta+patchsize,j*delta+1:j*delta+patchsize);
        this_patch_vector=get_data_m2c(this_patch);
        new_train_x=[new_train_x this_patch_vector];
        new_train_label=[new_train_label, this_label];
    end
end
clear this_train; clear this_label; clear this_image;
end

%% test data
new_test_x=[];
new_test_label=[];
for index_test=1:num_test
    index_test
    this_test=test_x(:,index_test);
    this_label=test_label(index_test,1);
    this_image=get_data_c2m(this_test,lie);
    %imshow(this_image);
for i=0:step_hang
    for j=0:step_lie
        this_patch=this_image(i*delta+1:i*delta+patchsize,j*delta+1:j*delta+patchsize);
        this_patch_vector=get_data_m2c(this_patch);
        new_test_x=[new_test_x this_patch_vector];
        new_test_label=[new_test_label, this_label];
    end
end
clear this_test; clear this_label; clear this_image;
end
clear train_x; clear test_x; clear train_label; clear test_label;
train_x=new_train_x;
train_label=new_train_label';
test_x=new_test_x;
test_label=new_test_label';
hang=patchsize; lie=patchsize;
numClasses=10;
save('c:\data\feret_patch_data_train50_test20_step_3','train_x','test_x','train_label','test_label','numClasses','hang','lie');





