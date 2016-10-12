%read in wave file
[ wav1, Fs ] = audioread( 'open_001.wav' );
wav1 = wav1';

n = 0:length( wav1 ) - 1;

%bandpass filter
[ f1b, f1a ] = butter( 3, [ 20/( Fs/2 ) 200/( Fs/2 ) ], 'bandpass' );

wavFiltered = filter( f1b, f1a, wav1 );

%plot( n( 1:length( n )/2 ), wavFiltered( 1:length( n )/2 ) );
figure ( 1 )
subplot( 3, 1, 1 );
plot( n, wav1 );
ylim( [ -1 1 ] );
xlim( [ 0, 6 * Fs ] );
title( 'OG graph' );

subplot( 3, 1, 2 );
plot( n, wavFiltered );
ylim( [ -1 1 ] );
xlim( [ 0, 6 * Fs ] );
title( 'bandsmashed' );

%ABS
wavAbs = abs( wavFiltered );

[ f1b, f1a ] = butter( 1, 10/( Fs/2 ) );

wavEnvelope = filter( f1b, f1a, wavAbs );
wavEnvelope = 5 * wavEnvelope;

subplot( 3, 1, 3 );
plot( n, wavEnvelope );
ylim( [ -0.5, 0.5 ] );
title( 'ripped' );

%tempo smoothing from 48 360
[ f1b, f1a ] = butter( 2, [ 1/( Fs/2 ) 7/( Fs/2 ) ] , 'bandpass' );

wavSmooth = filter( f1b, f1a, wavEnvelope );

subplot( 3, 1, 3 );
plot( n, wavSmooth );
%ylim( [ -1, 1 ] );
xlim( [ 0, 6 * Fs ] );
title( 'ripped' );

soundsc( wavEnvelope, Fs );

%% Beat Detect from sample
Fs = 48000;
T = 1/Fs;
time = 0:T:1 - T;
band = zeros([1 1]);

randSig = rand( 1, Fs );

bandBeat1 = false;

for r = 1:1:Fs
    [ bandBeat1, band ] = threshhold( randSig( r ), band, bandBeat1 );
end

band = band( 2:end );

figure
plot( time, randSig );
hold on;
plot( time, band );
xlim( [ 0 T*15 ] );
