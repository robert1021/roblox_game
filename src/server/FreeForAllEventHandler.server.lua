local ReplicatedStorage = game:GetService("ReplicatedStorage")
local utility = require(ReplicatedStorage.UtilityModuleScript)



-- Events


if utility.GetIsBattleArea() then

	local fightZoneFFA1Model = game.Workspace.FreeForAllArea.FightZoneFFA1 :: Model
	local touchPart1 = fightZoneFFA1Model.TouchPart
	local invisibleBarrier1 = fightZoneFFA1Model.InvisibleBarrier
	local fightZone1Players = {}
	local fightZoneFFA1RemoteEvent = ReplicatedStorage.FightZoneFFA1RemoteEvent
	local fightZoneFFA1ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA1ReadyRemoteEvent
	local fightZoneFFA1UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA1UnreadyRemoteEvent
	local playersReadyFFA1 = {}

	local fightZoneFFA2Model = game.Workspace.FreeForAllArea.FightZoneFFA2 :: Model
	local touchPart2 = fightZoneFFA2Model.TouchPart
	local invisibleBarrier2 = fightZoneFFA2Model.InvisibleBarrier
	local fightZone2Players = {}
	local fightZoneFFA2RemoteEvent = ReplicatedStorage.FightZoneFFA2RemoteEvent
	local fightZoneFFA2ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA2ReadyRemoteEvent
	local fightZoneFFA2UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA2UnreadyRemoteEvent
	local playersReadyFFA2 = {}

	local fightZoneFFA3Model = game.Workspace.FreeForAllArea.FightZoneFFA3 :: Model
	local touchPart3 = fightZoneFFA3Model.TouchPart
	local invisibleBarrier3 = fightZoneFFA3Model.InvisibleBarrier
	local fightZone3Players = {}
	local fightZoneFFA3RemoteEvent = ReplicatedStorage.FightZoneFFA3RemoteEvent
	local fightZoneFFA3ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA3ReadyRemoteEvent
	local fightZoneFFA3UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA3UnreadyRemoteEvent
	local playersReadyFFA3 = {}

	local fightZoneFFA4Model = game.Workspace.FreeForAllArea.FightZoneFFA4 :: Model
	local touchPart4 = fightZoneFFA4Model.TouchPart
	local invisibleBarrier4 = fightZoneFFA4Model.InvisibleBarrier
	local fightZone4Players = {}
	local fightZoneFFA4RemoteEvent = ReplicatedStorage.FightZoneFFA4RemoteEvent
	local fightZoneFFA4ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA4ReadyRemoteEvent
	local fightZoneFFA4UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA4UnreadyRemoteEvent
	local playersReadyFFA4 = {}
		


		-- FFA Fight Zone 1

	touchPart1.Touched:Connect(function(otherPart)

		local player = utility.GetPlayerFromPart(otherPart)
		
		if player == nil then return end

		local playerName = utility.GetPlayerName(player)
		
		if fightZone1Players[playerName] == nil then
			fightZone1Players[playerName] = 0
			fightZoneFFA1RemoteEvent:FireClient(player, otherPart)
		end

	end)


	invisibleBarrier1.Touched:Connect(function(otherPart)

		local player = utility.GetPlayerFromPart(otherPart)

		if player == nil then return end

		local playerName = utility.GetPlayerName(player)

		if fightZone1Players[playerName] ~= nil then
			fightZone1Players[playerName] = nil
			fightZoneFFA1RemoteEvent:FireClient(player, otherPart)
		end

	end)


	fightZoneFFA1ReadyRemoteEvent.OnServerEvent:Connect(function(player)
		table.insert(playersReadyFFA1, player)
		fightZoneFFA1Model.Part.BillboardGui.TextLabel.Text = tostring(#playersReadyFFA1) .. " Players"
	end)


	fightZoneFFA1UnreadyRemoteEvent.OnServerEvent:Connect(function(player)
		table.remove(playersReadyFFA1, utility.GetIndexOfTableValue(playersReadyFFA1, player))
		fightZoneFFA1Model.Part.BillboardGui.TextLabel.Text = tostring(#playersReadyFFA1) .. " Players"
	end)


	-- FFA Fight Zone 2

	touchPart2.Touched:Connect(function(otherPart)

		local player = utility.GetPlayerFromPart(otherPart)
		
		if player == nil then return end

		local playerName = utility.GetPlayerName(player)
		
		if fightZone2Players[playerName] == nil then
			fightZone2Players[playerName] = 0
			fightZoneFFA2RemoteEvent:FireClient(player, otherPart)
		end

	end)


	invisibleBarrier2.Touched:Connect(function(otherPart)

		local player = utility.GetPlayerFromPart(otherPart)

		if player == nil then return end

		local playerName = utility.GetPlayerName(player)

		if fightZone2Players[playerName] ~= nil then
			fightZone2Players[playerName] = nil
			fightZoneFFA2RemoteEvent:FireClient(player, otherPart)
		end

	end)


	fightZoneFFA2ReadyRemoteEvent.OnServerEvent:Connect(function(player)
		table.insert(playersReadyFFA2, player)
		fightZoneFFA2Model.Part.BillboardGui.TextLabel.Text = tostring(#playersReadyFFA2) .. " Players"
	end)


	fightZoneFFA2UnreadyRemoteEvent.OnServerEvent:Connect(function(player)
		table.remove(playersReadyFFA2, utility.GetIndexOfTableValue(playersReadyFFA2, player))
		fightZoneFFA2Model.Part.BillboardGui.TextLabel.Text = tostring(#playersReadyFFA2) .. " Players"
	end)





	-- FFA Fight Zone 3

	touchPart3.Touched:Connect(function(otherPart)

		local player = utility.GetPlayerFromPart(otherPart)
		
		if player == nil then return end

		local playerName = utility.GetPlayerName(player)
		
		if fightZone3Players[playerName] == nil then
			fightZone3Players[playerName] = 0
			fightZoneFFA3RemoteEvent:FireClient(player, otherPart)
		end

	end)


	invisibleBarrier3.Touched:Connect(function(otherPart)

		local player = utility.GetPlayerFromPart(otherPart)

		if player == nil then return end

		local playerName = utility.GetPlayerName(player)

		if fightZone3Players[playerName] ~= nil then
			fightZone3Players[playerName] = nil
			fightZoneFFA3RemoteEvent:FireClient(player, otherPart)
		end

	end)


	fightZoneFFA3ReadyRemoteEvent.OnServerEvent:Connect(function(player)
		table.insert(playersReadyFFA3, player)
		fightZoneFFA3Model.Part.BillboardGui.TextLabel.Text = tostring(#playersReadyFFA3) .. " Players"
	end)


	fightZoneFFA3UnreadyRemoteEvent.OnServerEvent:Connect(function(player)
		table.remove(playersReadyFFA3, utility.GetIndexOfTableValue(playersReadyFFA3, player))
		fightZoneFFA3Model.Part.BillboardGui.TextLabel.Text = tostring(#playersReadyFFA3) .. " Players"
	end)




	-- FFA Fight Zone 4

	touchPart4.Touched:Connect(function(otherPart)

		local player = utility.GetPlayerFromPart(otherPart)
		
		if player == nil then return end

		local playerName = utility.GetPlayerName(player)
		
		if fightZone4Players[playerName] == nil then
			fightZone4Players[playerName] = 0
			fightZoneFFA4RemoteEvent:FireClient(player, otherPart)
		end

	end)


	invisibleBarrier4.Touched:Connect(function(otherPart)

		local player = utility.GetPlayerFromPart(otherPart)

		if player == nil then return end

		local playerName = utility.GetPlayerName(player)

		if fightZone4Players[playerName] ~= nil then
			fightZone4Players[playerName] = nil
			fightZoneFFA4RemoteEvent:FireClient(player, otherPart)
		end

	end)


	fightZoneFFA4ReadyRemoteEvent.OnServerEvent:Connect(function(player)
		table.insert(playersReadyFFA4, player)
		fightZoneFFA4Model.Part.BillboardGui.TextLabel.Text = tostring(#playersReadyFFA4) .. " Players"
	end)


	fightZoneFFA4UnreadyRemoteEvent.OnServerEvent:Connect(function(player)
		table.remove(playersReadyFFA4, utility.GetIndexOfTableValue(playersReadyFFA4, player))
		fightZoneFFA4Model.Part.BillboardGui.TextLabel.Text = tostring(#playersReadyFFA4) .. " Players"
	end)


end

