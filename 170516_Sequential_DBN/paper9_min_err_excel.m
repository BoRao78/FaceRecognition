clear
load('thir_ar_TWD_vs_2D_02.mat')
sd=zeros(4,6);
min_err=zeros(4,6);
num_test=this_loop_P(1,1)+this_loop_N(1,1)
err_rate_10=this_loop_err_10/num_test;
err_rate_01=this_loop_err_01/num_test;
min_err(1,:)=min(err_rate_10,[],2)'; %high _cost
min_err(2,:)=min(err_rate_01,[],2)'; %high _cost
for i=1:6
    sd(1,i)=sqrt(var(err_rate_10(i,:))); %high _cost
    sd(2,i)=sqrt(var(err_rate_01(i,:))); %low _cost
end
%
load('thir_PIE_TWD_vs_2D_02.mat')
num_test=this_loop_P(1,1)+this_loop_N(1,1)
err_rate_10=this_loop_err_10/num_test;
err_rate_01=this_loop_err_01/num_test;
min_err(3,:)=min(err_rate_10,[],2)'; %high _cost
min_err(4,:)=min(err_rate_01,[],2)'; %high _cost
for i=1:6
    sd(3,i)=sqrt(var(err_rate_10(i,:))); %high _cost
    sd(4,i)=sqrt(var(err_rate_01(i,:))); %low _cost
end
%
%% [min standard min standard ...]
min_colum=[1 3 5 7 9 11];
std_colum=[2 4 6 8 10 12];
last_exc(:,min_colum)=min_err*100;
last_exc(:,std_colum)=sd*100;