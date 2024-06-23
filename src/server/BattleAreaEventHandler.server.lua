local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)
local teleportModel = game.Workspace.BattleArea.Teleport
local part = teleportModel.TouchPart
local openSound = part.Parent.Sounds.PortalOpen :: Sound
local playerDebounces = {}




-- Events

part.Touched:Connect(function(otherPart)

	local humanoid = utility.GetHumanoidFromPart(otherPart)
	local player = utility.GetPlayerFromHumanoid(humanoid)


	if player == nil then return end

	-- Debounce logic to check if player has already touched in the last 3 seconds.
	if playerDebounces[player.Name] == nil then

		playerDebounces[player.Name] = 0
		playerUtilities.DisablePlayerMovement(player)
		openSound:Play()
		utility.TeleportPlayerToBattleArea(player)
		wait(3)
		playerDebounces[player.Name] = nil

	end

end)
