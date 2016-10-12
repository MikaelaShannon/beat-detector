function [ AudioBandsArr ] = FilterAudioIntoBands( LowBand, NumBands, AudioSignal )

Fs = 44100;
Fn = Fs/2;
x1 = log10(LowBand);
x2 = log10(Fn-1);

Arr = logspace(x1,x2,NumBands+1);
output = cell(length(AudioSignal),length(Arr));

for i = 1:length(Arr)-1
    Wn = [Arr(i)/Fn, Arr(i+1)/Fn];
    [b,a] = butter(2,Wn);
    output{i} = filter(b,a,AudioSignal);
    outputFFT = fft(output{i},8);
    outputmag = abs(outputFFT);
    f = 0:length(outputFFT)-1;
%     fscaled = f.*Fn;
    figure(i)
    plot(f,outputmag);
end
AudioBandsArr = output;
end

