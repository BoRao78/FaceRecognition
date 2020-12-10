%% show 7 figures of two persons in AR dataset (in one columns)
clear
close all
load /data/ar
n = 12;
im1=data_m(:,(1:num_each_person*lie) + num_each_person*lie*n);
figure
imshow(im1)
%% 14 figures of one person
load /data/PIE/Pose05_60x60new.mat
num=7;
show_ID=(num-1)*num_each_person+2:3:num*num_each_person;   %each person has 49 figures
im2=[];
for i=1:7
    im2=[im2 data_m(:,(show_ID(i)-1)*lie+1:show_ID(i)*lie)];
end
for i=10:16
    im2=[im2 data_m(:,(show_ID(i)-1)*lie+1:show_ID(i)*lie)];
end
im2=im2/150;
figure
imshow(im2)
%%
 column=1000*ones(60,119);
 column_b=1000*ones(25,size(im2,2));
im1_big=[column im1 column];
im=[im1_big;column_b;im2];
imshow(im)
text(410,75,'(a)')
text(410,160,'(b)')