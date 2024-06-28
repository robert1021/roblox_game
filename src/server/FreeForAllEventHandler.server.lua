local ReplicatedStorage = game:GetService("ReplicatedStorage")
local utility = require(ReplicatedStorage.UtilityModuleScript)


local fightZone1Model = game.Workspace.FreeForAllArea.FightZone :: Model
local touchPart1 = fightZone1Model.TouchPart
local invisibleBarrier1 = fightZone1Model.InvisibleBarrier

local fightZone1Players = {}

local fightZoneFFA1RemoteEvent = ReplicatedStorage.FightZoneFFA1RemoteEvent
local fightZoneFFA1ReadyRemoteEvent = ReplicatedStorage.FightZoneFFA1ReadyRemoteEvent
local fightZoneFFA1UnreadyRemoteEvent = ReplicatedStorage.FightZoneFFA1UnreadyRemoteEvent

local playersReadyCountFFA1 = 0


-- Events


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


fightZoneFFA1ReadyRemoteEvent.OnServerEvent:Connect(function()
	playersReadyCountFFA1 += 1
	fightZone1Model.Part.BillboardGui.TextLabel.Text = tostring(playersReadyCountFFA1) .. " Players"
end)


fightZoneFFA1UnreadyRemoteEvent.OnServerEvent:Connect(function()
	playersReadyCountFFA1 -= 1
	fightZone1Model.Part.BillboardGui.TextLabel.Text = tostring(playersReadyCountFFA1) .. " Players"
end)


-- FFA Fight Zone 2







-- FFA Fight Zone 3






-- FFA Fight Zone 4