
local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and not isStoryMode and not seenCutscene then
		setProperty('inCutscene', true)

		startDialogue('dialogue', 'dialogueAmbience1')

		allowCountdown = true
		return Function_Stop
	end
	runTimer("closeScript", 0.1)
	return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'closeScript' then -- Timer completed, play dialogue
		close(true)
	end
end

function onNextDialogue(count)

end

function onSkipDialogue(count)

end
function onCreate()
	setPropertyFromClass('states.substates.GameOverSubstate', 'characterName', 'bf-playerace');
	setPropertyFromClass('states.substates.GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx');
	setPropertyFromClass('states.substates.GameOverSubstate', 'loopSoundName', 'gameOver');
	setPropertyFromClass('states.substates.GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty("boyfriendCameraOffset", {-285, 30})
	setProperty("opponentCameraOffset", {350, 0})
	cameraUpdateCamera()
end