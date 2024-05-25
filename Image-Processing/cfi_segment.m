function m = cfi_segment(s)
%The code takes only the image as an argument and divides it into
%foreground and background background mask.
    %The code converts the image to greyscale and then uses the MSER
    %function to detect the most stable region after which it converts it
    %into a binary mask.

gr = rgb2gray(s);
[~,cc]=detectMSERFeatures(gr,'ThresholdDelta',1.5);
labeledImage = labelmatrix(cc);
m = labeledImage>0;
end