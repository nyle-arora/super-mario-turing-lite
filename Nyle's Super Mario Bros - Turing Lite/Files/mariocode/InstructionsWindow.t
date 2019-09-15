%procedure to display the instructions after user presses instructions button
proc displayInstructionsWindow
    %creates the instructions window
    var instructionsWin : int
    instructionsWin := Window.Open ("position:top;center,graphics:1009; 390,title:Instructions")
    %calls the instrucions from a text file
    var stream : int
    var text : string := "files/text/Instructions.txt"
    var lines : string
    open : stream, text, get
    if stream > 0 then
	loop
	    get : stream, lines : *
	    color (brightred)
	    colorback (black)
	    put lines
	    exit when eof (stream)
	end loop
	for i : 1 .. 3
	    put " "
	end for
	close : stream
    elsif stream > 0 then
	close : stream
    else
	put "Error, can't read instructions. Try again."
    end if
    var backbutton : int := GUI.CreateButton (500, 30, 0, "Back", backToIntro)
    % Window will continue until quit button is pressed
    loop
	exit when GUI.ProcessEvent or isInstructionsWindowOpen = false
    end loop
    % release the button
    GUI.Dispose (backbutton)
    %close/release the window
    Window.Close (instructionsWin)
end displayInstructionsWindow
