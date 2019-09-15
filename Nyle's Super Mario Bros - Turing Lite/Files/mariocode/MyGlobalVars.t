%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This file declares all the global variables that the main program will need to use 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   MyGlobalVars.t
%   All global variables are coded in this file.
%   These will have FILE scope.
%   These must be document thoroughly - Descriptive name,
%   where used and for what purpose

var isIntroWindowOpen : boolean % Flag for Introduction Window state open or closed
var isLevel1Chosen : boolean % used to indicate if level 1 button has been chosen in the main file
var isLevel2Chosen : boolean % used to indicate if level 2 button has been chosen in the main file
var isInstructionsWindowOpen : boolean % used to indicate if instructions button has been chosen in the main file
var centered : boolean % used to attritbute the sprite's coordinates to the center of the image in the gameplay file
var finished1 : boolean % used to stop the intro screen music in the main file
var finished2 : boolean % used to stop the intro screen music in the main file
%sets all the variables to an initial value 
proc setInitialGameValues
    isIntroWindowOpen := false
    isLevel1Chosen := false 
    isLevel2Chosen := false
    isInstructionsWindowOpen := false 
    centered := true 
    finished1 := false 
    finished2 := false 
end setInitialGameValues
