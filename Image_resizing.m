clear all;
clc;
close all;

%READ A RGB IMAGE
A=imread('CT.jpg');

% DEFINE THE RESAMPLE SIZE
Col = 1000;
Row = 1000;


%FIND THE RATIO OF THE NEW SIZE BY OLD SIZE
rtR = Row/size(A,1);
rtC = Col/size(A,2);

%OBTAIN THE INTERPOLATED POSITIONS
IR = ceil([1:(size(A,1)*rtR)]./(rtR));
IC = ceil([1:(size(A,2)*rtC)]./(rtC));


%RED CHANNEL
Temp= A(:,:,1);
%ROW-WISE INTERPOLATION
Red = Temp(IR,:);
%COLUMNWISE INTERPOLATION
Red = Red(:,IC);



%GREEN CHANNEL
Temp= A(:,:,2);
%ROW-WISE INTERPOLATION
Green = Temp(IR,:);
%COLUMNWISE INTERPOLATION
Green = Green(:,IC);


%BLUE CHANNEL
Temp= A(:,:,3);
%ROW-WISE INTERPOLATION
Blue = Temp(IR,:);
%COLUMNWISE INTERPOLATION
Blue = Blue(:,IC);



Output=zeros([Row,Col,3]);
Output(:,:,1)=Red;
Output(:,:,2)=Green;
Output(:,:,3)=Blue;

Output = uint8(Output);

figure;
subplot(2,2,1);
imshow(A);
title("Input image");
subplot(2,2,2);
imshow(Output);
title("Resized image using nearest interpolation");

clear all;
clc;
close all;

%READ A RGB IMAGE
A=imread('CT.jpg');

% DEFINE THE RESAMPLE SIZE
Col = 1000;
Row = 1000;

%FIND THE RATIO OF THE NEW SIZE BY OLD SIZE
rtR = size(A,1)/Row;
rtC = size(A,2)/Col;

Output=zeros([Row,Col,3]);

%PERFORM BILINEAR INTERPOLATION FOR RESIZING
for i = 1:Row
    for j = 1:Col
        x_l = floor(rtC * j);
        if(x_l < 1)
            x_l = 1;
        end
        y_l = floor(rtR * i);
        if(y_l < 1)
            y_l = 1;
        end
        x_h = ceil(rtC * j);
        y_h = ceil(rtR * i);
        
        x_weight = (rtC * j) - x_l;
        y_weight = (rtR * i) - y_l;
        
        a = A(y_l, x_l,1);
        b = A(y_l, x_h,1);
        c = A(y_h, x_l,1);
        d = A(y_h, x_h,1);
      
        pixel = a * (1 - x_weight) * (1 - y_weight) + b * x_weight * (1 - y_weight) + c * y_weight * (1 - x_weight) + d * x_weight * y_weight;
        
        Output(i,j,1) = pixel;
    end
end

for i = 1:Row
    for j = 1:Col
        x_l = floor(rtC * j);
        if(x_l < 1)
            x_l = 1;
        end
        y_l = floor(rtR * i);
        if(y_l < 1)
            y_l = 1;
        end
        x_h = ceil(rtC * j);
        y_h = ceil(rtR * i);
        
        x_weight = (rtC * j) - x_l;
        y_weight = (rtR * i) - y_l;
        
        a = A(y_l, x_l,2);
        b = A(y_l, x_h,2);
        c = A(y_h, x_l,2);
        d = A(y_h, x_h,2);
      
        pixel = a * (1 - x_weight) * (1 - y_weight) + b * x_weight * (1 - y_weight) + c * y_weight * (1 - x_weight) + d * x_weight * y_weight;
        
        Output(i,j,2) = pixel;
    end
end

for i = 1:Row
    for j = 1:Col
        x_l = floor(rtC * j);
        if(x_l < 1)
            x_l = 1;
        end
        y_l = floor(rtR * i);
        if(y_l < 1)
            y_l = 1;
        end
        x_h = ceil(rtC * j);
        y_h = ceil(rtR * i);
        
        x_weight = (rtC * j) - x_l;
        y_weight = (rtR * i) - y_l;
        
        a = A(y_l, x_l,3);
        b = A(y_l, x_h,3);
        c = A(y_h, x_l,3);
        d = A(y_h, x_h,3);
      
        pixel = a * (1 - x_weight) * (1 - y_weight) + b * x_weight * (1 - y_weight) + c * y_weight * (1 - x_weight) + d * x_weight * y_weight;
        
        Output(i,j,3) = pixel;
    end
end

Output = uint8(Output);

  
figure;
subplot(2,2,1);
imshow(A);
title("original image");
subplot(2,2,2);
imshow(Output);
title("Resized image");
