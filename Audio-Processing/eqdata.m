function b = eqdata(band,gain,eqtype,bandwidth,Q)
%Take a range of inputs for the function and put them all into a set data
%structure
%   This function is used to stick to the format of the cfa_equalise
%   function, as it only takes 2 arguments.
%   For the type domain, the possible values are the following:
    % 'Base_Shelf'
    % 'Treble_Shelf'
    % 'Peak'

b.band=band;
b.gain=gain;
b.bandwidth=bandwidth;
b.eqtype=eqtype;
b.Q=Q;
end