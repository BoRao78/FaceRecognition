
label_ID = randperm(class_num);


for i = 1:size(train_label_data,2)
    for j = 1:class_num/2
        if train_label_data(i) == label_ID(j)
            train_label_data(i) = 1000;
        end
    end
    if train_label_data(i) ~= 1000
        train_label_data(i) = 1001;
    end
end
train_label_data = train_label_data - 1000;

for i = 1:size(test_label_data,2)
    for j = 1:class_num/2
        if test_label_data(i) == label_ID(j)
            test_label_data(i) = 1000;
        end
    end
    if test_label_data(i) ~= 1000
        test_label_data(i) = 1001;
    end
end
test_label_data = test_label_data - 1000;


for i = 1:size(train_label_time,2)
    for j = 1:class_num/2
        if train_label_time(i) == label_ID(j)
            train_label_time(i) = 1000;
        end
    end
    if train_label_time(i) ~= 1000
        train_label_time(i) = 1001;
    end
end
train_label_time = train_label_time - 1000;

for i = 1:size(test_label_time,2)
    for j = 1:class_num/2
        if test_label_time(i) == label_ID(j)
            test_label_time(i) = 1000;
        end
    end
    if test_label_time(i) ~= 1000
        test_label_time(i) = 1001;
    end
end
test_label_time = test_label_time - 1000;