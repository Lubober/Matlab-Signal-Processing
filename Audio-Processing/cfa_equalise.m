function ss= cfa_equalise(s,b)
%!IMPORTANT!
%in order for the function to work properly, the input argument "b" has to
%be previously formatted using the "eqdata" helper funtion into a strut.
%Otherwise, the function will output the 's' input argument without any
%formatting.

%The function lets the user choose the band for equalisation as well as
%lets them control the gain, the bandwidth and the type of fiter to apply.
%There is an option to choose to do 3 different filter types: Treble shelf,
%Base shelf, peak control. Although technically, a high pass and a low pass
%filter can be achieved if the gain of the shelves is set as a low enough
%value.
    %The code uses the "shelving" and the "peak" functions the code for
    %which was taken from the lecture slides. The algorithm uses Fourier
    %transform to analyze the frequency content of the signal and apply
    %equalisation based on the specified parameters. It then plots the
    %difference and outputs a strut data type. 


levels = [16 31.5 63 125 250 500 1000 2000 4000 8000 16000];
if(isstruct(b))
    G = b.gain;  % Gain
    Fc = levels(b.band); % Filter center frequency
    Fb = b.bandwidth;  % Filter Bandwidth
else
    disp('Invalid input, make sure you read the function documentation for troubleshooting')
    ss=s;
    return;
end
y=s.y;
Fs=s.Fs;


if(isfield(b,'Q'))
    Q=b.Q;
else
    Q=3;
end



Y=fftshift(fft(y));
N=numel(Y);
F = [0:floor(N/2)-1] * Fs/N;
IDX = [ceil(N/2)+1:N];


if (isfield(b,'eqtype') && (strcmp(b.eqtype, 'Base_Shelf') || strcmp(b.eqtype, 'Treble_Shelf')))
    [bb,a] = shelving(G,Fc,Fs,Q,b.eqtype);
    out = filter(bb,a,y);
    b.eqtype = strrep(b.eqtype, '_', ' ');
elseif (isfield(b,'eqtype') && strcmp(b.eqtype, 'Peak'))
    out = peak(Fc,Fs,Fb,y,G);
else
    out = peak(Fc,Fs,Fb,y,G);
end



% Plot difference
YP = fftshift(fft(out));
figure();
plot(F, abs(YP(IDX)),'g');
hold on;
plot(F, abs(Y(IDX)),'r');
title({b.eqtype, ' Filter Equalised Signal'});
xlabel('Frequency')
ylabel('')


ss.y=out;
ss.Fs=Fs;

end