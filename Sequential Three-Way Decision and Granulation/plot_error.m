%%
clear
a=1:40;
load('thir_ar_TWD_vs_2D_01.mat')
num_test=240;
%%
subplot(2,3,1)
plot(a,this_loop_err(1,a)/num_test,'-bx')
hold on
plot(a,this_loop_err(1+3,a)/num_test,'-r+')
legend('Two-way Decision','Three-way Decision')
title('2DPCA granulation on AR','FontSize',10)
ylabel('Error rate','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,3,2)
plot(a,this_loop_err(2,a)/num_test,'-bx')
hold on
plot(a,this_loop_err(2+3,a)/num_test,'-r+')
legend('Two-way Decision','Three-way Decision')
title('2DLDA granulation on AR','FontSize',10)
ylabel('Error rate','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,3,3)
plot(a,this_loop_err(3,a)/num_test,'-bx')
hold on
plot(a,this_loop_err(3+3,a)/num_test,'-r+')
legend('Two-way Decision','Three-way Decision')
title('2DLPP granulation on AR','FontSize',10)
ylabel('Error rate','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
%%
load('thir_PIE_TWD_vs_2D_02.mat')
num_test=450;
% num_test=300;
%%
subplot(2,3,4)
plot(a(2:max(a)),this_loop_err(1,a(2:max(a)))/num_test,'-bx')
hold on
plot(a(2:max(a)),this_loop_err(1+3,a(2:max(a)))/num_test,'-r+')
legend('Two-way Decision','Three-way Decision')
title('2DPCA granulation on PIE','FontSize',10)
ylabel('Error rate','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,3,5)
plot(a,this_loop_err(2,a)/num_test,'-bx')
hold on
plot(a,this_loop_err(2+3,a)/num_test,'-r+')
legend('Two-way Decision','Three-way Decision')
title('2DLDA granulation on PIE','FontSize',10)
ylabel('Error rate','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,3,6)
plot(a,this_loop_err(3,a)/num_test,'-bx')
hold on
plot(a,this_loop_err(3+3,a)/num_test,'-r+')
legend('Two-way Decision','Three-way Decision')
title('2DLPP granulation on PIE','FontSize',10)
ylabel('Error rate','FontSize',10)
xlabel('Decision  steps','FontSize',10) 