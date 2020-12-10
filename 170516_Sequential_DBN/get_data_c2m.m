function data = get_data_c2m( input_data,n_column )
[r,c]=size(input_data);
n_row=r/n_column;

data=zeros(n_row,n_column);
    s=1;
    for i=1:n_row
        for j=1:n_column
          data(i,j)=input_data(s);
%           if data(i,j,num)==0
%               i
%               j
%               num
% 
%           end
          s=s+1;
        end
    end

