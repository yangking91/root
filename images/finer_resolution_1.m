IM=imread('image.jpg');
IM=rgb2gray(IM);
IM=imresize(IM,0.5);
figure,imshow(IM);

%Generate black space outside of the picture
temp=zeros(742,912,'uint8');
for x=201:542
    for y=201:712
        temp(x,y)=IM(x-200,y-200);
    end
end

IM=zeros(742,912,'uint8');
for x=1:742
    for y=1:912
        IM(x,y)=temp(x,y);
    end
end

figure,imshow(IM);

%Generate randon angles
fai=2*pi*rand(742,912,'double');

%get the frequency domain of the sharp image, simulate the experimental
%diffraction pattern
FFT_IM=fft2(IM);
FFT_IM=fftshift(FFT_IM);
FFT_IM=abs(FFT_IM);
%FFT_IM_log=log(FFT_IM);
%imshow(FFT_IM_log,[]);
%selected_pixel=FFT_IM(293:307,293:207);
%selected_pixel_DFI=DFI(293:307,293:207);

%get the frequency domain of the blur image
%FFT_IM_blur=fft2(IM_blur);
%FFT_IM_blur=fftshift(FFT_IM_blur);
%FFT_IM_blur=abs(FFT_IM_blur);
%FFT_IM_blur_log=log(FFT_IM_blur);
%imshow(FFT_IM_blur_log,[]);

%Generate a new image with the Fourier frequency of the blured image and the random angles
FFT_IM_new=FFT_IM.*exp(1i*fai);
IM_new=abs(ifft2(FFT_IM_new));
%imshow(IM_new,[]);

%Iteration between the real space and reciprocal space
Iteration=10000;
for k=0:1:Iteration
    for x=1:1:742
        for y=1:1:912
            if(x<=200 || x>542 || y<=200 || y>712)
                IM_new(x,y)=0;
            end
        end
    end
    FFT_IM_new=fft2(IM_new);
    FFT_IM_new=fftshift(FFT_IM_new);
    FFT_IM_new_theta=angle(FFT_IM_new);
    FFT_IM_newer=FFT_IM.*exp(1i*FFT_IM_new_theta);
    IM_newer=abs(ifft2(FFT_IM_newer));
    IM_new=IM_newer;
end
figure,imshow(IM_new,[]);