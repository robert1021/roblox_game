local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {

}

function module.TeleportPlayer(areaID, player)
	local TeleportService = game:GetService("TeleportService")
	TeleportService:Teleport(areaID, player)
	
end

function module.TeleportPlayerToBattleArea(player)
    local utility = require(game:GetService("ReplicatedStorage").UtilityModuleScript)
	module.TeleportPlayer(utility.BattleAreaID, player)
end

function module.TeleportPlayerToTownArea(player)
    local utility = require(game:GetService("ReplicatedStorage").UtilityModuleScript)
	module.TeleportPlayer(utility.startAreaId, player)
end

function module.GetBattleAreaTeleportModel()
	return game.Workspace.BattleArea.Teleport
end

function module.GetTownAreaTeleportModel()
	return game.Workspace.TownArea.Teleport
end


return module