
max_step = 20;
%Maximum Decision step

max_dim = max_step;
n_loop = 3;

Cost_Sequential_Setup();
DBN_Setup();
max_dim = max_step;
for loop = 1:n_loop

for now_dim=1:max_dim
now_dim
tic
Get_DBN_Feature_data();
Get_DBN_Feature_time();
initial_label();


[like_hood_data, prior_data]=ckNN_train(train_feature_data, train_label_data, op); 
[result_data, pred_label_data]=ckNN_test(train_feature_data, train_label_data, test_feature_data, ...
    test_label_data, like_hood_data, prior_data, cost_seting, op);

[like_hood_time, prior_time]=ckNN_train(train_feature_time, train_label_time, op); 
[result_time, pred_label_time]=ckNN_test(train_feature_time, train_label_time, test_feature_time, ...
    test_label_time, like_hood_time, prior_time, cost_seting, op);

[result1, pred_label1]=ckNN_test(train_feature_data, train_label_data, test_feature_data, ...
    test_label_data, like_hood_data, prior_data, cost_seting_b, op); 
[result2, pred_label2]=ckNN_test(train_feature_time, train_label_time, test_feature_time, ...
    test_label_time, like_hood_time, prior_time, cost_seting_b, op); 


result_adjust();


err(:,now_dim)=[result1.total_err; result2.total_err; result_data.total_err; result_time.total_err];
cost(:,now_dim)=[result1.total_cost; result2.total_cost; result_data.total_cost; result_time.total_cost];     
err_10(:,now_dim)=[result1.err_10; result2.err_10; result_data.err_10; result_time.err_10];
err_01(:,now_dim)=[result1.err_01; result2.err_01; result_data.err_01; result_time.err_01];
err_B0(:,now_dim)=[result1.err_B0; result2.err_B0; result_data.err_B0; result_time.err_B0];
err_B1(:,now_dim)=[result1.err_B1; result2.err_B1; result_data.err_B1; result_time.err_B1];
PP(:,now_dim)=[result1.PP; result2.PP; result_data.PP; result_time.PP];
BB(:,now_dim)=[result1.BB; result2.BB; result_data.BB; result_time.BB];
NN(:,now_dim)=[result1.NN; result2.NN; result_data.NN; result_time.NN];
toc
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

save('DBN_Sequential_AR_20_3','this_loop_err_10','this_loop_err_01','this_loop_err_B0','this_loop_err_B1',...
    'this_loop_err','this_loop_cost','this_loop_P','this_loop_B','this_loop_N','max_dim','cost_seting');

