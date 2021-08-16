clear all
     [file,path] = uigetfile('*.*');
file=[path,file];
    videoFReader = video.MultimediaFileReader(file,'AudioOutputPort',false,'VideoOutputPort',true);
 s=serial('com3');
  fopen(s);


%     Info = info(hmfr);
%      fps=Info.VideoFrameRate;
 j=1;
 defaultString ='Hump Detected';
caUserInput = char(defaultString); % Convert from cell to string.
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
in=1;
signal='N';
while ~isDone(videoFReader)   
  videoFrame =step(videoFReader);
%    hsvHist = hsvHistogram(videoFrame);
  videoFrame=uint8(double(videoFrame)*255);
  [~,in,sign]=blobAnalysis(videoFrame,obj,caUserInput,in); 
%   vidFrames(:,:,:,j)=mov;
%    imshow(mov);
     pause(0.001);
%     cd frame
%      imwrite(mov,[pwd,'\frame\',num2str(j),'.jpg']);
%     cd ..
    if sign~=0
        
        if sign==1
        signal='A';
        end
        if sign==2
        signal='B';
        end
        if sign==3
        signal='C';
        end
        if sign==4
        signal='D';
        end
         fprintf(s,num2str(signal));
        disp(signal);
        break;
    end
    disp(signal);
    j=j+1;
end
% close(hmfw);
 fopen(s);
close(videoFReader);  



