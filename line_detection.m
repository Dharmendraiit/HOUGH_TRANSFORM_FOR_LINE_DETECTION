function [] = line_detection()

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

%hough transform algorithm
%image has been divided into 4 quadrant with origin as centre of image

k=1;
p=b(1)/2-1;  % half breadth of matrix or depth of photo
q=b(2)/2-1;  % half length of photo

%for a given point in x-y plane 
%now we are calculating intercepts of axis in m-c plane

for i=-p:p-1        
    for j=-q:q-1    
        if (edge_final(i+p+1,j+q+1)>240)
            d(k,1)=double(i);    % y intercept in hough plane(0, value)
            d(k,2)=double(i/j);  % x intercept in hough plane (value,0)
            k=k+1;
        end
    end
end

s2=size(d);
 % A 3d matrix to store intersection coordinates(x,y) in m-c plane                     
 %among all lines total number of intersections=(nC2) so only upper half 
 %triangular matrix store data lower half is zero.
  v=zeros(s2(1),s2(1),2);
  
for i=1:(s2(1)-1)
    for j=i+1:s2(1)
       v(i,j,2)=(d(j,2)-d(i,2))/((d(j,2)/d(j,1))-(d(i,2)/d(i,1)));  % y coordinate of intersection(intercept)
       v(i,j,1)=(d(i,2)*d(i,1)-d(i,2)*v(i,j,2))/d(i,1);              % x coordinate of intersection(slope)
    end
end

%now storing all intersection coordinates in m-c plane into another matrix
%in 2D form
t=1;
inter=zeros(s2(1)*s2(1),2);
for i=1:s2(1)
    for j=1:s2(1)
       inter(t,1)=round(v(i,j,1),2);
       inter(t,2)=round(v(i,j,2),2);
       t=t+1;
    end
end

% finding all unique coordinates with their counts
   [C,ia,ic] = unique(inter,'rows');
   a_counts = double(accumarray(ic,1));
   ct = [C, a_counts];
   
   
   
   %plotting all lines in m-c plane in a single plot  
for i=1:s2(1)
      m=-d(i,1)/d(i,2);
       x=linspace(-1.1,1.1,10);
       y=m*x+d(i,1);
       plot(x,y,'LineWidth',0.1);
       % hold on;
end  
   %selecting only those coordinates whose intersection point count
   % is high say 10.
   
      k=1;    
  for i=1:size(ct)
      if((ct(i,1)~=0)&&(ct(i,2)~=0)&&(ct(i,1)~=-cot(0))&&(ct(i,2)~=-cot(0))&&(ct(i,3)>10))
      final_count(k,1)=ct(i,1);
      final_count(k,2)=ct(i,2);
      final_count(k,3)=ct(i,3);
      k=k+1;
      end
  end
  % plotting coordinates of maximum intersection on hough plane;
  for i=1:size(final_count)
      x=final_count(i,1);
      y=final_count(i,2);
      h1=plot(x,y,'o', 'markersize',8,'color','k');
      set(h1, 'markerfacecolor', get(h1, 'color'));
      % hold on;
  end
  
  %detected lines after hough transform
  imrotate(a,180);
  imshow(a,gray(256));
  hold on;
  e=size(final_count);
  for i=1:e(1)
       m=final_count(i,1);
       x=linspace(-200,200,2);
       y=-m*x+final_count(i,2);
       plot(x+q+8,y+p,'LineWidth',0.1);
       hold on;        
  end
  
 
end

