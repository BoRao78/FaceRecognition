a=1:40;
b=[0 a];
ttt=[0 ;0 ;0];
%
 bbb=[210; 210; 210];
 %load('thir_ar_TWD_vs_2D_02.mat')
 bbb=[240; 240; 240];
 PP=[ttt this_loop_P(4:6,a)];
 BB=[bbb this_loop_B(4:6,a)];
 %%
 subplot(2,3,1)
 plot(b,PP(1,:),'-go')
 hold on
 plot(b,PP(1,:)+BB(1,:),':r*')
 title('2DPCA on AR database','FontSize',10)
 ylabel('Sample numbers','FontSize',10)
 xlabel('Decision  steps','FontSize',10) 
 %%
 subplot(2,3,2)
 plot(b,PP(2,:),'-go')
 hold on
 plot(b,PP(2,:)+BB(2,:),':r*')
 title('2DLDA on AR database','FontSize',10)
 ylabel('Sample numbers','FontSize',10)
 xlabel('Decision  steps','FontSize',10) 
 %%
 subplot(2,3,3)
 plot(b,PP(3,:),'-go')
 hold on
 plot(b,PP(3,:)+BB(3,:),':r*')
 title('2DLPP on AR database','FontSize',10)
 ylabel('Sample numbers','FontSize',10)
 xlabel('Decision  steps','FontSize',10) 
%}
% %%
% bbb=[450; 450; 450];
% load('thir_PIE_TWD_vs_2D_01.mat')
bbb=[300; 300; 300];
load('thir_PIE_TWD_vs_2D_02.mat')
PP=[ttt this_loop_P(4:6,a)];
BB=[bbb this_loop_B(4:6,a)];
%%
subplot(2,3,4)
plot(b,PP(1,:),'-go')
hold on
plot(b,PP(1,:)+BB(1,:),':r*')
title('2DPCA on PIE database','FontSize',10)
ylabel('Sample numbers','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
%%
subplot(2,3,5)
plot(b,PP(2,:),'-go')
hold on
plot(b,PP(2,:)+BB(2,:),':r*')
title('2DLDA on PIE database','FontSize',10)
ylabel('Sample numbers','FontSize',10)
xlabel('Decision  steps','FontSize',10) 
%%
subplot(2,3,6)
plot(b,PP(3,:),'-go')
hold on
plot(b,PP(3,:)+BB(3,:),':r*')
title('2DLPP on PIE database','FontSize',10)
ylabel('Sample numbers','FontSize',10)
xlabel('Decision  steps','FontSize',10) 