op.k =3;  op.s =1;
cost_seting.C_10=20; % real '0', predict '1'
cost_seting.C_01=6;
cost_seting.C_B0=4;  % real '0', predict 'B'
cost_seting.C_B1=2;

cost_seting_b.C_10=1;
cost_seting_b.C_01=1;
cost_seting_b.C_B0=1;
cost_seting_b.C_B1=1;

err = zeros(4,max_dim);
cost = zeros(4,max_dim);    
err_10 = zeros(4,max_dim);
err_01 = zeros(4,max_dim);
err_B0 = zeros(4,max_dim);
err_B1 = zeros(4,max_dim);
PP = zeros(4,max_dim);
BB = zeros(4,max_dim);
NN = zeros(4,max_dim);

loop_err=zeros(4,max_dim);
loop_cost=zeros(4,max_dim);
loop_P=zeros(4,max_dim);
loop_B=zeros(4,max_dim);
loop_N=zeros(4,max_dim);
loop_err_10=zeros(4,max_dim);
loop_err_01=zeros(4,max_dim);
loop_err_B0=zeros(4,max_dim);
loop_err_B1=zeros(4,max_dim);