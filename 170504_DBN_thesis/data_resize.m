clear
close all
load c:\data\feret;
new_data_m=[];
new_data_c=[];
for i=1:size(data_c,2)
    this_m=imresize(get_i_image(data_m,i,lie),[10,10]);
    new_data_m=[new_data_m this_m];
end
new_data_c=get_data_m2c_all(new_data_m, 10);
figure(1);
imshow(get_i_image(new_data_m,100,10));
figure(2);
imshow_c(new_data_c,10,100);
hang=10;lie=10;
data_m=new_data_m;
data_c=new_data_c;
save('feret_10_10_m_c','data_m','data_c','data_label','hang','lie','num_each_person');

