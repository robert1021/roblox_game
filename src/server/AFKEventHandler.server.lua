local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)
-- afk
local afkModel = game.Workspace.AFKArea.Model
local afkZonePart = afkModel.AFKZone.Part
local afkBoundary = afkZonePart.Parent.Boundary

local players = {}
local afkAreaRemoveEvent = ReplicatedStorage.AFKAreaRemoteEvent


-- Events

afkZonePart.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if players[playerName] == nil then
		players[playerName] = 0
		afkAreaRemoveEvent:FireClient(player, afkZonePart)
	end

end)


afkBoundary.Touched:Connect(function(otherPart)

	local player = utility.GetPlayerFromPart(otherPart)

	if player == nil then return end

	local playerName = utility.GetPlayerName(player)

	if players[playerName] ~= nil then
		players[playerName] = nil
		afkAreaRemoveEvent:FireClient(player, afkZonePart)
	end

end)