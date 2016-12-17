function [grayIn, out] = processImage(in, type)
grayIn = [];
out = [];
try
    grayIn = rgb2gray(in);
catch
    grayIn = in;
end;
switch type;
    case '阈值二值化'
        grayIn = in;
        out = im2bw(in, 0.5);
    case '空域增强'
        out = imadjust(grayIn);
    case '直方图变换增强'
        out = histeq(grayIn);
    case '卷积滤波'
        h = [1,2,1;0,0,0;-1,-2,-1];
        out = filter2(h,grayIn);
    case '中值滤波'
        out = medfilt2(grayIn);
    case 'Sobel算子锐化图像'
        h=[1,2,1;0,0,0;-1,-2,-1];%Sobel算子
        out = filter2(h,grayIn);
    case '拉氏算子锐化图像'
        h=[0,1,0;1,-4,0;0,1,0];%拉氏算子
        out = conv2(double(grayIn),h,'same');
        out = double(grayIn)-out;
    case '图像边缘检测: sobel 算子'
        out = edge(grayIn,'sobel');
    case '图像边缘检测: prewitt 算子'
        out = edge(grayIn,'prewitt');
    case '图像边缘检测: roberts 算子'
        out = edge(grayIn,'roberts');
    case '图像边缘检测: canny 算子'
        out = edge(grayIn,'canny');
    case '图像边缘检测: zerocross 算子'
        out = edge(grayIn,'zerocross');
    case '膨胀'
        h = [0 1 0;1 1 1;0 1 0];
        out = imdilate(grayIn,h);
    case '腐蚀'
        h = strel('disk',1);
        out = imerode(grayIn,h);
    case '开运算：先腐蚀后膨胀称为开运算'
        h = strel('square',2);
        out = imopen(grayIn,h);
    case '闭运算：先膨胀后腐蚀称为闭运算'
        h = strel('square',2);
        out = imclose(grayIn,h);
    case '图像恢复'
        % 模拟运动模糊
        grayIn = im2double(grayIn);
        LEN = 21; 
        THETA = 11; 
        PSF = fspecial('motion', LEN, THETA); 
        blurred = imfilter(grayIn, PSF, 'conv', 'circular');
        % 模拟加性噪声
        noise_mean = 0; 
        noise_var = 0.0001; 
        blurred_noisy = imnoise(blurred, 'gaussian',noise_mean, noise_var);
        % 尝试恢复
        estimated_nsr = noise_var / var(grayIn(:)); 
        out = deconvwnr(blurred_noisy, PSF, estimated_nsr);
        grayIn = blurred_noisy;
    case '图像旋转'
        grayIn = in;
        out = imrotate(grayIn,0,'bilinear','crop'); 
    end;