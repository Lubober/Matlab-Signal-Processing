function outputArg1 = cfa_load(filename)
%The file is read and all of its information is stored as a struct data
%type.
[y,Fs] = audioread(filename);
s.y=y;
s.Fs=Fs;
s.t=length(y)/Fs;
outputArg1 = s;
end