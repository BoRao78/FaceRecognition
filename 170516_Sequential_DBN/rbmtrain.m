function rbm = rbmtrain(rbm, x, opts,printflag)
    assert(isfloat(x), 'x must be a float'); % require x to be a float HX
    m = size(x, 1);                          % size of input x  HX
         
    numbatches = m / opts.batchsize;
   
    assert(rem(numbatches, 1) == 0, 'numbatches not integer');  % numbateches should be integer HX
    
    
    for i = 1 : opts.numepochs
        kk = randperm(m);      % 把原来的样本排列打乱，按随机顺序挑出一些样本来训练 HX
        err = 0;
        for l = 1 : numbatches
            batch = x(kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize), :); % 取出打乱顺序后的batchsize个样本 HX
            v1 = batch;    % batch 作为输入v1
            h1 = sigmrnd(repmat(rbm.c', opts.batchsize, 1) + v1 * rbm.W');  %gibbs sampling的过程
            v2 = sigmrnd(repmat(rbm.b', opts.batchsize, 1) + h1 * rbm.W);
            h2 = sigmrnd(repmat(rbm.c', opts.batchsize, 1) + v2 * rbm.W');
            %Contrastive Divergence 的过程    
         %这和《Learning Deep Architectures for AI》里面写cd-1的那段pseudo code是一样的
            c1 = h1' * v1;
            c2 = h2' * v2;

            rbm.vW = rbm.momentum * rbm.vW + rbm.alpha * (c1 - c2)     / opts.batchsize;
            rbm.vb = rbm.momentum * rbm.vb + rbm.alpha * sum(v1 - v2)' / opts.batchsize;
            rbm.vc = rbm.momentum * rbm.vc + rbm.alpha * sum(h1 - h2)' / opts.batchsize;
         %关于momentum，请参看Hinton的《A Practical Guide to Training Restricted Boltzmann Machines》   
         %它的作用是记录下以前的更新方向，并与现在的方向结合下，更有可能加快学习的速度   
         
            rbm.W = rbm.W + rbm.vW;
            rbm.b = rbm.b + rbm.vb;
            rbm.c = rbm.c + rbm.vc;

            err = err + sum(sum((v1 - v2) .^ 2)) / opts.batchsize;
        end
        if printflag
        disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)  '. Average reconstruction error is: ' num2str(err / numbatches)]);
        end
    end
end
