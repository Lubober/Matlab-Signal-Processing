function sss= cfa_ext(s, delay_interval, wet_level)
% The function implements a nice sounding delay effect for the audio data
% that is passed as the "s" parameter. The delay interval (s) and the wet
% level of the delay(%) are optional parameters that can be passed into the
% function if the user likes to get control over their delay effect. If
% the user decides to ignore those or inputs invalid data, a preset setting
% will be used.
    %All of the code for the delay function below belongs to me.
    %What the code essentially does is creates a new delayed_audio audio
    %data array with respect to the expected size of the delay.
    %The size of delayed_audio combines the original size and
    %adds the total number of repetitions audio and the time interval
    %between those repetitions and multiplies the sum by the frequency. A
    %for loop then goes through the new audio file in segments with respect
    %to the interval and adds the original audio file on top of those
    %segments. To make that sound nicer, I have implemented added the
    %decay_scale variavle that is reduced exponentially with each
    %iteration. The decay_scale can be controled by the wet_level input
    %argument. I have also made it so that when the decay_scale value gets
    %too low to a level where it produces virtually no sound after the
    %recording has been finished, the audio file ends.


if(nargin<2|| isempty(delay_interval)||delay_interval<0)
    delay_interval=0.3;
    disp("delay_level input value either invalid or non existent, default settings have been set")
end
if(nargin<3||isempty(wet_level)||wet_level>100||wet_level<0)
    decay_scale=0.5;
    disp("wet_level input value either invalid or non existent, default settings have been set")
else
    decay_scale=wet_level/140;
end
Fs=s.Fs;
audio_data=s.y;
num_repetitions=200;
    delay_samples = round((num_repetitions-1)*delay_interval);
    fs_interval=delay_interval*Fs;
    new_time = delay_samples+s.t;
    new_frequency_end= new_time*Fs;
    delayed_audio=zeros(1,new_frequency_end+1);
    for i = 1:num_repetitions
        start_index = (i-1) * fs_interval+1;
        end_index = start_index + length(s.y)-1;
        if any(decay_scale^i < 0.00000001) && any(start_index > length(s.y))
            delayed_audio=delayed_audio(1:start_index);
            break;
        end
        decayed_audio = audio_data(1:length(s.y)) * (decay_scale ^ i);
        delayed_audio(start_index:end_index) = delayed_audio(start_index:end_index) + decayed_audio;
    end
sss.y=delayed_audio;
sss.Fs=s.Fs;
sss.t=size(sss.y)/Fs;
end