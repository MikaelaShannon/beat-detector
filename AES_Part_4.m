Fs = 44100;
Ts = 1/Fs;

t = 0:Ts:1;

w = .02 * pi;

x = 0.5 * sin(w * t * 1000) + 0.5;

y = 0.5 * sin(2 * w * t * 1000) + 0.5;

hold on;
plot(x);
plot(y);

threshold = 0.7;

x_peaks = zeros(1,length(t));
y_peaks = zeros(1,length(t));
peaks = zeros(1,length(t));


for i = 1:length(t)
    %if x(i) > threshold
     %   x_peaks(i) = x(i);
    %end
    %if y(i) > threshold
     %   y_peaks(i) = y(i);
    %end
    if x(i) > threshold && y(i) > threshold
        peaks(i) = 1;
    end
end

plot(peaks);