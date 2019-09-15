% Button File - code to handle button events
% Intro Window Procedures
procedure QuitIntroWindowButtonPressed
    isIntroWindowOpen := false
    GUI.Quit
    GUI.ResetQuit
end QuitIntroWindowButtonPressed
%Level 1 Procedure
proc level1
    QuitIntroWindowButtonPressed
    isLevel1Chosen := true
end level1
%Level 2 procedure
proc level2
    QuitIntroWindowButtonPressed
    isLevel2Chosen := true
end level2
%Instructions procedure
proc instructions
    QuitIntroWindowButtonPressed
    isInstructionsWindowOpen := true
end instructions
%return to intro screen after reading instructions
proc backToIntro
    isInstructionsWindowOpen := false
    isLevel1Chosen := false
    isLevel2Chosen := false
    GUI.Quit
    GUI.ResetQuit
    isIntroWindowOpen := true
end backToIntro
