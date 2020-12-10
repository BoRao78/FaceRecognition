function [likehood, prior] = ckNN_train(train_fea, train_label , options)
% mckNN_train trains the method multi-class cost-sensitive kNN proposed in [1].
% mckNN tackles multi-class cost-sensitive learning problem through the method multi-class cost-sensitive kNN proposed in [1].
% 
%    Syntax
%
%       [likehood prior] = mckNN_train(train_fea, train_label, options)
%
%    Description
%
%       mckNN_train takes,
%           train_fea        - An NxD matrix, the feature of training data. N is the number of training data and D is the dimension. Each row is an instance.
%           train_label      - A Nx1 array, each element train_label(i) indicating the label of i-th training sample. train_label(i) == 0 means 'out-group' person, otherwise 'in-group' person.
%           options          - The struct of mckNN training setting, where 
%             .k             - The number of neighbors selected
%             .s             - Laplacian correction, default 1
%
%      and returns,
%           likehood         - An CxC matrix, where C is the number of classes. Each element likehood(i+1,j+1) indicates the probability of an instance from the i-th class be one of the k nearest neighbors of the instance from the j-th class.
%           prior            - A Cx1 array. Each element prior(i+1) indicates prior probability of the i-th class.
%
% [1] Y. Zhang and Z.-H. Zhou. Cost-sensitive face recognition. IEEE Transactions on Pattern Analysis and Machine Intelligence.

k = options.k;
if isfield(options, 's')
    s = 1;
else
     s = options.s;
end

train_label = train_label + 1; % transfer label from 0-start to 1-start, then 1 for out-group and 2~class_num for in-group

N = size(train_fea, 1); % the number of training samples, train_fea: N*C
C = max(train_label);   
likehood = zeros(C, C);
prior = zeros(C, 1);

dist_matrix = squareform(pdist(train_fea));%dist_matrix:N*N, acquire the distance matrix of every row; 
% D = pdist(X) computes theEuclidean distance between pairs of objects in m-by-n datamatrix X. 
% Rows of X correspond to observations, and columns correspond to variables. 
% D is a row vector of length m(m–1)/2,corresponding to pairs of observations in X. 
% The distances are arranged in the order (2,1), (3,1), ..., (m,1),(3,2), ..., (m,2), ..., (m,m–1)).
% D iscommonly used as a dissimilarity matrix in clustering or multidimensionalscaling

% Z = squareform(D), where D is a vector as created by the pdist function,converts D into a square, 
% symmetric format Z,in which Z(i,j) denotes the distance between the ithand jth objects in the original data.

[xxx order] = sort(dist_matrix); % xxx: recorder every column in 'dist_matrix'by descending order,
% "order" is the column coordinate of xxx's element in 'dist_matrix';
% "order"： 与'dist_matrix'同维，元素值是"xxx"中每一元素，分别对应在矩阵'dist_matrix'中的列标

knb_matrix = zeros(k, N);  %neighbor matrix: k*N

for ti = 1 : N
    knb_matrix(:,ti) = train_label(order(1:k,ti)); %by column
end

for mid = 1 : C
    mindex = train_label == mid;
    mnum = sum(double(mindex)); %the number of samples in each class
    filt_matrix = knb_matrix(:,mindex); %the neighbour matrix of the 'mid' class
    for nid = 1 : C
        count = sum(double(filt_matrix(:)== nid));
        % the samples with label "mid" include "count" neighbour with label "nid"
        % count = sum(sum(double(filt_matrix == nid)));
        likehood(nid,mid) = (count + s) / (k * mnum + s * C); 
        %P(yj|y),count / (k*mnum) is the basic formula, "s" Laplacian correction,
        %every column of likehood is 1
    end
    prior(mid) = mnum / N;
end