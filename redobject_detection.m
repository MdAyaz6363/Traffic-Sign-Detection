function output=redobject_detection(rgbImage)

eightBit = true;
% rgbImage = ind2rgb(rgbImage);
			% ind2rgb() will convert it to double and normalize it to the range 0-1.
			% Convert back to uint8 in the range 0-255, if needed.
% 			if eightBit
% 				rgbImage = uint8(255 * rgbImage);
%             end
            
            
     redBand = rgbImage(:, :, 1); 
	greenBand = rgbImage(:, :, 2); 
	blueBand = rgbImage(:, :, 3); 
    if eightBit 
			maxGL = 255; 
    end 
    if eightBit 
		xlim([0 255]); 
	else 
		xlim([0 maxGrayLevel]); 
	end 
% if strcmpi(reply2, 'My Own') || strcmpi(selectedImage, 'Canoe') > 0
		% Take a guess at the values that might work for the user's image.
		redThresholdLow = graythresh(redBand);
		redThresholdHigh = 255;
		greenThresholdLow = 0;
		greenThresholdHigh = graythresh(greenBand);
		blueThresholdLow = 0;
		blueThresholdHigh = graythresh(blueBand);
		if eightBit
			redThresholdLow = uint8(redThresholdLow * 255);
			greenThresholdHigh = uint8(greenThresholdHigh * 255);
			blueThresholdHigh = uint8(blueThresholdHigh * 255);
 		end
% 	else
% 		% Use values that I know work for the onions and peppers demo images.
% 		redThresholdLow = 85;
% 		redThresholdHigh = 255;
% 		greenThresholdLow = 0;
% 		greenThresholdHigh = 70;
% 		blueThresholdLow = 0;
% 		blueThresholdHigh = 90;
% 	end
smallestAcceptableArea = 100;
	
	% Now apply each color band's particular thresholds to the color band
	redMask = (redBand >= redThresholdLow) & (redBand <= redThresholdHigh);
	greenMask = (greenBand >= greenThresholdLow) & (greenBand <= greenThresholdHigh);
	blueMask = (blueBand >= blueThresholdLow) & (blueBand <= blueThresholdHigh);

	
   
	redObjectsMask = uint8(redMask & greenMask & blueMask);
	

	% Open up a new figure, since the existing one is full.
	

	% Get rid of small objects.  Note: bwareaopen returns a logical.
	redObjectsMask = uint8(bwareaopen(redObjectsMask, smallestAcceptableArea));
	% Smooth the border using a morphological closing operation, imclose().
	structuringElement = strel('disk', 4);
	redObjectsMask = imclose(redObjectsMask, structuringElement);
	
	% Fill in any holes in the regions, since they are most likely red also.
	redObjectsMask = uint8(imfill(redObjectsMask, 'holes'));
	

	% You can only multiply integers if they are of the same type.
	% (redObjectsMask is a logical array.)
	% We need to convert the type of redObjectsMask to the same data type as redBand.
	redObjectsMask = cast(redObjectsMask, class(redBand)); 

	% Use the red object mask to mask out the red-only portions of the rgb image.
	maskedImageR = redObjectsMask .* redBand;
	maskedImageG = redObjectsMask .* greenBand;
	maskedImageB = redObjectsMask .* blueBand;
	% Show the masked off red image.
	% Concatenate the masked color bands to form the rgb image.
	output = cat(3, maskedImageR, maskedImageG, maskedImageB);
	% Show the masked off, original image.
	
	
    end