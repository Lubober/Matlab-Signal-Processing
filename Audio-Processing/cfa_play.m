function  cfa_play(s,v)
%The function plays the audio at a preset loudness. The loudness is
%controllable as a function parameter.

if(nargin<2|| isempty(v)||v>100||v<0)
    v=100;
end

s.y=s.y*v/25;
sound(s.y,s.Fs)
end

