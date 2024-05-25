function ss =  cfi_ext(s,color)
%The function enhances the input image S by sharpening its edges,
%adjusting contrast, and locally brightening areas, giving the option to
%specify the color emphasis. Specify color as 'r', 'g', or 'b' to
%emphasize the red, green, or blue channel, respectively.
    %The code for separate parts of the function has been taken from the
    %official MathWorks website. It applies different filters to the image
    %to hopefully give the user the ability to create something of an
    %interesting appearance.




if(nargin<2||isempty(color))
rgbCopy=s;
else
[r, g, b] = imsplit(s);
blackImage=dither(rgb2gray(s));
if(color == "g")
    rgbCopy = cat(3, blackImage, g, blackImage);
elseif(color=="r")
    rgbCopy = cat(3, r, blackImage, blackImage);
elseif(color=="b")
    rgbCopy = cat(3, blackImage, blackImage, b);
end


end

imgBlur = rgbCopy;

sharpCoeff = [0 0 0;0 1 0;0 0 0]-fspecial('laplacian',0.1);

f = @() imfilter(imgBlur,sharpCoeff,'symmetric');
fprintf('Elapsed time is %.6f seconds.\n',timeit(f));

imgSharp = imfilter(imgBlur,sharpCoeff,'symmetric');

imgEnhanced = entropyfilt(imgSharp,getnhood(strel('Disk',8)));
imgEnhanced = imgEnhanced/max(imgEnhanced(:));
imgEnhanced = imadjust(imgEnhanced,[0.30; 0.85],[0.90; 0.00], 0.90);

B = imlocalbrighten(imgEnhanced);
ss=B;

end