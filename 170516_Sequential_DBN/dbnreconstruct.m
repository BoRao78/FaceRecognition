function y=dbnreconstruct(dbn,h,num)       %  by HX

size_h=size(h,1);
for i=numel(dbn.sizes)-1:-1:1    
    h = sigmrnd_muti(repmat(dbn.rbm{i}.b', size_h, 1) + h * dbn.rbm{i}.W,num);
end   

y=h;

