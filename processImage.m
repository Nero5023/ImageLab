function [grayIn, out] = processImage(in, type)
grayIn = [];
out = [];
switch type;
    case '��ֵ��ֵ��'
        grayIn = in;
        out = im2bw(in, 0.5);
    case '������ǿ'
        grayIn = rgb2gray(in);
        out = imadjust(grayIn);
    case 'ֱ��ͼ�任��ǿ'
        grayIn = rgb2gray(in);
        out = histeq(grayIn);
    case '����˲�'
        grayIn = rgb2gray(in);
        h = [1,2,1;0,0,0;-1,-2,-1];
        out = filter2(h,grayIn);
    case '��ֵ�˲�'
        grayIn = rgb2gray(in);
        out = medfilt2(grayIn);
    case 'Sobel������ͼ��'
        grayIn = rgb2gray(in);
        h=[1,2,1;0,0,0;-1,-2,-1];%Sobel����
        out = filter2(h,grayIn);
    case '����������ͼ��'
        grayIn = rgb2gray(in);
        h=[0,1,0;1,-4,0;0,1,0];%��������
        out = conv2(double(grayIn),h,'same');
        out = double(grayIn)-out;
    case 'ͼ���Ե���: sobel ����'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'sobel');
    case 'ͼ���Ե���: prewitt ����'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'prewitt');
    case 'ͼ���Ե���: roberts ����'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'roberts');
    case 'ͼ���Ե���: canny ����'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'canny');
    case 'ͼ���Ե���: zerocross ����'
        grayIn = rgb2gray(in);
        out = edge(grayIn,'zerocross');
    case '����'
        grayIn = rgb2gray(in);
        h = [0 1 0;1 1 1;0 1 0];
        out = imdilate(grayIn,h);
    case '��ʴ'
        grayIn = rgb2gray(in);
        h = strel('disk',1);
        out = imerode(grayIn,h);
    case '�����㣺�ȸ�ʴ�����ͳ�Ϊ������'
        grayIn = rgb2gray(in);
        h = strel('square',2);
        out = imopen(grayIn,h);
    case '�����㣺�����ͺ�ʴ��Ϊ������'
        grayIn = rgb2gray(in);
        h = strel('square',2);
        out = imclose(grayIn,h);
    end;