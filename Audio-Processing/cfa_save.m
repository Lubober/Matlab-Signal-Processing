function cfa_save(filename, s)
%The signal is saved using a filename that the user decides to set 
audiowrite(filename,s.y,s.Fs)
end