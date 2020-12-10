a=1:max_dim;
cost_blind=cost_seting.C_10*this_loop_err_10+cost_seting.C_01*this_loop_err_01+cost_seting.C_B0*this_loop_err_B0+cost_seting.C_B1*this_loop_err_B1;
aaa=1:max_dim;
% test_cost=exp(0.04*aaa)/4-0.25;
% test_cost=exp(0.03*aaa)/5-0.2;
test_cost_data=0.001*aaa.^3;
test_total_cost_data=234*test_cost_data;
test_cost_time=0.001*aaa.^2;
test_total_cost_time=2808*test_cost_time;
%%
figure
subplot(2,2,3)
plot(a,cost_blind(1,a)+test_total_cost_data(a),'-ro')
hold on
plot(a,this_loop_cost(1+2,a)+test_total_cost_data(a),'-b*')
legend('Two-way Decision','Three-way Decision')
title('Data Sequential','FontSize',10)
ylabel('Total cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,2,4)
plot(a,cost_blind(2,a)+test_total_cost_time(a),'-ro')
hold on
plot(a,this_loop_cost(2+2,a)+test_total_cost_time(a),'-b*')
legend('Two-way Decision','Three-way Decision')
title('Time Sequential','FontSize',10)
ylabel('Total cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,2,1)
plot(a,cost_blind(1,a),'-ro')
hold on
plot(a,this_loop_cost(1+2,a),'-b*')
legend('Two-way Decision','Three-way Decision')
title('Data Sequential','FontSize',10)
ylabel('Decision cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(2,2,2)
plot(a,cost_blind(2,a),'-ro')
hold on
plot(a,this_loop_cost(2+2,a),'-b*')
legend('Two-way Decision','Three-way Decision')
title('Time Sequential','FontSize',10)
ylabel('Decision cost','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])

