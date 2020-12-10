function dbn = dbntrain(dbn, x, opts)
    n = numel(dbn.rbm); % number of the layers

    dbn.rbm{1} = rbmtrain(dbn.rbm{1}, x, opts);  % train the first layer parameters
    for i = 2 : n
        x = rbmup(dbn.rbm{i - 1}, x);  %
        dbn.rbm{i} = rbmtrain(dbn.rbm{i}, x, opts);
    end

end
