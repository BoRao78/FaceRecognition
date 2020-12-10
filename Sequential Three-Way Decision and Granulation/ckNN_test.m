function [result, pred_label] = ckNN_test(train_fea, train_label, test_fea, test_label, likehood, prior, cost_setting, options)
% mckNN_test tests the method multi-class cost-sensitive kNN proposed in [1].
%
%    Syntax
%
%       [result pred_label] = mckNN_test(train_fea, train_label, test_fea, test_label, likehood, prior, cost_setting, options)
%
%    Description
%
%       mckNN_test takes,
%           train_fea        - An NxD matrix, the feature of training data. N is the number of training data and D is the dimension. Each row is an instance.
%           train_label      - A Nx1 array, each element train_label(i) indicating the label of i-th training sample. train_label(i) == 0 means 'out-group' person, otherwise 'in-group' person.
%           test_fea         - An MxD matrix, the feature of testing data. M is the number of testing data. Each row is an instance.
%           test_label       - A Mx1 array, each element test_label(i) indicating the label of i-th testing sample. test_label(i) == 0 means `out-group' person, otherwise `in-group' person.
%           likehood         - An CxC matrix, each element likehood(i+1,j+1) indicating the probability of an instance from the i-th class be one of the k nearest neighbors of the instance from the j-th class.
%           prior            - A Cx1 array, each element prior(i+1) indicating prior probability of the i-th class.
%           cost_setting     - The struct of cost setting, where 
%             .C_OI          - The cost of misclassifying an `out-group' person as `in-group'
%             .C_IO          - The cost of misclassifying an `in-group' person as `out-group¡¯
%             .C_II          - The cost of misclassifying between two `in-group' persons
%           options          - The struct of mckNN testing setting, where 
%             .k             - The number of neighbors selected
%
%      and returns,
%           result           - The struct record different evaluation measure where
%             .total_cost    - The total cost of mcKLR
%             .total_err     - The total error rate of mcKLR
%             .err_OI        - The error rate of misclassifying an `out-group' person as `in-group'
%             .err_IO        - The error rate of misclassifying an `in-group' person as `out-group¡¯
%             .C_II          - The error rate of misclassifying between two `in-group' persons
%             .pred_label    - The predicted label of testing data
%
% [1] Y. Zhang and Z.-H. Zhou. Cost-sensitive face recognition. IEEE Transactions on Pattern Analysis and Machine Intelligence.
k = options.k;

train_label = train_label + 1; % transfer label from 0-start to 1-start, then 1 for out-group and 2 for in-group
% class_num = max(train_label); this may not hold when the class-label is jumping, e.g.1,3,4,5,7
class_num = length(unique(train_label));  

%% get the Bayes risk for every instance
test_num = length(test_label);
knb_matrix = zeros(k, test_num);
bayes_risk = zeros(class_num+1, test_num);

dist_matrix = dist(train_fea, test_fea');
% train_fea: N*D,test_fea: M*D; acquire the distance matrix:N*M
[xxx order] = sort(dist_matrix); %xxx:every column by descending orde
%'order' is the column coordinate of xxx's element in distmatrix

for ti = 1 : test_num
    knb_matrix(:,ti) = train_label(order(1:k,ti));
end

for ti = 1 : test_num  
    % first, try 
     P_0 = prior(1); % P(y=O), the prior possibility of label 0
     lh = 1; % P(z|y=0)
     for ki = 1 : k
            yi = knb_matrix(ki,ti);
            lh = lh * likehood(yi,1);%P(yi|y=0) the first column
     end
     term1 = P_0 * lh; % P(y=0|z)*P(z)
     bayes_risk(2, ti) = term1* cost_setting.C_10;  
     %pred_label=2-1=1, this is the cost, real label '0', predict 1, the
     %possibility of this situation mutiply the cost
    
    
    % second, try
    P_1 = prior(2);  % P(y=1), the prior possibility of label 1
    lh = 1; % P(z|y=1)
    for ki = 1 : k
            yi = knb_matrix(ki,ti);
            lh = lh * likehood(yi,2); %P(yi|y=1) the second column
    end
    term2 =P_1 * lh;  % P(y=1|z)*P(z)
    bayes_risk(1, ti) = term2 * cost_setting.C_01; %pred_label=1-1=0
        
    % third try boundary decision 
    bayes_risk(3, ti) = term2 * cost_setting.C_B1 +term1 * cost_setting.C_B0; %pred_label=3-1=2
    % if all cost = 1, bayes_risk(3, ti) always < the other two options 
%     bayes_risk(3, ti) =  cost_setting.C_B1 +cost_setting.C_B0;  % for  cost-sensitive two-way

end

%% prediction
[xx pred_label] = min(bayes_risk); %xx is a row, pred_label is the column coordinate
pred_label = pred_label' - 1;
% result = checkresult(pred_label, test_label, cost_setting);
% 
% function result = checkresult(pred_label, test_label, cost_setting)
% test_num = length(test_label);
total_cost = 0;
err_10 = 0;
err_01 = 0;
err_B0 = 0;
err_B1 = 0;

for i = 1 : test_num  
        if test_label(i) == 0 && pred_label(i) == 1
            total_cost = total_cost + cost_setting.C_10;
            err_10 = err_10 + 1;
        end
        if test_label(i) == 1 && pred_label(i) == 0
            total_cost = total_cost + cost_setting.C_01;
            err_01 = err_01 + 1;
        end        
        if pred_label(i) == 2 && test_label(i) == 0
            total_cost = total_cost + cost_setting.C_B0;
            err_B0 = err_B0 + 1;
        end
        if pred_label(i) == 2 && test_label(i) == 1
            total_cost = total_cost + cost_setting.C_B1;
            err_B1 = err_B1 + 1;
        end
end

% for i = 1 : test_num  %two-class
%         if test_label(i) == 0 && pred_label(i) == 1
%             total_cost = total_cost + cost_setting.C_10;
%             err_10 = err_10 + 1;
%         end
%         if test_label(i) == 1 && pred_label(i) == 0
%             total_cost = total_cost + cost_setting.C_01;
%             err_01 = err_01 + 1;
%         end        
% end

total_err = err_10 + err_01 + err_B1 + err_B0 ;

result.total_cost = total_cost;
result.total_err = total_err;
result.err_10 = err_10;
result.err_01 = err_01;
result.err_B1 = err_B1;
result.err_B0 = err_B0;
result.PP=sum(pred_label==0); %% the N class, imposter, just write as PP
result.NN=sum(pred_label==1);
result.BB=sum(pred_label==2);
