%%
a=1:max_dim;
num_test=936;
%%
subplot(1,2,1)
plot(a,this_loop_err(1,a)/num_test,'-ro')
hold on
plot(a,this_loop_err(1+2,a)/num_test,'-b*')
legend('Two-way Decision','Three-way Decision')
title('Data Sequential','FontSize',10)
ylabel('Error rate','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])
%%
subplot(1,2,2)
plot(a,this_loop_err(2,a)/num_test,'-ro')
hold on
plot(a,this_loop_err(2+2,a)/num_test,'-b*')
legend('Two-way Decision','Three-way Decision')
title('Time Sequential','FontSize',10)
ylabel('Error rate','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
% axis([0,30,60,200])