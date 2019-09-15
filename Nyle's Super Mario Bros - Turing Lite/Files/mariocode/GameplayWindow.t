%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%file that controls all the actual gameplay of the program 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%declare background and text color
color (white)
colorback (black)
%first level gameplay
procedure Level1
    %open gameplay window
    var gameWin : int
    gameWin := Window.Open ("position:top;center,graphics:600;400,title:Gameplay Window")
    %coordinates for mario sprite
    var mariox : int := 175
    var marioy : int := 140
    %coordinates for bowser sprite
    var bowserx : int := 475
    var bowsery : int := 140
    %used to determine which direction Bowser will move (this variable is set to an random integer in the loop to randomize bowser's movements
    var direction : int
    %coordinates of the black box that is drawn over the bridge to make it look like it is disappearing
    var boxx1 : int := 558
    var boxy1 : int := 85
    var boxx2 : int := 563
    var boxy2 : int := 125
    %creates the font for the "You win!" and "Game over" text
    var winfont := Font.New ("Mono:25")
    %used for Mario's movements
    var chars : array char of boolean
    % create bridge ax sprite
    var axepic : int := Pic.FileNew ("files/images/Bridge_Axe.jpg")
    var axesprite : int := Sprite.New (axepic)
    Sprite.SetPosition (axesprite, 575, 150, centered)
    Sprite.SetHeight (axesprite, 3)
    Sprite.Show (axesprite)
    % create bridge chain sprite
    var chainpic : int := Pic.FileNew ("files/images/Bridge-Axe Chain.jpg")
    var chainsprite : int := Sprite.New (chainpic)
    Sprite.SetPosition (chainsprite, 540, 140, centered)
    Sprite.SetHeight (chainsprite, 2)
    Sprite.Show (chainsprite)
    % cover up the chain after win
    var coverpic : int := Pic.FileNew ("files/images/chaincover.jpg")
    var coversprite : int := Sprite.New (coverpic)
    Sprite.SetPosition (coversprite, 540, 140, centered)
    Sprite.SetHeight (coversprite, 2)
    %create standing Mario Sprite facing right
    var mariostandpic : int := Pic.FileNew ("files/images/Mario8BitSprite.jpg")
    var mariostandsprite : int := Sprite.New (mariostandpic)
    Sprite.SetPosition (mariostandsprite, mariox, marioy, centered)
    Sprite.SetHeight (mariostandsprite, 3)
    Sprite.Show (mariostandsprite)
    %create Mario run right pic
    var mariorunpic : int := Pic.FileNew ("files/images/mariojpgspriteresized1.jpg")
    %create Mario facing left pic
    var mariofaceleftpic : int := Pic.FileNew ("files/images/MarioFaceLeft.jpg")
    %create Mario running left pic
    var mariorunleftpic : int := Pic.FileNew ("files/images/MarioRunLeft.jpg")
    %create Bowser facing left sprite
    var bowserpic : int := Pic.FileNew ("files/images/Bowser_Sprite.jpg")
    var bowsersprite := Sprite.New (bowserpic)
    Sprite.SetPosition (bowsersprite, bowserx, bowsery, centered)
    Sprite.SetHeight (bowsersprite, 3)
    Sprite.Show (bowsersprite)
    %create Bowser facing left pic
    var bowserleftpic : int := Pic.FileNew ("files/images/Bowser_Left.jpg")
    %Set Background Image
    var backgroundpic : int := Pic.FileNew ("files/images/castlebackground.jpg")
    Pic.Draw (backgroundpic, 0, 0, picXor)
    %main loop that directs all the gameplay
    loop
	Input.KeyDown (chars)
	%stops the game when Mario sprite leaves the bridge
	exit when mariox < 70
	%stops the game when Mario sprite reaches the axe
	exit when mariox >= 575
	%stops the game when Mario touches Bowser
	exit when mariox >= bowserx - 45 and mariox <= bowserx + 40 and marioy >= bowsery - 10 and marioy <= bowsery + 10
	%makes Bowser face whichever side Mario is on
	if bowserx < mariox then
	    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
	elsif bowserx > mariox then
	    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
	end if
	%controls all of Bowser's movements
	direction := Rand.Int (1, 9)
	%I have 4 different numbers associated with Bowser moving forward to lower the probability of Bowser jumping, which has no exit statement and will make Mario's movements laggy
	if direction = 1 or direction = 4 or direction = 5 or direction = 6 then
	    loop
		%stops Bowser at a certain point on the bridge
		exit when bowserx = 400
		%exits whenever Mario moves to eliminate lag on Mario's movements
		exit when chars (KEY_UP_ARROW)
		exit when chars (KEY_LEFT_ARROW)
		exit when chars (KEY_RIGHT_ARROW)
		exit when chars (KEY_UP_ARROW) and chars (KEY_RIGHT_ARROW)
		exit when chars (KEY_UP_ARROW) and chars (KEY_LEFT_ARROW)
		exit when mariox >= bowserx - 45 and mariox <= bowserx + 40 and bowsery = 140
		delay (40)
		bowserx := bowserx - 5
		%make Bowser face whichever side Mario is on
		if bowserx < mariox then
		    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
		elsif bowserx > mariox then
		    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
		end if
	    end loop
	end if
	%I have 4 different numbers associated with Bowser moving backward to lower the porbability of Bowser jumping, which has no exit statement and will make Mario's movements laggy
	if direction = 2 or direction = 7 or direction = 8 or direction = 9 then
	    loop
		%exits when Bowser is at a certain point at the bridge
		exit when bowserx = 485
		%exits when Mario moves to eliminate lag on Mario's movements
		exit when chars (KEY_UP_ARROW)
		exit when chars (KEY_LEFT_ARROW)
		exit when chars (KEY_RIGHT_ARROW)
		exit when chars (KEY_UP_ARROW) and chars (KEY_RIGHT_ARROW)
		exit when chars (KEY_UP_ARROW) and chars (KEY_LEFT_ARROW)
		exit when mariox >= bowserx - 45 and mariox <= bowserx + 40 and bowsery = 140
		delay (40)
		bowserx := bowserx + 5
		%make Bowser face whichever side Mario is on
		if bowserx < mariox then
		    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
		elsif bowserx > mariox then
		    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
		end if
	    end loop
	end if
	%makes Bowser jump
	if direction = 3 then
	    loop
		exit when bowsery = 250
		delay (20)
		bowsery := bowsery + 10
		if bowserx < mariox then
		    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
		elsif bowserx > mariox then
		    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
		end if
	    end loop
	    loop
		exit when bowsery = 140
		exit when mariox >= bowserx - 45 and mariox <= bowserx + 40 and bowsery = 140
		delay (20)
		bowsery := bowsery - 10
		if bowserx < mariox then
		    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
		elsif
			bowserx > mariox then
		    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
		end if
	    end loop
	end if
	%makes Mario jump forward
	if chars (KEY_UP_ARROW) and chars (KEY_RIGHT_ARROW) then
	    for i : 1 .. 9
		delay (1)
		marioy := marioy + 10
		mariox := mariox + 10
		Sprite.Animate (mariostandsprite, mariorunpic, mariox, marioy, centered)
	    end for
	    for i : 1 .. 9
		delay (40)
		marioy := marioy - 10
		mariox := mariox + 10
		Sprite.Animate (mariostandsprite, mariostandpic, mariox, marioy, centered)
	    end for
	end if
	%makes Mario jump backwards
	if chars (KEY_UP_ARROW) and chars (KEY_LEFT_ARROW) then
	    for i : 1 .. 9
		delay (1)
		marioy := marioy + 10
		mariox := mariox - 10
		Sprite.Animate (mariostandsprite, mariorunleftpic, mariox, marioy, centered)
	    end for
	    for i : 1 .. 9
		delay (40)
		marioy := marioy - 10
		mariox := mariox - 10
		Sprite.Animate (mariostandsprite, mariofaceleftpic, mariox, marioy, centered)
	    end for
	end if
	%makes Mario jump up
	if chars (KEY_UP_ARROW) then
	    for i : 1 .. 9
		delay (20)
		marioy := marioy + 10
		Sprite.Animate (mariostandsprite, mariorunpic, mariox, marioy, centered)
	    end for
	    for i : 1 .. 9
		delay (20)
		marioy := marioy - 10
		Sprite.Animate (mariostandsprite, mariostandpic, mariox, marioy, centered)
	    end for
	end if
	%makes Mario run forward
	if chars (KEY_RIGHT_ARROW) then
	    for i : 1 .. 3
		delay (15)
		mariox := mariox + 5
		Sprite.Animate (mariostandsprite, mariorunpic, mariox, marioy, centered)
	    end for
	    Sprite.ChangePic (mariostandsprite, mariostandpic)
	end if
	%makes Mario run backwards
	if chars (KEY_LEFT_ARROW) then
	    for i : 1 .. 3
		delay (15)
		mariox := mariox - 5
		Sprite.Animate (mariostandsprite, mariorunleftpic, mariox, marioy, centered)
	    end for
	    Sprite.ChangePic (mariostandsprite, mariofaceleftpic)
	end if
    end loop
    %creates a Game Over if Mario runs off the bridge
    if mariox < 70 then
	for i : 1 .. 17
	    delay (40)
	    marioy := marioy - 5
	    Sprite.Animate (mariostandsprite, mariofaceleftpic, mariox, marioy, centered)
	end for
	Font.Draw ("GAME OVER!", 255, 255, winfont, white)
	var backbutton : int := GUI.CreateButton (300, 200, 0, "Back", backToIntro)
	loop
	    exit when GUI.ProcessEvent or isLevel1Chosen = false
	end loop
	GUI.Dispose (backbutton)
	Sprite.Free (mariostandsprite)
	Sprite.Free (bowsersprite)
	Sprite.Free (axesprite)
	Sprite.Free (chainsprite)
	Sprite.Free (coversprite)
	Window.Close (gameWin)
    end if
    %creaates a win if Mario reaches the axe on the end of the bridge
    if mariox > 575 then
	mariox := 575
	marioy := 155
	Sprite.Animate (mariostandsprite, mariofaceleftpic, mariox, marioy, centered)
	Sprite.Show (coversprite)
	for i : 1 .. 41
	    Draw.FillBox (boxx1, boxy1, boxx2, boxy2, black)
	    delay (150)
	    boxx1 := boxx1 - 10
	end for
	for i : 1 .. 35
	    delay (40)
	    bowsery := bowsery - 5
	    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
	end for
	Font.Draw ("YOU WIN!", 255, 255, winfont, white)
	var backbutton : int := GUI.CreateButton (300, 200, 0, "Back", backToIntro)
	loop
	    exit when GUI.ProcessEvent or isLevel1Chosen = false
	end loop
	GUI.Dispose (backbutton)
	Sprite.Free (mariostandsprite)
	Sprite.Free (bowsersprite)
	Sprite.Free (axesprite)
	Sprite.Free (chainsprite)
	Sprite.Free (coversprite)
	Window.Close (gameWin)
    end if
    %creates a game over if Mario touches Bowser
    if mariox >= bowserx - 45 and mariox <= bowserx + 40 and marioy >= bowsery - 10 and marioy <= bowsery + 10 then
	var backbutton : int := GUI.CreateButton (300, 200, 0, "Back", backToIntro)
	Font.Draw ("GAME OVER!", 255, 255, winfont, white)
	loop
	    exit when GUI.ProcessEvent or isLevel1Chosen = false
	end loop
	GUI.Dispose (backbutton)
	Sprite.Free (mariostandsprite)
	Sprite.Free (bowsersprite)
	Sprite.Free (axesprite)
	Sprite.Free (chainsprite)
	Sprite.Free (coversprite)
	Window.Close (gameWin)
    end if
end Level1
%second level gameplay
procedure Level2
    %creates a new window for the gameplay
    var gameWin : int
    gameWin := Window.Open ("position:top;center,graphics:600;400,title:Gameplay Window")
    %coordinates for the Mario sprite
    var mariox : int := 175
    var marioy : int := 140
    %coordinates for the Bowser sprite
    var bowserx : int := 475
    var bowsery : int := 140
    %controls the direction Bowser moves in - this variable is randomized in the loop to make Bowser's movements random
    var direction : int
    %sets coordinates for the fireball sprite from Bowser's mouth
    var fireballx : int := bowserx - 20
    var firebally : int := bowsery + 10
    %sets coordinates for the black box that is drawn over the bridge to make it look like it is disappearing
    var boxx1 : int := 558
    var boxy1 : int := 85
    var boxx2 : int := 563
    var boxy2 : int := 125
    %sets the font for the "You win!" and the "Game over!" screen
    var winfont := Font.New ("Mono:25")
    %is used to move Mario with the arrow keys
    var chars : array char of boolean
    % create bridge ax sprite
    var axepic : int := Pic.FileNew ("files/images/Bridge_Axe.jpg")
    var axesprite : int := Sprite.New (axepic)
    Sprite.SetPosition (axesprite, 575, 150, centered)
    Sprite.SetHeight (axesprite, 3)
    Sprite.Show (axesprite)
    % create bridge chain sprite
    var chainpic : int := Pic.FileNew ("files/images/Bridge-Axe Chain.jpg")
    var chainsprite : int := Sprite.New (chainpic)
    Sprite.SetPosition (chainsprite, 540, 140, centered)
    Sprite.SetHeight (chainsprite, 2)
    Sprite.Show (chainsprite)
    % cover up the chain after win
    var coverpic : int := Pic.FileNew ("files/images/chaincover.jpg")
    var coversprite : int := Sprite.New (coverpic)
    Sprite.SetPosition (coversprite, 540, 140, centered)
    Sprite.SetHeight (coversprite, 2)
    %create standing Mario Sprite facing right
    var mariostandpic : int := Pic.FileNew ("files/images/Mario8BitSprite.jpg")
    var mariostandsprite : int := Sprite.New (mariostandpic)
    Sprite.SetPosition (mariostandsprite, mariox, marioy, centered)
    Sprite.SetHeight (mariostandsprite, 3)
    Sprite.Show (mariostandsprite)
    %create Mario run right pic
    var mariorunpic : int := Pic.FileNew ("files/images/mariojpgspriteresized1.jpg")
    %create Mario facing left pic
    var mariofaceleftpic : int := Pic.FileNew ("files/images/MarioFaceLeft.jpg")
    %create Mario running left pic
    var mariorunleftpic : int := Pic.FileNew ("files/images/MarioRunLeft.jpg")
    %create Bowser facing left sprite
    var bowserpic : int := Pic.FileNew ("files/images/Bowser_Sprite.jpg")
    var bowsersprite := Sprite.New (bowserpic)
    Sprite.SetPosition (bowsersprite, bowserx, bowsery, centered)
    Sprite.SetHeight (bowsersprite, 3)
    Sprite.Show (bowsersprite)
    %create Bowser facing left pic
    var bowserleftpic : int := Pic.FileNew ("files/images/Bowser_Left.jpg")
    %fireball sprite
    var firepic : int := Pic.FileNew ("files/images/Fireball.gif")
    var firesprite := Sprite.New (firepic)
    Sprite.SetPosition (firesprite, fireballx, firebally, centered)
    Sprite.SetHeight (firesprite, 4)
    %Set Background Image
    var backgroundpic : int := Pic.FileNew ("files/images/castlebackground.jpg")
    Pic.Draw (backgroundpic, 0, 0, picXor)
    %main loop that runs all the gameplay
    loop
	Input.KeyDown (chars)
	%ends the game when Mario runs off the bridge
	exit when mariox < 70
	%ends the game when Mario reaches the axe that collapses the bridge
	exit when mariox >= 575
	%ends the game when Mario touches Bowser
	exit when mariox >= bowserx - 45 and mariox <= bowserx + 40 and marioy >= bowsery - 10 and marioy <= bowsery + 10
	%ends the game when Mario is hit by a fireball
	exit when mariox >= fireballx - 30 and mariox <= fireballx + 30 and marioy >= firebally - 10 and marioy <= firebally + 10
	%makes Bowser face in Mario's direction
	if bowserx < mariox then
	    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
	elsif bowserx > mariox then
	    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
	    %animate the fireballs to move forward
	    Sprite.Show (firesprite)
	    Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
	    fireballx := fireballx - 5
	    %once the fireball sprite leaves the screen, the coordinates a reset to start again from Bowser's mouth
	    if fireballx < -100 then
		fireballx := bowserx - 10
		firebally := bowsery + 10
	    end if
	end if
	%randomizing the direction of Bowser's moveemtns
	direction := Rand.Int (1, 9)
	%making Bowser move forward
	if direction = 1 or direction = 4 or direction = 5 or direction = 6 then
	    loop
		exit when bowserx = 400
		exit when chars (KEY_UP_ARROW)
		exit when chars (KEY_LEFT_ARROW)
		exit when chars (KEY_RIGHT_ARROW)
		exit when chars (KEY_UP_ARROW) and chars (KEY_RIGHT_ARROW)
		exit when chars (KEY_UP_ARROW) and chars (KEY_LEFT_ARROW)
		exit when mariox >= bowserx - 45 and mariox <= bowserx + 40 and bowsery = 140
		delay (40)
		bowserx := bowserx - 5
		if bowserx < mariox then
		    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
		elsif bowserx > mariox then
		    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
		    Sprite.Show (firesprite)
		    Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		    fireballx := fireballx - 5
		    if fireballx < -100 then
			fireballx := bowserx - 10
			firebally := bowsery + 10
		    end if
		end if
	    end loop
	end if
	%making Bowser move backwards
	if direction = 2 or direction = 7 or direction = 8 or direction = 9 then
	    loop
		exit when bowserx = 485
		exit when chars (KEY_UP_ARROW)
		exit when chars (KEY_LEFT_ARROW)
		exit when chars (KEY_RIGHT_ARROW)
		exit when chars (KEY_UP_ARROW) and chars (KEY_RIGHT_ARROW)
		exit when chars (KEY_UP_ARROW) and chars (KEY_LEFT_ARROW)
		exit when mariox >= bowserx - 45 and mariox <= bowserx + 40 and bowsery = 140
		delay (40)
		bowserx := bowserx + 5
		if bowserx < mariox then
		    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
		elsif bowserx > mariox then
		    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
		    Sprite.Show (firesprite)
		    Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		    fireballx := fireballx - 5
		    if fireballx < -100 then
			fireballx := bowserx - 10
			firebally := bowsery + 10
		    end if
		end if
	    end loop
	end if
	%making Bowser jump up
	if direction = 3 then
	    loop
		exit when bowsery = 250
		delay (20)
		bowsery := bowsery + 10
		if bowserx < mariox then
		    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
		elsif bowserx > mariox then
		    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
		    Sprite.Show (firesprite)
		    Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		    fireballx := fireballx - 5
		    if fireballx < -100 then
			fireballx := bowserx - 10
			firebally := bowsery + 10
		    end if
		end if
	    end loop
	    loop
		exit when bowsery = 140
		exit when mariox >= bowserx - 45 and mariox <= bowserx + 40 and bowsery = 140
		delay (20)
		bowsery := bowsery - 10
		if bowserx < mariox then
		    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
		elsif
			bowserx > mariox then
		    Sprite.Animate (bowsersprite, bowserpic, bowserx, bowsery, centered)
		end if
	    end loop
	end if
	%making Mario jump forward
	if chars (KEY_UP_ARROW) and chars (KEY_RIGHT_ARROW) then
	    for i : 1 .. 9
		delay (1)
		marioy := marioy + 10
		mariox := mariox + 10
		Sprite.Animate (mariostandsprite, mariorunpic, mariox, marioy, centered)
		Sprite.Show (firesprite)
		Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		fireballx := fireballx - 5
		if fireballx < -100 then
		    fireballx := bowserx - 10
		    firebally := bowsery + 10
		end if
	    end for
	    for i : 1 .. 9
		delay (40)
		marioy := marioy - 10
		mariox := mariox + 10
		Sprite.Animate (mariostandsprite, mariostandpic, mariox, marioy, centered)
		Sprite.Show (firesprite)
		Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		fireballx := fireballx - 5
		if fireballx < -100 then
		    fireballx := bowserx - 10
		    firebally := bowsery + 10
		end if
	    end for
	end if
	%making Mario jump backwards
	if chars (KEY_UP_ARROW) and chars (KEY_LEFT_ARROW) then
	    for i : 1 .. 9
		delay (1)
		marioy := marioy + 10
		mariox := mariox - 10
		Sprite.Animate (mariostandsprite, mariorunleftpic, mariox, marioy, centered)
		Sprite.Show (firesprite)
		Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		fireballx := fireballx - 5
		if fireballx < -100 then
		    fireballx := bowserx - 10
		    firebally := bowsery + 10
		end if
	    end for
	    for i : 1 .. 9
		delay (40)
		marioy := marioy - 10
		mariox := mariox - 10
		Sprite.Animate (mariostandsprite, mariofaceleftpic, mariox, marioy, centered)
		Sprite.Show (firesprite)
		Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		fireballx := fireballx - 5
		if fireballx < -100 then
		    fireballx := bowserx - 10
		    firebally := bowsery + 10
		end if
	    end for
	end if
	%making Mario jump up
	if chars (KEY_UP_ARROW) then
	    for i : 1 .. 9
		delay (20)
		marioy := marioy + 10
		Sprite.Animate (mariostandsprite, mariorunpic, mariox, marioy, centered)
		Sprite.Show (firesprite)
		Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		fireballx := fireballx - 5
		if fireballx < -100 then
		    fireballx := bowserx - 10
		    firebally := bowsery + 10
		end if
	    end for
	    for i : 1 .. 9
		delay (20)
		marioy := marioy - 10
		Sprite.Animate (mariostandsprite, mariostandpic, mariox, marioy, centered)
		Sprite.Show (firesprite)
		Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		fireballx := fireballx - 5
		if fireballx < -100 then
		    fireballx := bowserx - 10
		    firebally := bowsery + 10
		end if
	    end for
	end if
	%making Mario run forward
	if chars (KEY_RIGHT_ARROW) then
	    for i : 1 .. 3
		delay (15)
		mariox := mariox + 5
		Sprite.Animate (mariostandsprite, mariorunpic, mariox, marioy, centered)
		Sprite.Show (firesprite)
		Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		fireballx := fireballx - 5
		if fireballx < -100 then
		    fireballx := bowserx - 10
		    firebally := bowsery + 10
		end if
	    end for
	    Sprite.ChangePic (mariostandsprite, mariostandpic)
	end if
	%making Mario run backwards
	if chars (KEY_LEFT_ARROW) then
	    for i : 1 .. 3
		delay (15)
		mariox := mariox - 5
		Sprite.Animate (mariostandsprite, mariorunleftpic, mariox, marioy, centered)
		Sprite.Show (firesprite)
		Sprite.Animate (firesprite, firepic, fireballx, firebally, centered)
		fireballx := fireballx - 5
		if fireballx < -100 then
		    fireballx := bowserx - 10
		    firebally := bowsery + 10
		end if
	    end for
	    Sprite.ChangePic (mariostandsprite, mariofaceleftpic)
	end if
    end loop
    %making a game over when Mario runs off the bridge 
    if mariox < 70 then
	for i : 1 .. 17
	    delay (40)
	    marioy := marioy - 5
	    Sprite.Animate (mariostandsprite, mariofaceleftpic, mariox, marioy, centered)
	end for
	Font.Draw ("GAME OVER!", 255, 255, winfont, white)
	var backbutton : int := GUI.CreateButton (300, 200, 0, "Back", backToIntro)
	loop
	    exit when GUI.ProcessEvent or isLevel2Chosen = false
	end loop
	GUI.Dispose (backbutton)
	Sprite.Free (mariostandsprite)
	Sprite.Free (bowsersprite)
	Sprite.Free (firesprite)
	Sprite.Free (axesprite)
	Sprite.Free (chainsprite)
	Sprite.Free (coversprite)
	Window.Close (gameWin)
    end if
    %making Mario win when he reaches the axe that touches Bowser 
    if mariox > 575 then
	mariox := 575
	marioy := 155
	Sprite.Animate (mariostandsprite, mariofaceleftpic, mariox, marioy, centered)
	Sprite.Show (coversprite)
	for i : 1 .. 41
	    Draw.FillBox (boxx1, boxy1, boxx2, boxy2, black)
	    delay (150)
	    boxx1 := boxx1 - 10
	end for
	for i : 1 .. 35
	    delay (40)
	    bowsery := bowsery - 5
	    Sprite.Animate (bowsersprite, bowserleftpic, bowserx, bowsery, centered)
	end for
	Font.Draw ("YOU WIN!", 255, 255, winfont, white)
	var backbutton : int := GUI.CreateButton (300, 200, 0, "Back", backToIntro)
	loop
	    exit when GUI.ProcessEvent or isLevel2Chosen = false
	end loop
	GUI.Dispose (backbutton)
	Sprite.Free (mariostandsprite)
	Sprite.Free (bowsersprite)
	Sprite.Free (firesprite)
	Sprite.Free (axesprite)
	Sprite.Free (chainsprite)
	Sprite.Free (coversprite)
	Window.Close (gameWin)
    end if
    %making a game over when Mario touches Bowser
    if mariox >= bowserx - 45 and mariox <= bowserx + 40 and marioy >= bowsery - 10 and marioy <= bowsery + 10 then
	var backbutton : int := GUI.CreateButton (300, 200, 0, "Back", backToIntro)
	Font.Draw ("GAME OVER!", 255, 255, winfont, white)
	loop
	    exit when GUI.ProcessEvent or isLevel2Chosen = false
	end loop
	GUI.Dispose (backbutton)
	Sprite.Free (mariostandsprite)
	Sprite.Free (bowsersprite)
	Sprite.Free (firesprite)
	Sprite.Free (axesprite)
	Sprite.Free (chainsprite)
	Sprite.Free (coversprite)
	Window.Close (gameWin)
    end if
    %making a game over if Mario is hit by a fireball
    if mariox >= fireballx - 30 and mariox <= fireballx + 30 and marioy >= firebally - 10 and marioy <= firebally + 10 then
	var backbutton : int := GUI.CreateButton (300, 200, 0, "Back", backToIntro)
	Font.Draw ("GAME OVER!", 255, 255, winfont, white)
	loop
	    exit when GUI.ProcessEvent or isLevel2Chosen = false
	end loop
	GUI.Dispose (backbutton)
	Sprite.Free (mariostandsprite)
	Sprite.Free (bowsersprite)
	Sprite.Free (firesprite)
	Sprite.Free (axesprite)
	Sprite.Free (chainsprite)
	Sprite.Free (coversprite)
	Window.Close (gameWin)
    end if
end Level2
