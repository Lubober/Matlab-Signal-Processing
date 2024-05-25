function cfa_display(s,domain)
%Displays an audio signal or its frequency domain representation.
    %Input signal 's' and an optional parameter 'domain' to specify the
    %domain ('t' for time domain or 'f' for frequency domain). If 'domain'
    %is not provided, it defaults to time domain.

figure();

if(nargin<2|| isempty(domain))
    domain='t';
end
if(domain=='t')
    s.Fs
    plot(s.y );
    fig=gcf;
    fig.Name = 'Time against Amplitude';
    title( 'Time against Amplitude')
    xlabel('time domain')
elseif(domain=='f')
    F=fft(s.y);
    L=length(s.y);
    plot(s.Fs/L*(0:L-1),abs(F))
    fig=gcf;
    fig.Name = 'Time against Frequency';
    title( 'Frequency against Amplitude')
    xlabel('frequency domain')
end
fig.Color= [0 0.5 0.5];
ylabel('amplitude')
end