function rbm = rbmtrain(rbm, x, opts,printflag)
    assert(isfloat(x), 'x must be a float'); % require x to be a float HX
    m = size(x, 1);                          % size of input x  HX
         
    numbatches = m / opts.batchsize;
   
    assert(rem(numbatches, 1) == 0, 'numbatches not integer');  % numbateches should be integer HX
    
    
    for i = 1 : opts.numepochs
        kk = randperm(m);      % ��ԭ�����������д��ң������˳������һЩ������ѵ�� HX
        err = 0;
        for l = 1 : numbatches
            batch = x(kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize), :); % ȡ������˳����batchsize������ HX
            v1 = batch;    % batch ��Ϊ����v1
            h1 = sigmrnd(repmat(rbm.c', opts.batchsize, 1) + v1 * rbm.W');  %gibbs sampling�Ĺ���
            v2 = sigmrnd(repmat(rbm.b', opts.batchsize, 1) + h1 * rbm.W);
            h2 = sigmrnd(repmat(rbm.c', opts.batchsize, 1) + v2 * rbm.W');
            %Contrastive Divergence �Ĺ���    
         %��͡�Learning Deep Architectures for AI������дcd-1���Ƕ�pseudo code��һ����
            c1 = h1' * v1;
            c2 = h2' * v2;

            rbm.vW = rbm.momentum * rbm.vW + rbm.alpha * (c1 - c2)     / opts.batchsize;
            rbm.vb = rbm.momentum * rbm.vb + rbm.alpha * sum(v1 - v2)' / opts.batchsize;
            rbm.vc = rbm.momentum * rbm.vc + rbm.alpha * sum(h1 - h2)' / opts.batchsize;
         %����momentum����ο�Hinton�ġ�A Practical Guide to Training Restricted Boltzmann Machines��   
         %���������Ǽ�¼����ǰ�ĸ��·��򣬲������ڵķ������£����п��ܼӿ�ѧϰ���ٶ�   
         
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
