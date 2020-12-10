function view = view_all(dbn)
for i=1:size(dbn.sizes,2)-1
    figure; visualize(dbn.rbm{i}.W', 1);
end
view='over';