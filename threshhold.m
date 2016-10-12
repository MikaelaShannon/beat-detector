%receiving: bandpassed audio from frequencies x to y in vector form (one
%sample)
%to do: determine if audio amplitude inside band passes threshhold -> TRUE:
%if not beat, change boolean to beat, add one,, if already beat, change to not beat, add zero; 
% -> FALSE: add zero to array
%return: no return, updates vector value for given band

function [ beatDetect, newband ] = threshhold( sample, band, inbeat )
if ~isvector( band )
    error( 'Input band must be a vector' )
end

th = 0.75;
beatDetect = inbeat;

if sample > th
    if ~inbeat
        beatDetect = true;
    end
    newband = [ band 1 ];
else
    if inbeat
        beatDetect = false;
    end
    newband = [ band 0 ];
end
end