clear all
     [file,path] = uigetfile('*.*');
file=[path,file];
    videoFReader = video.MultimediaFileReader(file,'AudioOutputPort',false,'VideoOutputPort',true);

%     Info = info(hmfr);
%      fps=Info.VideoFrameRate;
 j=1;
 defaultString ='Hump Detected';
caUserInput = char(defaultString); % Convert from cell to string.
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
in=1;
while ~isDone(videoFReader)   
  videoFrame =step(videoFReader);
%    hsvHist = hsvHistogram(videoFrame);
 videoFrame=uint8(double(videoFrame)*255);
  [~,in]=blobAnalysis(videoFrame,obj,caUserInput,in); 
%   vidFrames(:,:,:,j)=mov;
%    imshow(mov);
     pause(0.001);
%     cd frame
%      imwrite(mov,[pwd,'\frame\',num2str(j),'.jpg']);
%     cd ..
    if j==100
%         b=imcrop(mov);
j
    end
    j=j+1;
end
% close(hmfw);
close(videoFReader);  



