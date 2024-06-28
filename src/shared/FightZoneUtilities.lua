module = {

}

function module.GetFightZoneFFA1Model()
	return game.Workspace.FreeForAllArea.FightZoneFFA1
end

function module.GetFightZoneFFA2Model()
	return game.Workspace.FreeForAllArea.FightZoneFFA2
end

function module.GetFightZoneFFA3Model()
	return game.Workspace.FreeForAllArea.FightZoneFFA3
end

function module.GetFightZoneFFA4Model()
	return game.Workspace.FreeForAllArea.FightZoneFFA4
end


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

function module.GetFightZoneFFA2ReadyButtonGui()
	return game.Players.LocalPlayer.PlayerGui:FindFirstChild("FightZoneFFA2ReadyButtonGui")
end

function module.GetFightZoneFFA2UnreadyButtonGui()
	return game.Players.LocalPlayer.PlayerGui:FindFirstChild("FightZoneFFA2UnreadyButtonGui")
end

function module.ToggleFightZoneFFA2ReadyButtonGui()
	local gui = module.GetFightZoneFFA2ReadyButtonGui()
	
	if gui then
		
		if gui.Enabled == true then
			gui.Enabled = false
		else
			gui.Enabled = true
		end
		
	end

end

function module.ToggleFightZoneFFA2UnreadyButtonGui()
	local gui = module.GetFightZoneFFA2UnreadyButtonGui()
	
	if gui then
		
		if gui.Enabled == true then
			gui.Enabled = false
		else
			gui.Enabled = true
		end
		
	end

end


function module.GetFightZoneFFA3ReadyButtonGui()
	return game.Players.LocalPlayer.PlayerGui:FindFirstChild("FightZoneFFA3ReadyButtonGui")
end

function module.GetFightZoneFFA3UnreadyButtonGui()
	return game.Players.LocalPlayer.PlayerGui:FindFirstChild("FightZoneFFA3UnreadyButtonGui")
end

function module.ToggleFightZoneFFA3ReadyButtonGui()
	local gui = module.GetFightZoneFFA3ReadyButtonGui()
	
	if gui then
		
		if gui.Enabled == true then
			gui.Enabled = false
		else
			gui.Enabled = true
		end
		
	end

end

function module.ToggleFightZoneFFA3UnreadyButtonGui()
	local gui = module.GetFightZoneFFA3UnreadyButtonGui()
	
	if gui then
		
		if gui.Enabled == true then
			gui.Enabled = false
		else
			gui.Enabled = true
		end
		
	end

end

function module.GetFightZoneFFA4ReadyButtonGui()
	return game.Players.LocalPlayer.PlayerGui:FindFirstChild("FightZoneFFA4ReadyButtonGui")
end

function module.GetFightZoneFFA4UnreadyButtonGui()
	return game.Players.LocalPlayer.PlayerGui:FindFirstChild("FightZoneFFA4UnreadyButtonGui")
end

function module.ToggleFightZoneFFA4ReadyButtonGui()
	local gui = module.GetFightZoneFFA4ReadyButtonGui()
	
	if gui then
		
		if gui.Enabled == true then
			gui.Enabled = false
		else
			gui.Enabled = true
		end
		
	end

end

function module.ToggleFightZoneFFA4UnreadyButtonGui()
	local gui = module.GetFightZoneFFA4UnreadyButtonGui()
	
	if gui then
		
		if gui.Enabled == true then
			gui.Enabled = false
		else
			gui.Enabled = true
		end
		
	end

end

function module.ChangeFightZoneBaseMaterial(model, material)
	model.Base.Material = material
end

return module