function hough()
a=double(rgb2gray(imread('AB.jpg')));
b=size(a);
k=1;
for i=1:(b(1)-2)        %breadth of matrix or depth of photo
    for j=1:(b(2)-2)    %length of photo
        if a(i,j)>235
            c(k,1)=double(i/j);  % y intercept in hough plane(0, value)
            c(k,2)=double(i);    % x intercept in hough plane (value,0)
            k=k+1;
        end
    end
end
imshow(a,gray(256));
end

