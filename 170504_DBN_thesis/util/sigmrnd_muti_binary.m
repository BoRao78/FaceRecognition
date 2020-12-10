function X = sigmrnd_muti_binary(P,num)
%     X = double(1./(1+exp(-P)))+1*randn(size(P));
   X = double(1./(1+exp(-P)) > rand(size(P)));
   for i=2:num
    X = X + double(1./(1+exp(-P)) > rand(size(P)));
   end
   X= X / num;
   X = double(X > 0.5);
end