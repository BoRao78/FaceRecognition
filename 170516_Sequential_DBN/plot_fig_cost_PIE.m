load('thir_PIE_TWD_vs_2D_02.mat')
a=1:40;
cost_blind=cost_seting.C_10*this_loop_err_10+cost_seting.C_01*this_loop_err_01+cost_seting.C_B0*this_loop_err_B0+cost_seting.C_B1*this_loop_err_B1;
aaa=1:max_dim;
% test_cost=exp(0.04*aaa)/4-0.25;
% test_cost=exp(0.03*aaa)/5-0.2;
test_cost=0.001*aaa.^2;
% test_cost=0.01*aaa;
test_total_cost=450*test_cost;
% test_total_cost=300*test_cost;
%%
figure
subplot(2,3,4)
plot(a(2:max(a)),cost_blind(1,a(2:max(a)))+test_total_cost(a(2:max(a))),'-ro')
hold on
plot(a(2:max(a)),this_loop_cost(1+3,a(2:max(a)))+test_total_cost(a(2:max(a))),'-b*')
legend('Two-way Decision','Three-way Decision')
title('2DPCA granulation','FontSize',10)
ylabel('Total cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,3,5)
plot(a,cost_blind(2,a)+test_total_cost(a),'-ro')
hold on
plot(a,this_loop_cost(2+3,a)+test_total_cost(a),'-b*')
legend('Two-way Decision','Three-way Decision')
title('2DLDA granulation','FontSize',10)
ylabel('Total cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,3,6)
plot(a,cost_blind(3,a)+test_total_cost(a),'-ro')
hold on
plot(a,this_loop_cost(3+3,a)+test_total_cost(a),'-b*')
legend('Two-way Decision','Three-way Decision')
title('2DLPP granulation','FontSize',10)
ylabel('Total cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
%%
subplot(2,3,1)
plot(a(2:max(a)),cost_blind(1,a(2:max(a))),'-ro')
hold on
plot(a(2:max(a)),this_loop_cost(1+3,a(2:max(a))),'-b*')
legend('Two-way Decision','Three-way Decision')
title('2DPCA  granulation','FontSize',10)
ylabel('Decision cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,3,2)
plot(a,cost_blind(2,a),'-ro')
hold on
plot(a,this_loop_cost(2+3,a),'-b*')
legend('Two-way Decision','Three-way Decision')
title('2DLDA granulation','FontSize',10)
ylabel('Decision cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,3,3)
plot(a,cost_blind(3,a),'-ro')
hold on
plot(a,this_loop_cost(3+3,a),'-b*')
legend('Two-way Decision','Three-way Decision')
title('2DLPP granulation','FontSize',10)
ylabel('Decision cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 