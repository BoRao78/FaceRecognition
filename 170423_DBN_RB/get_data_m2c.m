function data = get_data_m2c( input_data )
[r,c]=size(input_data);
data=zeros(r*c,1);

    s=1;
    for i=1:r
        for j=1:c
          data(s,1)=input_data(i,j);
          s=s+1;
        end
    end


