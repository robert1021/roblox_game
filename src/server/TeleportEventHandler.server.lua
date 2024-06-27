local ReplicatedStorage = game:GetService("ReplicatedStorage")

local utility = require(ReplicatedStorage.UtilityModuleScript)
local teleportUtilities = require(ReplicatedStorage.TeleportUtilities)
local playerUtilities = require(ReplicatedStorage.PlayerUtilities)






-- Events

if utility.GetIsBattleArea() then
    local townplayerDebounces = {}
    local teleport = teleportUtilities.GetTownAreaTeleportModel()

    teleport.TouchPart.Touched:Connect(function(otherPart)

        local humanoid = utility.GetHumanoidFromPart(otherPart)
        local player = utility.GetPlayerFromHumanoid(humanoid)

        if player == nil then return end

        -- Debounce logic to check if player has already touched in the last 3 seconds.
        if townplayerDebounces[player.Name] == nil then

            townplayerDebounces[player.Name] = 0
            playerUtilities.DisablePlayerMovement(player)
            teleport.Sounds.PortalOpen:Play()
            teleportUtilities.TeleportPlayerToTownArea(player)
            wait(3)
            townplayerDebounces[player.Name] = nil

	    end

    end)

end


if utility.GetIsTownArea() then
    local playerDebounces = {}
    local teleport = teleportUtilities.GetBattleAreaTeleportModel()

    teleport.TouchPart.Touched:Connect(function(otherPart)

        local humanoid = utility.GetHumanoidFromPart(otherPart)
        local player = utility.GetPlayerFromHumanoid(humanoid)

        if player == nil then return end
 
        -- Debounce logic to check if player has already touched in the last 3 seconds.
        if playerDebounces[player.Name] == nil then

            playerDebounces[player.Name] = 0
            playerUtilities.DisablePlayerMovement(player)
            teleport.Sounds.PortalOpen:Play()
            teleportUtilities.TeleportPlayerToBattleArea(player)
            wait(3)
            playerDebounces[player.Name] = nil

	    end

    end)

end


