function onCreate()
	addHaxeLibrary('Character');
	runHaxeCode([[
		game = PlayState.instance;
		manxious = new Character(game.dad.x + 490, game.dad.y - 100, 'manxious');
		game.insert(game.members.indexOf(game.dadGroup) - 1, manxious);

		function isLooking(char) {
			return char.animation.name == "look" || char.animation.name == "idle-alt";
		}
	]]);
end

function onCreatePost()
	runHaxeCode([[
		skid = game.dad;
	]]);
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	note = 'notes.members['..id..']';
	if noteType == 'manxious' or noteType == 'manxious' then
		anim = getProperty('singAnimations['..direction..']');
		runHaxeCode([[
			//if(isLooking(manxious)) {
				manxious.idleSuffix = "";
			//}
			manxious.holdTimer = 0;
			manxious.playAnim(']]..anim..[[', true);
		]]);
	end

	if noteType == "manxious" then
		runHaxeCode([[
			skid.idleSuffix = "";
		]])
	end
end

function onEvent(name, val1, val2)
	if name == "Skid manxious Looking" then
		if val1 == "0" then
			runHaxeCode([[
				if(isLooking(skid)) {
					skid.playAnim("look2idle", true);
					skid.specialAnim = true;
					skid.idleSuffix = "";
				}
				if(isLooking(manxious)) {
					manxious.playAnim("look2idle", true);
					manxious.specialAnim = true;
					manxious.idleSuffix = "";
				}
			]])
		elseif val1 == "1" then
			runHaxeCode([[
				if(!isLooking(skid)) {
					skid.playAnim("look", true);
					skid.specialAnim = true;
					skid.idleSuffix = "-alt";
				}
				if(isLooking(manxious)) {
					manxious.playAnim("look2idle", true);
					manxious.specialAnim = true;
					manxious.idleSuffix = "";
				}
			]])
		elseif val1 == "2" then
			runHaxeCode([[
				if(isLooking(skid)) {
					skid.playAnim("look2idle", true);
					skid.specialAnim = true;
					skid.idleSuffix = "";
				}
				if(!isLooking(manxious)) {
					manxious.playAnim("look", true);
					manxious.specialAnim = true;
					manxious.idleSuffix = "-alt";
				}
			]])
		elseif val1 == "3" then
			runHaxeCode([[
				if(!isLooking(skid)) {
					skid.playAnim("look", true);
					skid.specialAnim = true;
					skid.idleSuffix = "-alt";
				}
				if(!isLooking(manxious)) {
					manxious.playAnim("look", true);
					manxious.specialAnim = true;
					manxious.idleSuffix = "-alt";
				}
			]])
		end
	end
end

function onCountdownTick(counter)
	if counter % 2 == 0 then
		manxiousDance();
	end
end

function onBeatHit()
	if curBeat % 2 == 0 then
		if not getProperty('inCutscene') then
			runHaxeCode([[
				singing = StringTools.startsWith(manxious.animation.curAnim.name, 'sing');
				if((singing && manxious.holdTimer > Conductor.stepCrochet * 0.0011 * manxious.singDuration) || !singing)
				{
					manxious.dance();
				}
			]]);
		end
	end
end

function manxiousDance()
	if not getProperty('inCutscene') then
		runHaxeCode([[
			manxious.dance();
		]]);
	end
end