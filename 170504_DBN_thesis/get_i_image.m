function this_data_m=get_i_image(data_m,i,lie)
this_data_m=data_m(:,(i-1)*lie+1:i*lie);
