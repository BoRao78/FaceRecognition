
load /data/ar
%data_c, data_label, data_m, hang, lie, max_dim, num_each_person
%hang=60;lie=43;
class_num=100;

% data_m  convolution
convolu_hang = 35;
convolu_lie = 35;
convolu_step = 1;
convolu_num = (hang - convolu_hang + 1) * (lie - convolu_lie + 1);
data_con = zeros(convolu_hang,convolu_lie*1400*convolu_num);
m = 0;
for k = 1:1400
    for i = 1:hang - convolu_hang + 1
        for j = 1:lie - convolu_lie + 1
            data_con(:,(1:convolu_lie)+ m*convolu_lie) = data_m(i:i+convolu_hang-1,(j:j+convolu_lie-1)+(k-1)*lie);
            m = m+1;
        end
    end
end

num_each_person = num_each_person * convolu_num;
train_num= 8 * convolu_num;
test_num=num_each_person-train_num;
data_label_con = ones(1,class_num*num_each_person);
for i=1:class_num
    data_label_con(1,(1:num_each_person)+(i-1)*num_each_person) = i;
end


data_r=zeros(convolu_hang*convolu_lie,class_num*num_each_person);
train_data_r=zeros(convolu_hang*convolu_lie,class_num*train_num);
test_data_r=zeros(convolu_hang*convolu_lie,class_num*test_num);
train_label=zeros(1,class_num*train_num);
test_label=zeros(1,class_num*test_num);

for i=1:class_num*num_each_person
    for j=1:convolu_lie
        data_r((1:convolu_hang)+(j-1)*convolu_hang,i) = data_con(:,j+(i-1)*convolu_lie);
    end
end

for i=1:class_num
    ID=randperm(num_each_person);
    train_data_r(:,(1:train_num)+ (i-1)*train_num)=data_r(:,ID(1:train_num) + (i-1)*num_each_person);
    test_data_r(:,(1:test_num)+ (i-1)*test_num)=data_r(:,ID(train_num+1:num_each_person) + (i-1)*num_each_person);
    train_label((1:train_num)+ (i-1)*train_num)=data_label_con(ID(1:train_num) + (i-1)*num_each_person);
    test_label((1:test_num)+ (i-1)*test_num)=data_label_con(ID(train_num+1:num_each_person) + (i-1)*num_each_person);
end


%fprintf(1,'Loading data ... \n');
%load '/data/AR_database_60_43';
%load 'Data_AR_100_60_43_label';
addpath(genpath(pwd));

class_num = 40;
num_image = (hang-convolu_hang+1)*(lie-convolu_lie+1);
image_train = 8;
image_test = 6;
train_num = num_image * image_train;
test_num = num_image * image_test;
hang = convolu_hang;
lie = convolu_lie;
