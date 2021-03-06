function [grayIn, out] = processImage(in, type)
grayIn = [];
out = [];
try
    grayIn = rgb2gray(in);
catch
    grayIn = in;
end;
switch type;
    case '��ֵ��ֵ��'
        grayIn = in;
        out = im2bw(in, 0.5);
    case '������ǿ'
        out = imadjust(grayIn);
    case 'ֱ��ͼ�任��ǿ'
        out = histeq(grayIn);
    case '�����˲�'
        h = [1,2,1;0,0,0;-1,-2,-1];
        out = filter2(h,grayIn);
    case '��ֵ�˲�'
        out = medfilt2(grayIn);
    case 'Sobel������ͼ��'
        h=[1,2,1;0,0,0;-1,-2,-1];%Sobel����
        out = filter2(h,grayIn);
    case '����������ͼ��'
        h=[0,1,0;1,-4,0;0,1,0];%��������
        out = conv2(double(grayIn),h,'same');
        out = double(grayIn)-out;
    case 'ͼ���Ե���: sobel ����'
        out = edge(grayIn,'sobel');
    case 'ͼ���Ե���: prewitt ����'
        out = edge(grayIn,'prewitt');
    case 'ͼ���Ե���: roberts ����'
        out = edge(grayIn,'roberts');
    case 'ͼ���Ե���: canny ����'
        out = edge(grayIn,'canny');
    case 'ͼ���Ե���: zerocross ����'
        out = edge(grayIn,'zerocross');
    case '����'
        h = [0 1 0;1 1 1;0 1 0];
        out = imdilate(grayIn,h);
    case '��ʴ'
        h = strel('disk',1);
        out = imerode(grayIn,h);
    case '�����㣺�ȸ�ʴ�����ͳ�Ϊ������'
        h = strel('square',2);
        out = imopen(grayIn,h);
    case '�����㣺�����ͺ�ʴ��Ϊ������'
        h = strel('square',2);
        out = imclose(grayIn,h);
    case 'ͼ��ָ�'
        % ģ���˶�ģ��
        grayIn = im2double(grayIn);
        LEN = 21; 
        THETA = 11; 
        PSF = fspecial('motion', LEN, THETA); 
        blurred = imfilter(grayIn, PSF, 'conv', 'circular');
        % ģ���������
        noise_mean = 0; 
        noise_var = 0.0001; 
        blurred_noisy = imnoise(blurred, 'gaussian',noise_mean, noise_var);
        % ���Իָ�
        estimated_nsr = noise_var / var(grayIn(:)); 
        out = deconvwnr(blurred_noisy, PSF, estimated_nsr);
        grayIn = blurred_noisy;
    case 'ͼ����ת'
        grayIn = in;
        out = imrotate(grayIn,0,'bilinear','crop'); 
    end;