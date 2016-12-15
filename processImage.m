function [grayIn, out] = processImage(in, type)
grayIn = [];
out = [];
switch type;
    case '阈值二值化'
        grayIn = in;
        out = im2bw(in, 0.5);
    case '空域增强'
        grayIn = rgb2gray(in);
        out = imadjust(grayIn);
    case '直方图变换增强'
        grayIn = rgb2gray(in);
        out = histeq(grayIn);
    case '卷积滤波'
        grayIn = rgb2gray(in);
        h = [1,2,1;0,0,0;-1,-2,-1];
        out = filter2(h,grayIn);
    case '中值滤波'
        grayIn = rgb2gray(in);
        out = medfilt2(grayIn);
    case 'Sobel算子锐化图像'
        grayIn = rgb2gray(in);
        h=[1,2,1;0,0,0;-1,-2,-1];%Sobel算子
        out = filter2(h,grayIn);
    case '拉氏算子锐化图像'
        grayIn = rgb2gray(in);
        h=[0,1,0;1,-4,0;0,1,0];%拉氏算子
        out = conv2(double(grayIn),h,'same');
        out = double(grayIn)-out;
    case '图像边缘检测: sobel 算子'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'sobel');
    case '图像边缘检测: prewitt 算子'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'prewitt');
    case '图像边缘检测: roberts 算子'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'roberts');
    case '图像边缘检测: canny 算子'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'canny');
    case '图像边缘检测: zerocross 算子'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'zerocross');
    case '膨胀'
        grayIn = rgb2gray(in);
        h = [0 1 0;1 1 1;0 1 0];
        out = imdilate(grayIn,h);
    case '腐蚀'
        grayIn = rgb2gray(in);
        h = strel('disk',1);
        out = imerode(grayIn,h);
    case '开运算：先腐蚀后膨胀称为开运算'
        grayIn = rgb2gray(in);
        h = strel('square',2);
        out = imopen(grayIn,h);
    case '闭运算：先膨胀后腐蚀称为闭运算'
        grayIn = rgb2gray(in);
        h = strel('square',2);
        out = imclose(grayIn,h);
    end;