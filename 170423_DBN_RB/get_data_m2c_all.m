function data = get_data_m2c_all( input_data, lie )
[r,c]=size(input_data);
data=[];

for num=1:c/lie
    this_data=zeros(r*lie,1);
    s=1;
    for i=1:r
        for j=(num-1)*lie+1:num*lie
          this_data(s,1)=input_data(i,j);
          s=s+1;
        end
    end
    data=[data this_data];
end


