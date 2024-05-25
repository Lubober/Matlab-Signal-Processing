function cfi_display(s,domain)
%display an image or its frequency domain representation.
    %input image 's' and an optional parameter 'domain' to specify the
    %domain ('s' for spatial or 'f' for frequency). If 'domain'is not
    %provided, it defaults to spatial domain.


figure();

if(nargin<2|| isempty(domain))
    domain='s';
end
if(domain=='s')
    imagesc(s)
    xlabel("X-axis")
elseif(domain=='f')
    im = real(fftshift(fft(s)));
    imagesc(im)
    xlabel("Frequency")
end
ylabel("Y-axis")


end