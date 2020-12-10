clear all; close all; %clc;
all_acc=[];
%dbn_total_struct=[225 169 100 30];
%dbn_total_struct=[30 100 169 225];
dbn_total_struct=[100 50 30 10];
for i_loop=1:size(dbn_total_struct,2)
    clear inputData;
    clear train_x_feature;
    clear test_x_feature;
    clear acc;
    clear pred;
dbn_struct=dbn_total_struct(1:i_loop);
DBM_3WD
dbn_struct
all_acc=[all_acc acc]
end
