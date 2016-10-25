function [audiosamp,audiotxt] = Read_In()
%READ_IN: Prompts user to select and trim audio example


addpath('training_set')
addpath(['training_set' filesep 'closed'])
addpath(['training_set' filesep 'open'])

% Select Audio Sample
audiotxt = [];

good = 0;
while good == 0;
OC = input('Open or Closed? ','s');
if strcmp(OC,'Open')
    OC = 'open';
end
if strcmp(OC,'Closed')
    OC = 'closed';
end
if (strcmp(OC,'open') == 1 || strcmp(OC,'closed') == 1) 
    good = 1;
end
end

Number = 26;
while (Number >= 25 || Number < 1)
Number = input('Enter Sample Number(1-25): ');
end
Number = int2str(Number);
while(size(Number) < 3)
    Number = strcat('0',Number);
end

fA = strcat(OC,'_',Number,'.wav');
Filename = strcat('training_set',filesep,OC,filesep,fA);
[y,Fs] = audioread(Filename);

if strcmp(OC,'open')
    fB = strcat(OC,'_',Number,'.txt');
    Filename2 = strcat('training_set',filesep,OC,filesep,fB);   
    audiotxt = csvread(Filename2);
end

% Trim Audio
s = 31;
while (s > 30 || s < 1)
s = input('Input Sound Length in Seconds(10-30): ');
end
audiosamp = y(1:s*Fs);

end

