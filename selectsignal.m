function [a, b]=selectsignal(temp)
temp=rgb2gray(temp);
for i=1:4
    
d=dir(['data\',num2str(i),'\*.jpg']);

for j=1:length(d)
    
    img=imread(['data\',num2str(i),'\',d(j).name]);
    img=imresize(img,[100,100]);
    img=rgb2gray(img);
%     temp=rgb2gray(temp);
    cor(j)=corr2(img,temp);
end
fcor(i)=max(cor);
end
[a,b]=max(fcor);

end