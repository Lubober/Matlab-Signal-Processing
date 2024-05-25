function out= peak(Fc,Fs,Fb,y,G)
% Wc is the normalized center frequency 0<Wc<1, i.e. 2*fc/Fs.
Wc = 2*Fc/Fs;

% Wb is the normalized bandwidth 0<Wb<1, i.e. 2*fb/Fs.
Wb = 2*Fb/Fs;

% PEAK FILTER (Could make into a function lie shelving)

in = y;
out = zeros(size(y)); % Best to pre-allocate

V0 = 10^(G/20);
H0 = V0 - 1;
if G >= 0
  c = (tan(pi*Wb/2)-1) / (tan(pi*Wb/2)+1);     % boost
else
  c = (tan(pi*Wb/2)-V0) / (tan(pi*Wb/2)+V0);   % cut
end
d = -cos(pi*Wc);
in_h = [0, 0];
for n=1:length(in)
  in_h_new = in(n) - d*(1-c)*in_h(1) + c*in_h(2);
  ap_out = -c * in_h_new + d*(1-c)*in_h(1) + in_h(2);
  in_h = [in_h_new, in_h(1)];
  out(n) = 0.5 * H0 * (in(n) - ap_out) + in(n);
end

end