function data = get_data_c2m_all( input_data,n_column )
data=[];
for i=1:size(input_data,2)
    data=[data get_data_c2m( input_data(:,i),n_column )];
end