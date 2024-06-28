local ReplicatedStorage = game:GetService("ReplicatedStorage")
local utility = require(ReplicatedStorage.UtilityModuleScript)


local fightZone1Model = game.Workspace.FreeForAllArea.FightZone :: Model
local touchPart1 = fightZone1Model.TouchPart
local invisibleBarrier1 = fightZone1Model.InvisibleBarrier

local fightZone1Players = {}

local fightZoneRemoteEvent = ReplicatedStorage.FightZoneRemoteEvent



-- Events

touchPart1.Touched:Connect(function(otherPart)

    local player = utility.GetPlayerFromPart(otherPart)
    
	if player == nil then return end

    local playerName = utility.GetPlayerName(player)
    
    if fightZone1Players[playerName] == nil then
		fightZone1Players[playerName] = 0
		fightZoneRemoteEvent:FireClient(player, otherPart)
	end

end)


invisibleBarrier1.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

    if fightZone1Players[playerName] ~= nil then
		fightZone1Players[playerName] = nil
		fightZoneRemoteEvent:FireClient(player, otherPart)
	end

end)
