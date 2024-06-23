local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)
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
		-- TODO: Fix this later so the animation isnt stuck
		humanoid.RootPart.Anchored = true
		openSound:Play()
		utility.TeleportPlayerToBattleArea(player)
		wait(3)
		playerDebounces[player.Name] = nil
		humanoid.RootPart.Anchored = false

	end

end)
