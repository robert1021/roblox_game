module = {

}


function module.GetFightZoneFFA1ReadyButtonGui()
	return game.Players.LocalPlayer.PlayerGui:FindFirstChild("FightZoneFFA1ReadyButtonGui")
end

function module.GetFightZoneFFA1UnreadyButtonGui()
	return game.Players.LocalPlayer.PlayerGui:FindFirstChild("FightZoneFFA1UnreadyButtonGui")
end

function module.ToggleFightZoneFFA1ReadyButtonGui()
	local gui = module.GetFightZoneFFA1ReadyButtonGui()
	
	if gui then
		
		if gui.Enabled == true then
			gui.Enabled = false
		else
			gui.Enabled = true
		end
		
	end

end

function module.ToggleFightZoneFFA1UnreadyButtonGui()
	local gui = module.GetFightZoneFFA1UnreadyButtonGui()
	
	if gui then
		
		if gui.Enabled == true then
			gui.Enabled = false
		else
			gui.Enabled = true
		end
		
	end

end


return module