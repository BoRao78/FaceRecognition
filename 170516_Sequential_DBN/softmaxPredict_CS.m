function [pred] = softmaxPredict_CS(softmaxModel, data, C_GG,C_GI,C_IG,impostClass)
%% ---------- COST SETTING--------------------------------------
beta=(C_GI+C_IG-C_GG)/C_GG;
delta=(C_GI-C_GG)/C_GG;


%% --------    --------------------------------------
% softmaxModel - model trained using softmaxTrain
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
%
% Your code should produce the prediction matrix 
% pred, where pred(i) is argmax_c P(y(c) | x(i)).
 
% Unroll the parameters from theta
theta = softmaxModel.optTheta;  % this provides a numClasses x inputSize matrix
pred = zeros(1, size(data, 2));

%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute pred using theta assuming that the labels start 
%                from 1.

pred_vec=theta * data;
pred_vec_impost=pred_vec(impostClass,:)*beta-delta;
pred_vec(impostClass,:)=pred_vec_impost;
[nop, pred] = max(pred_vec);




% ---------------------------------------------------------------------

end

