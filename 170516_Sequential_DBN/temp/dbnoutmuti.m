function y=dbnoutmuti(dbn,v,nsample)       %  by HX

size_v=size(v,1);
for i=1:numel(dbn.sizes)-1 
    v_new=zeros(size(v,1),size(dbn.rbm{i}.W',2));
    for j=1:nsample
    v_new = v_new+sigmrnd(repmat(dbn.rbm{i}.c', size_v, 1) + v *dbn.rbm{i}.W');  
    end
    v_new=
end   

y=v;

