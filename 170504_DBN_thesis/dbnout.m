function y=dbnout(dbn,v, num)       %  by HX

size_v=size(v,1);
%for i=1:numel(dbn.sizes)-1 
    v = sigmrnd_muti(repmat(dbn.rbm{1}.c', size_v, 1) + v *dbn.rbm{1}.W',num);  
   %  v = sigmrnd_muti_binary(repmat(dbn.rbm{1}.c', size_v, 1) + v *dbn.rbm{1}.W',num); 
%end   

y=v;

