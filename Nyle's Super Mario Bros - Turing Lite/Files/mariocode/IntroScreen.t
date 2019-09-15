%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%file that controls the programming of the intro screen 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main procedure to handle the intro window
procedure displayIntroWindow
    % flag that intro screen is open - global var isIntroWindowOpen
    isIntroWindowOpen := true
    % Open the window
    var winID : int
    winID := Window.Open ("position:top;center,graphics:600;400,title:Introduction Window")
    %Set Background Image
    var backgroundpic : int := Pic.FileNew ("files/images/castlebackground.jpg")
    Pic.Draw (backgroundpic, 0, 0, picXor)
    %Create title logo
    var logopic : int := Pic.FileNew ("files/images/Super_Mario_Bros.jpg")
    Pic.Draw (logopic, 200, 250, picCopy)
    locate (11, 36)
    colorback (black)
    color (white)
    put "Turing Lite"
    %create buttons
    var level1button : int := GUI.CreateButton (295, 190, 0, "Level 1", level1) 
    var level2button : int := GUI.CreateButton (295, 160, 0, "Level 2", level2) 
    var instructionsbutton : int := GUI.CreateButton (280, 130, 0, "Instructions", instructions)
    var quitIntroWindowButton := GUI.CreateButton (maxx - 100, 25, 0, "Close", QuitIntroWindowButtonPressed)

    % Window will continue until quit button is pressed
    loop
	exit when GUI.ProcessEvent or isIntroWindowOpen = false
    end loop
    % release the button
    GUI.Dispose (quitIntroWindowButton)
    GUI.Dispose (level1button) 
    GUI.Dispose (level2button)
    GUI.Dispose (instructionsbutton)
    %close the window 
    Window.Close (winID)
end displayIntroWindow
