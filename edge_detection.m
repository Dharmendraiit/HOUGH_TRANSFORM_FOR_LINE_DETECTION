function [] = edge_detection()
a=double(rgb2gray(imread('AB_1.jpg'))); %input of image
s=[1 2 1;0 0 0;-1 -2 -1]; %sobel matrix mask
b=size(a);  %storing dimension of matrix into 2x1 matrix

%edge detection algorithm using sobel operator
for i=1:(b(1)-2)
    for j=1:(b(2)-2)
        c=a(i:i+2,j:j+2,1);
        r1=sum(sum(s.*c));
        r2=sum(sum(s'.*c));
        a1(i,j)=((r1^2+r2^2)^0.5);
            
    end
end

%normalizing edge detected image
edge_final=floor(a1/max(max(a1))*255);
imshow(edge_final,gray(255));



end

