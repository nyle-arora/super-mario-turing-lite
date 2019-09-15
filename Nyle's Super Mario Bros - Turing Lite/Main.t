%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Nyle Aroa
%Date: January 22, 2016
%Course:  ICS3CU1
%Teacher: Stephen Holik
%Program Name: Super Mario Bros - Turing Lite
%Descriptions:  Super Mario Bros - Turing Lite involves a boss fight against
%Bowser on two different levels of difficulty 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calls the include file, which in turn calls all the other files, allowing
%the main to call all the files.
include "files/mariocode/includes.t"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% procedure to set all initial global variable with file scope
% even if already set (located in MyGlobalVars.t)
setInitialGameValues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  ********  M A I N   P R O G R A M   S T E P S ********
% *********************   Main Variable Declarations Here
%creates the intro screen music
process introscreenmusic
    loop
	exit when finished1 = true
	Music.PlayFile ("files/sound/MP3IntroScreenMusic.mp3")
    end loop
end introscreenmusic
%creates the game screen music.
process gamescreenmusic
    loop
	exit when finished2 = true
	Music.PlayFile ("files/sound/BadBloodMP3.mp3")
    end loop
end gamescreenmusic

loop
    % ***************************************   Major Block A - Display intro screen
    % Display the introduction screen
    fork introscreenmusic
    displayIntroWindow
    % ***************************************   Major Block B - Display the game play screens
    % Display the level 1 play window
    if isLevel1Chosen = true then
	finished1 := true
	Music.PlayFileStop
	fork gamescreenmusic
	Level1
    end if
    isLevel1Chosen := false
    % Display the level 2 play window
    if isLevel2Chosen = true then
	finished1 := true
	Music.PlayFileStop
	fork gamescreenmusic
	Level2
    end if
    isLevel2Chosen := false
    % ***************************************   Major Block C - Display the instructions screen
    %Display the instructions screen
    if isInstructionsWindowOpen = true then
	displayInstructionsWindow
    end if
% ***************************************   Major Block D - Reset all remaining values
    finished2 := true
    Music.PlayFileStop
    finished1 := false
    finished2 := false
end loop
% *********** E N D     O F    P R O G R A M  ************
